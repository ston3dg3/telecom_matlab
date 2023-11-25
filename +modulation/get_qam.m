function [X,label] = get_qam(M)
%GET_QAM Initialization of M-Quadrature-Amplitude-Modulation (M-QAM)
%constellation. Outputs the points and the labels of an M-QAM constellation
%with unit average power.
%
% Inputs:
%   M:  Number of symbols in the QAM constellation
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the QAM
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the M QAM
%           symbols where m=log2(M)


X = zeros(1,M);
label = zeros(M,log2(M));


end


