function [X,label] = get_qam(M)
%GET_QAM Initialization of M-Quadrature-Amplitude-Modulation (M-QAM)
%constellation. Outputs the points and the labels of an M-QAM constellation
%with unit average power.
%
% Inputs:
%   M:  Number of symbols in the QAM constellation
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the QAM
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the M QAM
%           symbols where m=log2(M)

% since M is not always a perfect square, we need to look for a matrix 
% size that will have optimal (closest to square) sides
[width, height] = getOptimalConstellationSize(M);

% get m and gray label
m = log2(M);
label = modulation.get_gray_label(m);

% set a random distance between neighbours
d = 1;

% set the boundries for the matrix and create it
% x = linspace(-width, width, width);
% y = linspace(height, -height, side);
x = -width/2:d:width/2;
y = height/2:d:-height/2;

[re, im] = meshgrid(0:width-1, 0:height-1);
% add real and imaginary part to the matrix
complex_matrix = re + im*1i;

% shift the matrix to the correct position
complex_matrix = complex_matrix - ((width-1)/2 + (height-1)*1i/2);

% test printing 
disp(complex_matrix);

X = reshape(complex_matrix', M, 1)';
plotComplex(X);

% check average Power
fprintf("average Power:%d\n", avgPower(X));

end

% ====================== HELPER FUNCTIONS ===============================

% get average power of the constellation symbols
function E = avgPower(X)
    E = mean(abs(X).^2);
end

% get all divisors of an integer N
function [div] = divisors(N)
x = 1:N;
div = x(~(rem(N, x)));
end

% returns size of 
function [best_width, best_heigth] = getOptimalConstellationSize(M)

% Find possible factors of the total size
factors = divisors(M);

% Initialize variables
min_difference = Inf;
best_width = 1;
best_heigth = M;

% Iterate through factors to find the closest to a square
for i = 1:length(factors)
    current_width = factors(i);
    current_heigth = M / current_width;
    
    % Check if the current dimensions are closer to a square
    current_difference = abs(current_width - current_heigth);
    if current_difference <= min_difference
        best_width = current_width;
        best_heigth = current_heigth;
        min_difference = current_difference;
    end
end
end

function plotComplex(complexVector)
    % Check if the input is a vector
    if ~isvector(complexVector)
        error('Input must be a vector of complex values.');
    end

    % Create a scatter plot
    scatter(real(complexVector), imag(complexVector), 'o');

    % Add grid and labels
    grid on;
    xlabel('Real Part');
    ylabel('Imaginary Part');

    % Add title
    title('Complex Vector Plot');

    % Display real and imaginary axes
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';

    % Show equal aspect ratio
    axis equal;
end

