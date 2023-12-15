function impulse_response = lowpass(filterspan, B, n_os)
%SINC Summary of this function goes here
%   Detailed explanation goes here
assert(mod(filterspan,2)==0,'filterspan must be an even number');

impulse_response = zeros(1,filterspan*n_os);

end

