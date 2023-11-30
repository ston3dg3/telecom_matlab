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

% get m and gray label
m = log2(M);
label = arrangeGrayCodes2D(modulation.get_gray_label(m));
% get M-QUAM constellation
X = computeSymbolPositions(M);

% ================== TESTING =====================================
% plot the constellation for testing
% plotComplex(X, getStringBitLabels(label), true);
% check average Power
% fprintf("average Power:%d\n", avgPower(X));
% ===============================================================
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

% get string grey labels for constellation
function labels = getStringBitLabels(label)
labels = cell(1, size(label, 1));
for i=1:size(label, 1)
    code = label(i, :);
    labels{i} = mat2str(code);
end

end

% help plotter function
function plotComplex(complexVector, labels, displayLabels)
    % Check if the input is a vector
    if ~isvector(complexVector)
        error('Input must be a vector of complex values.');
    end

    re = real(complexVector);
    im = imag(complexVector);

    % Create a scatter plot
    scatter(re, im, 'o');

    % Add custom string labels to each point
    if(displayLabels)
        for i = 1:length(complexVector)
            text(re(i), im(i), labels{i});
            % 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        end
    end

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

% does most of the work and
% returns a VECTOR of complex values that represents the constellation
function X = computeSymbolPositions(M)

% get correct sizes and shape of the constellation
longSide = ceil(sqrt(M));
square = longSide*longSide;
cutoutSquare = ((square-M)/4);

% while diff/4 (corner) not perfect square look for a better diff
while (~isPerfectSquare(cutoutSquare))
    longSide = longSide + 1;
    square = longSide*longSide;
    cutoutSquare = ((square-M)/4);
end

cutoutSide = sqrt(cutoutSquare);
side = longSide - 2*cutoutSide;
% longSide is size of the square that embraces the QAM constellation

% preallocate X
X = [];

% get the optimal d (d_min) "distance between neighbours" for E_avg = 1
d = getDistance(M, 1);

spacing = linspace(0, (longSide-1)*d, longSide);

[re, im] = meshgrid(spacing, spacing);
% add real and imaginary part to the matrix
complex_matrix = re - im*1i;

% shift the matrix to the correct position
complex_matrix = complex_matrix + (-(longSide-1)*d/2 + (longSide-1)*d*1i/2);

% dont remove corners if constellation is a perfect square
if cutoutSide == 0 
    X = reshape(complex_matrix', M, 1)';
    return;
end

% otherwise cut out the corners
for i=1:longSide
    for j=1:longSide
        corner1 = (i<=cutoutSide && j<=cutoutSide);
        corner2 = (i<=cutoutSide && j>cutoutSide+side);
        corner3 = (i>cutoutSide+side && j<=cutoutSide);
        corner4 = (i>cutoutSide+side && j>cutoutSide+side);

        if ~(corner1 || corner2 || corner3 || corner4)
            X = [X complex_matrix(i,j)];
        end
    end
end

end

% get optimal distace provided M and the Enegry pro bit symbol
function d = getDistance(M, E_s)
d = sqrt(6*E_s / (M-1));
end

% Check if the square of the square root is equal to the original number
function perfectSquare = isPerfectSquare(number)
    perfectSquare = (sqrt(number) == round(sqrt(number))) && (number >= 0);
end

% takes the gray codes and rearranges for a 2D case
function grayCode2D = arrangeGrayCodes2D(gray_codes)
grayCode2D = zeros(size(gray_codes));
M = size(gray_codes, 1);
side = sqrt(M);

alternate = false;

for i=1:side:M
    alternate = ~alternate;
    if(alternate)
        grayCode2D(i:i+side-1, :) = gray_codes(i:i+side-1, :);
    else
        grayCode2D(i:i+side-1, :) =  flipud(gray_codes(i:i+side-1, :));
    end
end
end
