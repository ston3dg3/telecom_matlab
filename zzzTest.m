% testing the process

% ============================ define entry variables  ===========================
%x = [1 -1 1 -1]; % 2-ASK modulation, 4 symbols 
%n_os = 4;


% ============================ test rect pulse==========================
%pulse = pulses.rect(n_os);
% stem(pulse);
% ============================ test convoluted pulse =========================
% [conv_x, conv_t] = pulse_shaping.conv_pulse(x, pulses.rect(4), 4, 1);
% topic("convoluted rect pulse");
% results("conv(x,pulse)", conv_x);
% results("conv(x,pulse)", conv_t);
% line();

% [conv_x, conv_t] = pulse_shaping.conv_pulse(x, pulses.rect(8), 8, 1);
% topic("convoluted rect pulse");
% results("conv(x,pulse)", conv_x);
% results("conv(x,pulse)", conv_t);
% line();

% [conv_x, conv_t] = pulse_shaping.conv_pulse(x, pulses.rect(10), 10, 1);
% topic("convoluted rect pulse");
% results("conv(x,pulse)", conv_x);
% results("conv(x,pulse)", conv_t);
% line();

% =========================== test matched filter ==========================

% rectmf = matched_filter.get_mf(pulses.rect(10));
% rccmf = matched_filter.get_mf(rccpulse);
% rcmf = matched_filter.get_mf(rcpulse);
% stem(mf);

% ============================= test filtering ==========================

%[y_os, t_os] = matched_filter.filtering(s, mf, 10, 1);
%plot(t_os, y_os);

% =======================================================================
topic("testing rcc pulse");
% myX = [1 0 1 1 1 0 1 1 0 1];
myX = [1 0 1 1];
% myX = [1 -1 -1i 1 1i -1 -1 1];
% myX = [1 -3 7 -5 -1 3 -7 3 -1 1 1 -5 3 3 -7]; 
% const = [-7 -5 -3 -1 1 3 5 7];
const = [0 1];
nos = 2;
filterspan = 100;
rolloff = 0;
% -------------
% pulsee = pulses.rrc(filterspan, rolloff, nos, 'time');
% pulsee = pulses.rect(nos);
pulsee = pulses.rc(filterspan, rolloff, nos, 'time');
figure
rccmf = matched_filter.get_mf(pulsee);
[r, time] = pulse_shaping.conv_pulse(myX, pulsee, nos, 1);
[yos, time2] = matched_filter.filtering(r, rccmf, nos, 1);
[yy, tt] = matched_filter.sampling(yos, time2, nos, filterspan, filterspan);
sigma = channel.get_sigma_with_mf('ebn0', 20, length(const), const, 1, pulsee);
results("standard deviation (sigma) of the noise based on mf_pulse", sigma);
% -------------
figure
hold on
stem(time, r);
% stem(time2-filterspan/nos, yos);
stem(tt-filterspan/nos, yy);

% plot(time, r);
% plot(time2, yos);
% scatter(tt,yy);
hold off
% samples = 0:length(r)-1;
% stem(samples,r);
line();
% =======================================================================
% ================================= HELPER FUNCTIONS ====================

function results(result, matrix)
fprintf("%s: %s\n", result, mat2str(matrix));
end

function line()
fprintf("==========================================================\n");
end

function topic(words)
fprintf("=========== %s ===========\n", words);
end