function [output] = equalizer(param,input)
%EQUALIZER Summary of this function goes here
%   Detailed explanation goes here

assert(param.equalizer.is_initialized)


switch param.equalizer.type
    case 'none'
        output = input;
        
        
    case 'lmmse'
        output = conv(input,param.equalizer.impulse_response);
        
        
    case 'zf'
        output = conv(input,param.equalizer.impulse_response);

       
       
    otherwise
        error('Not Supported yet');
end


%% Remove tails from pulse shaping, matched filtering, channel and carrier demodulation
if ~strcmp(param.pulse_shaping.type,'none')
    if param.pulse_shaping.filterspan == 1
        % do nothing
    else
        tmp = param.pulse_shaping.filterspan/2 + param.matched_filter.filterspan/2;
        output = output(tmp+1:end-tmp+1);
    end

    filterspan = 0;
    if isfield(param, 'carrier_demodulation')
        if isfield(param.carrier_demodulation, 'filterspan')
            filterspan = filterspan + param.carrier_demodulation.filterspan;
        end
    end
    if param.channel.is_bandwidth_limited
        filterspan = filterspan + param.channel.filterspan;
    end

    output = output(filterspan/2+1:end-filterspan/2);
end
%% Remove tails from Equalizing

if ~strcmp(param.equalizer.type, 'none')
    output = output(param.equalizer.K+1:end-param.equalizer.K);
end
end




