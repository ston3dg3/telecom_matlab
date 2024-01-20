function [output,t] = carrier_modulation(param,input)
%CARRIER_MODULATION Summary of this function goes here
%   Detailed explanation goes here

switch param.carrier_modulation.type
    case 'none'
        output = input;
        t = [];
    case 'am'
        output = carrier_modulation.modulate(input,...
            param.carrier_modulation.frequency,...
            param.general.os);
        
        n = length(output);
    
        T_s = 1/param.general.symbol_rate;

        t = linspace(0,T_s/param.general.os*n,n);
end

        
end

