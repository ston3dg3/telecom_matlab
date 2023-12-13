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
% myX = [1 0 1 1];
% myX = [1 -1 -1i 1 1i -1 -1 1];
myX = [1 -3 7 -2 -1 4 -6 2 -1 1 1 -2 3 3 -7]; 
nos = 4;
filterspan = 2;
rolloff = 0;
% -------------
pulsee = pulses.rrc(filterspan, rolloff, nos, 'time');
%pulsee = pulses.rect(nos);
rccmf = matched_filter.get_mf(pulsee);
[r, time] = pulse_shaping.conv_pulse(myX, pulsee, nos, 1);
[yos, time2] = matched_filter.filtering(r, rccmf, nos, 1);
[yy, tt] = matched_filter.sampling(yos, time2, nos, filterspan, filterspan);
% -------------
figure
hold on
plot(time, r);
plot(time2, yos);
scatter(tt,yy);
hold off
%stem(shaped_message);
line();
% =======================================================================
% =======================================================================
% =======================================================================
% =======================================================================
% =======================================================================
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