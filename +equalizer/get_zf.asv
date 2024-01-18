function [w] = get_zf(system_impulse_response,K)
%GET_ZF Summary of this function goes here
%  outputs the filter coefficients of the zero-forcing equalizer with length 2K + 1.
%  system_impulse_response denotes the sampled system impulse response.

% initialise important variables
w = zeros(1,2*K+1);
len = length(system_impulse_response);
L = (len-1)/2;

% get the channel matrix (H)
H = zeros(2*K+1, 2*(K+L)+1);
j=1;
for i=1:size(H,1)
    H(i, j:j+len-1) = system_impulse_response;
    j = j + 1;
end

% calculate the Moore-Penrose inverse (HH^t)^(-1)H
inverse = inv(H*H') * H;

% take the (K + L + 1)-th column
w(:) = inverse(:, K+L+1);

% testing
% disp(H);
% disp(inverse);
% disp(w);

end