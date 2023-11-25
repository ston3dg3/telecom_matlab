function [label] = get_gray_label(m)
%GET_GRAY_LABEL This function generates a binary Gray code of length m.
%
% Input:
%   m: length of the binary codeword
%
% Output
%   label: a matrix of size Mxm containing all M codewords of a binary Gray
%   code such that two consecutive rows differ in exactly one position


label = zeros(2^m,m);

end

