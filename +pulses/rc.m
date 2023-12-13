function pulse = rc(filterspan, rolloff, n_os, design_type)
    %RC This
    %   Inputs:
    %   filterspan: Filterspan in number of symbols
    %   rolloff: alpha
    %   n_os: oversampling factor
    %   type: freq or time
    %
    % i took u'as u in the following lines ( u := u'=(u-[N/2]) )
    assert(mod(filterspan,2)==0,'filterspan must be an even number');
    
    pulse = zeros(1,filterspan*n_os);
    %define parameters 
    n_span = filterspan;
    N = n_os*n_span;
    
    %shape the pulse
    if design_type == 'freq'
        
        u = 0:N-1;
        u_strich = u-(N/2);
        fprintf("u': ")
        disp(u_strich)
        ovsampled_pulse = freq_rc(u_strich,N,n_os,rolloff);     %in frequency domain
        %ovsampled_pulse = fftshift(ovsampled_pulse);
        pulse = fftshift(ifft(fftshift(ovsampled_pulse))) ;        %in time domain
        stem(pulse);

    elseif design_type == 'time'
        % Design truncated RC pulse in time domain
        T=1;      %HOW DO I GET THE SYMBOL RATE Rs?
        t = -n_span/2*T:T/n_os:n_span/2*T;
        fprintf("time vector: ")

        
        pulse = time_rc(t,T,n_span,rolloff);
        t=t+n_span*T/2;
        stem(t,pulse);
    else    
        pulse = [];     %if no label for time or freq shaping is given, return empty array
    end
end



% help functions=====================================

% RC in frequency domain
function value = freq_rc(u_strich,N,n_os,rolloff)
    value = [];
    for i=1:length(u_strich)
        if abs((n_os/N)*u_strich(i)) <= (1-rolloff)/2
            value(i) = 1;
        elseif ( abs((n_os/N)*u_strich(i)) <= (1+rolloff)/2 ) && ( abs((n_os/N)*u_strich(i)) > (1-rolloff)/2 )
            value(i) = 1/2*( 1+cos(pi/rolloff*(abs((n_os/N)*u_strich(i))-((1-rolloff)/2))) );
        else 
            value(i) = 0;
        end
    end
end

% RC in time domain
function value = time_rc(t,T,n_span,rolloff)
    value = [];
    
    for i=1:length(t)
        %value(i) = sinc( (t(i)-(n_span/2)*T)/T)*cos( ( rolloff*pi*(t(i)-(n_span/2)*T))/( (1-4*(rolloff^2)*((t(i)-(n_span/2)*T)^2) )/T^2)  );
         value(i) = sin( (t(i)/T) / (t(i)/T) ) * cos( ( rolloff*pi*(t(i)))/( (1-4*(rolloff^2)*((t(i))^2) )/T^2)  );
    end
end
