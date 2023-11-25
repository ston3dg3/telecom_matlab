function [seq_out] = map_to_diff_constellation(seq_in,X,label)
%MAP_TO_DIFF_CONSTELLATION This function maps a binary input sequence to a
%sequence of symbols from a given constellation using a specified label in
%a differential manner.
%
% Inputs: 
%   seq_in: binary input sequence of length n given as a 1xn vector of type
%           uint8.
%   X:      vector of size 1xM containing the M-symbols of the given
%           constellation.
%   label:  matrix of size Mxm containing the binary labels of the M
%           symbols. Note that the input length n is always defined as a
%           multiple of m
%
% Outputs:
%   seq_out: vector of size 1x(n/m) containing the output sequence


seq_out = zeros(1,length(seq_in)/size(label,2));



end

