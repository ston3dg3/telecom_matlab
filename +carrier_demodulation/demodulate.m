function [r_tilde_IQ] = demodulate(seq_in,f,phase,n_os,is_complex)
%DEMODULATE Summary of this function goes here
%   Detailed explanation goes here


r_tilde_IQ = zeros(size(seq_in));
t = 0:1/n_os:(length(seq_in)-1)/n_os;

R_tilde_I = seq_in .* (sqrt(2) * cos(2*pi*f*t + phase));
R_tilde_Q = seq_in .* (sqrt(2) * -sin(2*pi*f*t + phase));

if(is_complex)
    r_tilde_IQ(:) = R_tilde_I + 1i * R_tilde_Q;
else
    r_tilde_IQ(:) = R_tilde_I;
end

end

