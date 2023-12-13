function [mf_pulse] = get_mf(g_pulse)
%GET_MF 

% h_r(t) = Kg*(T-t)
% choose K such that conv(g_pulse, mf_pulse) = 1 at sampling point

mf_pulse = zeros(size(g_pulse));

% because pulses are symmetric, no need to flip the pulse

K = 1/(norm(g_pulse))^2;

mf_pulse = K * g_pulse;

% uncomment if pulses become complex
% mf_pulse = K * conj(g_pulse);

% Funktioniert
end

