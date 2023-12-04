function [seq_out] = soft_repetition(seq_in,n,k)
% performs decoding of a (n, k)-repetition code based on log-likelihood-ratios.
% The input seq in is a row-vector of type double of length n containing the log-
% likelihood ratios of the bits. The output seq out is a row-vector of type uint8 of
% length k.

seq_out = uint8(zeros(1,k));

if mod(n, k)~=0 || k>n
    warning("illegal values passed to soft_repetition() function")
end

% number of repetitions
n_r = n/k;

% help matrix
seq_matrix = reshape(seq_in', k, n_r)';

% hard decision based of number of bits
for j=1:k
    sum_L = sum(seq_matrix(:,j));
    
    if(sum_L) >= 0
        seq_out(j) = uint8(0);
    else
        seq_out(j) = uint8(1);
    end
end

end

