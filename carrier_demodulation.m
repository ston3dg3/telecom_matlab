function [output,output_hf,t,t_hf] = carrier_demodulation(param,input)
%CARRIER_MODULATION Summary of this function goes here
%   Detailed explanation goes here

switch param.carrier_demodulation.type
    case 'none'
        output = input;
        output_hf = [];
        t = [];
        t_hf = [];
    case 'am'
        type = param.modulation.type;
        if strcmp(type,'qam') || strcmp(type,'psk') || strcmp(type,'dpsk')
            is_complex = true;
        else
            is_complex = false;
        end
        output = carrier_demodulation.demodulate(input,...
            param.carrier_demodulation.frequency,...
            param.carrier_demodulation.phase,param.general.os,...
            is_complex);
        
        n = length(output);
    
        T_s = 1/param.general.symbol_rate;

        t = linspace(0,T_s/param.general.os*n,n);
        
        
        if param.carrier_demodulation.lowpass
            output_hf = output;
            t_hf = t;
            output = carrier_demodulation.lp_filter(output,...
                param.carrier_demodulation.lowpass_filter);
            
            n = length(output);
    
            T_s = 1/param.general.symbol_rate;

            t = linspace(0,T_s/param.general.os*n,n);
        else
            output_hf = [];
            t_hf = [];
        end
end



end
