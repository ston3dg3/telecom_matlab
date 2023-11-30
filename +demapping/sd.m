function [seq_out] = sd(seq_in,X,label,N0)
%sd For soft-decoding of channel codes, we need reliability information about the bits
% instead of hard-decisions. We compute this reliability information in form of log-
% likelihood ratios. Outputs the log-likelihood ratios of all bits.

seq_out = zeros(1,length(seq_in)*size(label,2));

% help matrix
seq_matrix = reshape(seq_in', k, n_r)';

for i=1:M
    % get current symbol
    symbol = seq_in(i);

    % calculate probabilities (not implemented)
    P_yi_x0 = 1;
    P_yi_x1 = 1;

    % Calculate the absolute log likelihood ratio
    L_i = sum(log(P_yi_x0 / P_yi_x1));

    % add log likelihood to seq_out
    seq_out(i, :) = L_i;
end

% convert output to uint8 vector (from matrix form)
seq_out = uint8(reshape(seq_out', M*m, 1)');

end

