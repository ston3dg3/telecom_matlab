function r = lp_filter(r_tilde_IQ, lp_impulse_response)
%%RECT Summary of this function goes here
%   performs the filtering of the signal ˜RI,Q given by r tilde IQ with the lowpass
%   filter given by the impulse respone lp impulse response. The output of this
%   function should be a row-vector.

r = zeros(1,length(lp_impulse_response)+length(r_tilde_IQ)-1);

r(:) = conv(r_tilde_IQ, lp_impulse_response);


end

