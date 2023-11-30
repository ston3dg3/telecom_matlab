function [seq_out] = awgn(seq_in, N0)
% adds additive white Gaussian noise (AWGN) to the input sequence. The input
% seq in is a row-vector and N0 denotes the noise spectral density N0. Consider two
% cases in the function. If the input sequence is complex, add complex noise. If the
% input sequence is real, add real noise.

if isreal(seq_in)
    % add real Gaussian noise
    var_squared = N0/2;
    noise = randn(1, length(seq_in)) * sqrt(var_squared);
    seq_out = seq_in + noise;
else
    % add complex Gaussian noise
    var_squared = N0;
    noise = randn(1, length(seq_in)) * sqrt(var_squared/2);
    seq_out = seq_in + noise;
end
