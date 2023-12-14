function [s,t] = conv_pulse(x,pulse,n_os,symbol_rate)
%CONV_PULSE 

s = zeros(1,length(pulse) + (length(x)-1)*n_os);
% s = zeros(1, 4 + 3*4) = zeros(16)
t = zeros(size(s));

% OLD IMPLEMENTATION FOR RECT
% convoluted signal
% s(1:n_os:end) = x;
% s = conv(s, pulse);
% account for the zeros coming from the conv function
%s(end - n_os+2 : end) = [];
%s = conv(s, pulse);

% NEW, GENERAL IMPLEMENTATION
j=1;
for i=1:n_os:length(s)
    if(j>length(x))
        fprintf("TOO FAR!\n");
        break;
    end
    s(i:i+length(pulse)-1) = s(i:i+length(pulse)-1) + x(j) * pulse;
    j = j+1;
end

% time period between pulses in seconds
T = 1/symbol_rate;
% time period between oversampled pulses in seconds
T_os = T/n_os;
% vector representing the times axis
t(:) = linspace(0,T_os*length(s), length(s));


% Funktioniert
end

