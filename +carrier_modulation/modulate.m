function [s_tilde] = modulate(s,f_0,n_os)
%MODULATE Summary of this function goes here
%     performs carrier modulation as shown in Fig. 5.2. s denotes the signal S(t)
% that is oversampled with oversampling factor n os. Note that s is a complex row
% vector for 2-dimensional modulation formats (QAM, PSK) and a real-valued row
% vector for 1-dimensional modulation formats (ASK, OOK). The carrier frequency
% f0 is given as f 0 (normalized to the symbol period as specified above). The output
% of the function s tilde denotes the signal ˜S(t) with oversampling factor n os and
% must be a real-valued row vector

s_tilde = zeros(1,length(s));

% Time vector
t = 0:1/n_os:(length(s)-1)/n_os;
S_i = real(s);
S_q = imag(s);
real_mod = sqrt(2)*cos(2*pi*f_0*t);
imag_mod =-sqrt(2)*sin(2*pi*f_0*t);
s_tilde(:) = S_i .* real_mod + S_q .* imag_mod;
end

% s has length n_os * length(x)
% phase0 = 0;
% A = 1;
% freq = 0;
% phase = 2*pi*freq*t + phase0*t;






