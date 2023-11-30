function [N0] = get_N0(snr_type, snr_dB, M, X, coderate)
% computes the noise spectral density that we need in function +channel/awgn.m
% for different SNR definitions. The following SNR types are defined:
% • snr type = ’ebn0’
% • snr type = ’esn0’
% • snr type = ’snr’
% The input snr dB is the SNR value (of the type snr type) in dB, M is the constel-
% lation size, X is the constellation and coderate is the rate of the channel code.

R = coderate;
N0 = 0;

% get expectancy / mean power pro signal
E_s = mean(norm(X));

% get expectancy / mean power pro bit
E_b = mean(norm(X)) / (log2(M) * R);


switch snr_type
    case 'ebn0'
        % using equation 3.7
        N0 = E_b * 10^(-snr_dB/10);
    case 'esn0'
        % using equation 3.5
        N0 = E_s * 10^(-snr_dB/10);
    case 'snr'
        if isreal(M)
            % divide by 2 for real
            N0 = (E_s * 10^(-snr_dB/10))/2;
        else
            % dont divide for complex
            N0 = E_s * 10^(-snr_dB/10);
        end
        
    otherwise
        disp('SNR definition %s is not implemented / does not exist', snr_type);

end



