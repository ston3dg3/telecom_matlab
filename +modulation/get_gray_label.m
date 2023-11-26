function [label] = get_gray_label(m)
%GET_GRAY_LABEL This function generates a binary Gray code of length m.
%
% Input:
%   m: length of the binary codeword
%
% Output
%   label: a matrix of size Mxm containing all M codewords of a binary Gray
%   code such that two consecutive rows differ in exactly one position




if (m<1)
    warndlg("m value invalid for gray matrix generation");
end


% below is a method for generating gray bit codes by mirroring
% the matrix and adding 1's where required.
label = [0;1];

for i=2:m
    % get useful values
    power = 2^i;
    half = power/2;

    % preallocate new matrix with zeros
    gray_matrix = zeros(power, i);

    % STEP 1: insert old matrix values, also mirrored
    gray_matrix(1:half , 2:end) = label;
    gray_matrix(half+1:end , 2:end) = flipud(label);

    % STEP 2: generate ones vector and add it to bottom left
    gray_matrix(half+1 : end, 1) = ones(half,1);

    % STEP 3: update value of label
    label = gray_matrix;

end
end
