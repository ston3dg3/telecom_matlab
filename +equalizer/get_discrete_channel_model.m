function [discrete_pulse,sigma2_rx] = get_discrete_channel_model(n_os,tx_pulse,rx_pulse,channel_pulse,filterspan_pulse,sigma2_ch)
%GET_DISCRETE_CHANNEL_MODEL Summary of this function goes here
% outputs the sampled system impulse response of (5.33). The n_os denotes the
% oversampling factor at which the impulse responses are represented. tx_pulse,
% rx_pulse and channel_pulse denote the impulse responses of the transmit pulse,
% receive filter and the channel, respectively. Note that the impulse response of the
% channel is already given in the equivalent baseband regime. filterspan_pulse
% denotes the filterspan of the transmit and receive filter and might help to find the
% optimal sampling points. sigma2_ch is the variance of the noise added to the signal
% in the oversampled domain. The output discrete_pulse is the sampled system
% impulse response. Take care that the length is 2L + 1. If the length after sampling
% does not fit 2L + 1 you might pad the impulse response with zeros at the end.
% sigma2 rx is the variance of the filtered noise at the receiver.

% USEFUL EQUATIONS:
% N'(t) = (N(t) * h_r(t))(t)
% h(t) = (g * h_LP * h_r)(t)

% =========== redefine impulse responses to fit the equations
g = tx_pulse; % size: filterspan*n_os
h_LP = channel_pulse; %size:
h_r = rx_pulse; % size: filterspan*n_os

% =========== calculate h(t)
h1 = conv(g, h_LP);
h = conv(h1, h_r);

% =========== Determine the length of the discrete pulse
L = floor(filterspan_pulse / (2 * n_os));

% =========== Sample the system impulse response
discrete_pulse = h(1:n_os:end);

% =========== pad the discrete pulse with zeros if not of length 2L+1
if length(discrete_pulse) < 2*L + 1
    discrete_pulse = [discrete_pulse, zeros(1, 2*L + 1 - length(discrete_pulse))];
end

% =========== calcuate new noise and its sigma
N = sigma2_ch*sigma2_ch * randn(1, length(h)+length(h_r)-1);
N_ = conv(N, h_r);
sigma2_rx = std(N_);



end

