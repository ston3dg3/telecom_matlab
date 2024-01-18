function [impulse_response] = bandpass(f_c, filterspan, B, n_os)
%BANDPASS Summary of this function goes here
%   Detailed explanation goes here

assert(mod(filterspan,2)==0,'filterspan must be an even number');

% get the x axis for the frequency domain
impulse_response = zeros(1,filterspan * n_os);
[frequencies, filter] = getFrequencies(filterspan, n_os);

% design the filter in frequency domain
for i=1:length(frequencies)
    if (abs(frequencies(i)) > f_c-B/2) &&  (abs(frequencies(i)) < f_c+B/2)
        filter(i) = 1;
    end
end

% get the impulse response in time domain
impulse_response(:) = fftshift(ifft(fftshift(filter)));

% ========== plotting ===========
% figure
% plot(frequencies, filter);
% stem(filter);
% get time for plotting
% time = 0:length(impulse_response)-1;
% figure
% plot(time, impulse_response);
% stem(impulse_response);
% ================================

end

% ======== HELPER FUNCTIONS ===================================
function [frequencies, filter] = getFrequencies(filterspan, n_os)
    N = filterspan*n_os;
    frequencies = linspace(-N/2, N/2, N);
    filter = zeros(1, length(frequencies));
end
% ==============================================================
