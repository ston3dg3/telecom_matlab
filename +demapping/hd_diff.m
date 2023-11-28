function [seq_out] = hd_diff(seq_in,X,label)
%HD_DIFF Summary of this function goes here
%   maps the (noisy) differential modulated PSK points back to a sequence of bits.
%   Note that finding the point with the smallest Euclidean distance corresponds 
%   to finding the point with the smallest phase difference.

M = length(seq_in);
m = size(label,2);

% seq_in has symbols in it
seq_out = zeros(M,m);

for i=1:M
    % get current vector
    pointer_vector = seq_in(i);

    % calculate the phase differences for all points.
    differences = abs(angle(X) - angle(pointer_vector));

    % get the index of the symbol in X closest to 'symbol'
    [~ , closest_symbol_index] = min(differences);

    % get corresponding codeword
    codeword = label(closest_symbol_index, :);

    % add codeword to seq_out
    seq_out(i, :) = codeword;
end

% convert output to uint8 vector (from matrix form)
seq_out = uint8(reshape(seq_out', M*m, 1)');

end

