function [X,label] = get_ook()
%GET_OOK Initialization of On-Off-Keying (OOK) constellation. Outputs the
%points and labels of an OOK constellation with unit average power.
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the OOK
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the OOK
%           symbols where m=log2(M)


X = zeros(1,2);
label = zeros(2,1);

end

