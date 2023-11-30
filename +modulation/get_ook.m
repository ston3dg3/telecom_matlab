function [X,label] = get_ook()
%GET_OOK Initialization of On-Off-Keying (OOK) constellation. Outputs the
%points and labels of an OOK constellation with unit average power.
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the OOK
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the OOK
%           symbols where m=log2(M)

label = zeros(2,1);

X = [0 getDistance(1)];

label(1,:) = 0;
label(2,:) = 1;

% fprintf("avg Power: %d\n", avgPower(X));

end

% get distance between neighbours from M and desired Energy per bit
function d = getDistance(E_s)
d = sqrt(2*E_s);
end

% get average power of the constellation symbols
function E = avgPower(X)
    E = mean(abs(X).^2);
end

