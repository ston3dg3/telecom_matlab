function [seq_out] = map_to_constellation(seq_in,X,label)
%MAP_TO_CONSTELLATION This function maps a binary input sequence to a
%sequence of symbols from a given constellation using a specified label.
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

% n is number of input bits
n = length(seq_in);
% m is number of bits per coded symbol
m = size(label, 2);
% num_of_symbols is number of symbols in the sequence
num_of_symbols = n/m; 

% preallocate seq_out
seq_out = zeros(1, num_of_symbols);

column_sequence = reshape(seq_in, m, num_of_symbols)';

for i=1:num_of_symbols
    % define next bits to read
    read_buffer = column_sequence(i,:);

    % find the index where the read codeword in bit matches code of the constellation symbol
    [rowIndex, ~] = find(ismember(label, read_buffer, 'rows'));

    % assign codeword at found index of seq_out array
    seq_out(i) = X(rowIndex);
end

end

