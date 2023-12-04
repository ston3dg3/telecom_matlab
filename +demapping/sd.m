function [seq_out] = sd(seq_in,X,label,N0)
%sd For soft-decoding of channel codes, we need reliability information about the bits
% instead of hard-decisions. We compute this reliability information in form of log-
% likelihood ratios. Outputs the log-likelihood ratios of all bits.

% define useful variables
m = size(label, 2);
seq_out = zeros(1,length(seq_in)*m);
LLR = zeros(1, length(seq_in)*m);
veryReal = isreal(X);

for i=1:length(seq_in)
    % get detected symbol
    symbol = seq_in(i);

    % for each bit level
    for j=1:m

        % get indices of all symbols whose i'th bit is 0
        symbols0_index = label(j,:)==0;
        % extract the 0 bit symbols from X
        symbols0 = X(symbols0_index);
        %  get distance from detected symbol to every 0 constallation symbol
        distances0 = norm(symbol - symbols0);

        % get indices of all symbols whose i'th bit is 1
        symbols1_index = label(j,:)==1;
        % extract the 1 bit symbols from X
        symbols1 = X(symbols1_index);
        %  get distance from detected symbol to every 1 constallation symbol
        distances1 = norm(symbol - symbols1);

        % Calculate the log likelihood ratio for bit level j
        LLR((i-1)*m +j) = log(sum(P_N(distances1, N0, veryReal)) / sum(P_N(distances0, N0, veryReal)));  
    end
end
% assign LLR to output
seq_out(:) = LLR;
end

% ============================== helper functions ======================

% is this function correct? 
% equivalent to P_X|Y(x|y)
function P_YthatXis0 = P_N(dist, N0, realNoise)
if(realNoise)
    sigma = N0/2;
else
    sigma = N0;
end
P_YthatXis0 = exp( -(dist) / (2*sigma^2));
end

