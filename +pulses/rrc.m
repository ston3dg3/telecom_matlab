function pulse = rrc(filterspan, rolloff, n_os, design_type)
    %RRC This
    %   Inputs:
    %   filterspan: Filterspan in number of symbols
    %   rolloff:
    %   n_os: oversampling factor
    %   type: freq or time
    
    assert(mod(filterspan,2)==0,'filterspan must be an even number');
    pulse = zeros(1,n_os*filterspan);
    
    %define parameters 
    n_span = filterspan;
    N = n_os*n_span;
    
    %shape the pulse
    if design_type == 'freq'
        
        u = 0:N-1;
        u_strich = u-(N/2);
        fprintf("u': ")
        disp(u_strich)
        ovsampled_pulse = freq_rrc(u_strich,N,n_os,rolloff);     %in frequency domain
        %ovsampled_pulse = fftshift(ovsampled_pulse);
        pulse = fftshift(ifft(ovsampled_pulse)) ;        %in time domain

        % printing
        stem(pulse)

    elseif design_type == 'time'
        % Design truncated RC pulse in time domain
        T=1;
        t = -n_span/2*T:T/n_os:n_span/2*T;
        pulse = time_rrc(t,T,n_span,rolloff);
        t=t+n_span/2*T;

        % get rid of last element
        t(end) = [];
        pulse(end) = [];

        % printing
        %stem(t,pulse);


    else    
        pulse = [];     %if no label for time or freq shaping is given, return empty array
    end

end

% help functions=====================================

% RRC in frequency domain
function value = freq_rrc(u_strich,N,n_os,rolloff)
    value = [];
    for i=1:length(u_strich)
        if abs((n_os/N)*u_strich(i)) <= (1-rolloff)/2
            value(i) = 1;
        elseif ( abs((n_os/N)*u_strich(i)) <= (1+rolloff)/2 ) && ( abs((n_os/N)*u_strich(i)) > (1-rolloff)/2 )
            %RRC is just the sqrt of the RC
            value(i) = sqrt(  1/2*( 1+cos(pi/rolloff*(abs((n_os/N)*u_strich(i))-((1-rolloff)/2))) )  );     
        
        else 
            value(i) = 0;
        end
    end
end

% RRC in time domain
function value = time_rrc(t,T,n_span,rolloff)
    value = [];
    
    for i=1:length(t)
        if t(i) == 0
            value(i) = (1/sqrt(T))*(1-rolloff+4*rolloff/pi);
        elseif abs(t(i)) == T/(4*rolloff)
            value(i) = (rolloff/sqrt(2*T))*( (1+2/pi)*sin(pi/(4*rolloff)) + (1-2/pi)*cos(pi/(4*rolloff)) );
        else
            value(i) = (1/sqrt(T))*( sin( (pi/T)*(t(i))*(1-rolloff)) + (4*rolloff/T)*(t(i))*cos( (pi/T)*(1+rolloff)*(t(i))) )/( (pi/T)*(t(i))*( 1-((4*rolloff/T)*(t(i)) )^2 ) ); 
        end
    end
end
