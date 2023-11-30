function [seq_out] = hd(seq_in,X,label)
%HD Maps the noisy constellation points back to a sequence of bits
%   input seq_in is a row-vector containing noisy symbols from the
%   constellation. defined by X and label. Symbols from seq_in must be mapped to
%   nearest neighbour from X according to label

M = length(seq_in);
m = size(label,2);

% seq_in has symbols in it
seq_out = zeros(M,m);

for i=1:M
    % get current symbol
    symbol = seq_in(i);

    % Calculate the absolute differences between X and symbol
    % this works also for complex numbers
    differences = abs(X - symbol);

    % get the index of the symbol in X closest to 'symbol'
    [~ , closest_symbol_index] = min(differences);

    % get corresponding codeword
    codeword = label(closest_symbol_index, :);

    % add codeword to seq_out
    seq_out(i, :) = codeword;
end

% convert output to uint8 row vector (from matrix form)
seq_out = uint8(reshape(seq_out', M*m, 1)');

end

