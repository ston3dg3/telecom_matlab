function seq_out = repetition(seq_in, n, k)
% performs encoding of a (n, k)- repetition code. The input seq in is a row-
% vector of type uint8 of length k. The output seq_out is a row-vector of type uint8
% of length n.

% Assuming that seq_in is just one symbol (not clear from the
% Aufgabestelung)
if mod(n, k)~=0 || k>n
    warning("illegal values passed to repetition() function")
end

n_r = n/k;
seq_out = uint8(repmat(seq_in, 1, n_r));

end

