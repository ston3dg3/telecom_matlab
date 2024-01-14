% testing Script

% ================= DEFINE CONSTANTS =============================
S = [-1-1i 1+1i -1+1i 1+1i 1-1i 1+1i 1-1i];


% ============ CARRIER MODULATION =================================

modulated = carrier_modulation.modulate(S, 200, 50);
disp(modulated);

% ================ CARRIER DEMODULATION ===========================

demodulated = carrier_demodulation.demodulate(modulated, 100, 45, 50, false);
disp(demodulated);

% =================== LOWPASS AND BANDPASS =========================

f_c = 100;
filterspan = 500;
B = 50;
nos = 100;

lowpass = filters.lowpass(filterspan, B, nos);
bandpass = filters.bandpass(f_c, filterspan, B, nos);
lp_time = 0:length(lowpass)-1;
bp_time = 0:length(bandpass)-1;

figure
plot(lp_time, lowpass);
figure
plot(bp_time, bandpass);

% ====================== DISCRETE CHANNEL MODEL ===================

% equalizer.get_discrete_channel_model(nos, )