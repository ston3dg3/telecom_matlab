function [X,label] = get_ask(M)
%GET_ASK Initialization of M-Amplitude-Shift-Keying (M-ASK) constellation.
%Outputs the points and the labels of an M-ASK constellation with unit
%average power.
%
% Inputs:
%   M:  Number of symbols in the ASK constellation
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the ASK
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the M ASK
%           symbols where m=log2(M)


X = zeros(1,M);
label = zeros(M,log2(M));


end


