function impulse_response = lowpass(filterspan, B, n_os)
%SINC Summary of this function goes here
%   provides the oversampled impulse response of an ideal lowpass filter as de-
%   picted in Fig. 5.4. The filter should be designed in the frequency domain and the
%   impulse response should be obtained by the IFFT. The span of the filter in the
%   time domain is given by filterspan, the bandwidth B of the filter by B and the
%   oversampling factor by n os.

assert(mod(filterspan,2)==0,'filterspan must be an even number');

% get the x axis for the frequency domain
impulse_response = zeros(1,filterspan*n_os);
[frequencies, filter] = getFrequencies(filterspan, n_os);

% design the filter shape in frequency domain
for i=1:length(frequencies)
    if(abs(frequencies(i)) < B/2)
        filter(i) = 1;
    end
end

% get the impulse response in time domain
impulse_response(:) = fftshift(ifft(fftshift(filter)));

% ========== plotting ===========
% plot(frequencies, filter);
% stem(filter);
% get time for plotting
% time = 0:length(impulse_response)-1;
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

