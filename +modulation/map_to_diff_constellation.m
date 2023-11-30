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

% n is number of input bits
n = length(seq_in);
% m is number of bits per coded symbol
m = size(label, 2);
% num_of_symbols is number of symbols in the sequence
num_of_symbols = n/m; 
% preallocate seq_out
seq_out = zeros(1,n/m);

% reshape seq_in into a column vector for easier reading
column_sequence = reshape(seq_in, m, num_of_symbols)';

fprintf("col seq:\n");
disp(column_sequence);
fprintf("==========")

% send the symbol at phase = 0 because at the start, phase is 0
buffer_symbol = X(1);

for i=1:num_of_symbols
    % define next bits to read
    read_buffer = column_sequence(i,:);

    % send buffered symbol if no phase change (bits read are 000...)
    if read_buffer == zeros(length(read_buffer))
        seq_out(i) = buffer_symbol;
        continue;
    end

    % find the index where the read codeword in bit matches code of the constellation symbol
    [rowIndex, ~] = find(ismember(label, read_buffer, 'rows'));

    % get the symbol to send
    symbol = X(rowIndex);

    % buffer symbol value in case we need to repeat it
    buffer_symbol = symbol;

    % assign codeword at found index of seq_out array
    seq_out(i) = symbol;
end

end

