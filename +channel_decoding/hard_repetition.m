function [seq_out] = hard_repetition(seq_in,n,k)
% performs decoding of a (n, k)-repetition code based on bit-wise hard decisions.
% The input seq in is a row-vector of type uint8 of length n. The output seq out
% is a row-vector of type uint8 of length k.

seq_out = uint8(zeros(1,k));

if mod(n, k)~=0 || k>n
    warning("illegal values passed to repetition() function")
end

% numer of repetitions
n_r = n/k;

% help matrix
seq_matrix = reshape(seq_in', k, n_r)';

% hard decision based of number of bits
for j=1:n_r
    sum_ones = sum(seq_matrix(:,j));
    if(sum_ones) >= n_r/2
        seq_out(j) = uint8(1);
    else
        seq_out(j) = uint8(0);
    end
end

end

