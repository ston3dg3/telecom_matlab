function [X,label] = get_psk(M)
%GET_PSK Initialization of M-Phase-Shift-Keying (M-PSK) constellation.
%Outputs the points and the labels of an M-PSK constellation with unit
%average power.
%
% Inputs:
%   M:  Number of symbols in the PSK constellation
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the PSK
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the M PSK
%           symbols where m=log2(M)

X = zeros(1,M);
label = zeros(M,log2(M));

end

