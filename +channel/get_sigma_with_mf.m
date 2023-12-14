function [sigma] = get_sigma_with_mf(snr_type, snr_dB, M, X, coderate, mf_pulse)
% %GET_SIGMA_WITH_MF

% define variables
sigma = 0;
R = coderate;
perSymbol = (log2(M)*R);

% we somehow need to calculate E_s from X and mf_pulse.

% get average power pro symbol
%E_s = mean(norm(mf_pulse) * norm(X));

E_s = mean(norm(X)^2) * mf_pulse*mf_pulse';

%(norm(X)).^2 * sum(^2);


% get average power pro bit
E_b = E_s / perSymbol;

% calculate sigma based on SNR definition type
switch snr_type
    case 'ebn0'
        % using equation 3.7
        N0 = E_b * 10^(-snr_dB/10);
        sigma = sqrt(N0);
    case 'esn0'
        % using equation 3.5
        N0 = E_s * 10^(-snr_dB/10);
        sigma = sqrt(N0);
    case 'snr'
        N0 = E_s * 10^(-snr_dB/10);
        if isreal(M)
            % divide by 2 for real
            sigma = sqrt(N0/2);
        else
            % dont divide for complex
            sigma = sqrt(N0);
        end
        
    otherwise
        disp('SNR definition %s is not implemented / does not exist', snr_type);
end

end

