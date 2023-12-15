function [impulse_response] = bandpass(f_c, filterspan, B, n_os)
%BANDPASS Summary of this function goes here
%   Detailed explanation goes here
assert(mod(filterspan,2)==0,'filterspan must be an even number');

impulse_response = zeros(1,filterspan * n_os);

end

