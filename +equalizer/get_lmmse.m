function [w] = get_lmmse(system_impulse_response,K,sigma2)
%GET_LMMSE Summary of this function goes here
%   outputs the filter coefficients of the LMMSE equalizer with length 2K + 1.
%   system impulse response denotes the sampled system impulse response. sigma2
%   denotes the variance of the filtered noise

% important equations
% C_n = var * I_2K+1  

% initialise important variables
w = zeros(1,2*K+1);
len = length(system_impulse_response);
L = (len)/2;

% get C_n
C_n = sigma2 * sigma2 * eye(2*K + 1);

% get the channel matrix (H)
H = zeros(2*K+1, 2*(K+L)+1);
j=1;
for i=1:size(H,1)
    H(i, j:j+len-1) = system_impulse_response;
    j = j + 1;
end

% get the filter coefficients vector
new_H = inv(H*H' + C_n) * H;
w(:) = new_H(:, K+L+1);

% testing
% disp(H);
% disp(C_n);
% disp(w);

end

