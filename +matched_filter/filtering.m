function [y_os,t] = filtering(r, mf_pulse, n_os, symbol_rate)
%%FILTERING Summary of this function goes here
%   Detailed explanation goes here
    y_os = zeros(1,length(mf_pulse)+length(r)-1);
    t = zeros(size(y_os));

    % the filtered signal is a convolution of the receive signal and the
    % receiver matched filter.
    y_os = conv(r, mf_pulse);
    % y_os = newconv(r, mf_pulse, y_os, n_os);


    % y_os = circshift(y_os, -n_os);

    % time period between pulses in seconds
    T = 1/symbol_rate;
    % time period between oversampled pulses in seconds
    T_os = T/n_os;

    % =======================================
    % change time vectors
    t = linspace(0,T_os*length(y_os), length(y_os));

    % Funktioniert (?)
end