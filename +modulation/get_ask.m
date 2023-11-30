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

% define gray label
label = modulation.get_gray_label(log2(M));

% get X vector with optimal neighbour distance d
X = generateX(getDistance(M, 1), M);

% make sure average power is 1
% fprintf("average Power: %d\n", avgPower(X));
end

% ========================= HELPERS ===================================

% get average power of the constellation symbols
function E = avgPower(X)
    E = mean(abs(X).^2);
end

% get distance between neighbours from M and desired Energy per bit
function d = getDistance(M, E_s)
d = sqrt(12*E_s/(M^2-1));
end

% Generate the vector of points
function X = generateX(d, M)
    left_end = -(M/2)*d + d/2;
    right_end = (M/2)*d - d/2;
    X = left_end:d:right_end;
end