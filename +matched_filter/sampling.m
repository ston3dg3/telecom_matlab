function [y,t] = sampling(y_os,t_os,os,filterspan_pulse,filterspan_mf)
%SAMPLING Summary of this function goes here
%   Detailed explanation goes here


if filterspan_pulse == 1
    y = zeros(1,(length(y_os)+1)/os - 1);
    t = zeros(size(y));
    % sample both time and values every os (for rect pulse)
    t(:) = t_os(os:os:end);
    y(:) = y_os(os:os:end);
    % plot(T_sampled(1:50), Y_sampled(1:50));
else
    y = zeros(1,(length(y_os)+1)/os);
    t = zeros(size(y));
    % sample for 
    t(:) = t_os(1:os:end);
    y(:) = y_os(1:os:end);

end 

% Funktioniert for rect pulses
end
