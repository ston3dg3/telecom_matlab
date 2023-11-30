function [X,label] = get_psk(M)
%GET_PSK Initialization of M-Phase-Shift-Keying (M-PSK) constellation.
%Outputs the points and the labels of an M-PSK constellation with unit
%average power.
%
% Inputs:
%   M:  Number of symbols in the PSK constellation
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the PSK
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the M PSK
%           symbols where m=log2(M)

% declare useful variables and get gray label
m = log2(M);
label = modulation.get_gray_label(m);
Radius = 1;

% generate a vector with absoute phase for each symbol
symbolAngles = linspace(0, 2*pi, M + 1);
symbolAngles(end) = [];

% Generate constellation
X = Radius * exp(1j * symbolAngles);

% plot for testing
% plot_complex(X);

% make sure average power is 1
% fprintf("average Power: %d\n", avgPower(X));

end

% ======================== HELPER FUNCTIONS ===========================

% get average power of the constellation symbols
function E = avgPower(X)
    E = mean(abs(X).^2);
end

% helper complex plotter
function plot_complex(z)
    plot(real(z), imag(z), 'o');
end
