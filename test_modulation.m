param.modulation.type = 'dpsk'; % one of 'ook', 'ask', 'psk', 'qam', 'dpsk'
param.modulation.M = 4;

% initialize parameter
param = modulation.initialize(param);

% create random bit sequence
u = uint8(randi([0,1],1,1000));


% modulate
x = modulation(param,u);

% plot sequence and scatter plot
figure('Name','Modulated Sequence')
if isreal(x)
    stem(x);
    xlabel('time index i');
    ylabel('x_i')
else
    subplot(2,1,1);
    stem(real(x));
    xlabel('time index i');
    ylabel('Real(x_i)')
    subplot(2,1,2);
    stem(imag(x));
    xlabel('time index i');
    ylabel('Imag(x_i)')
end

figure('Name','Scatter Plots of modulated sequence')
if isreal(x)
    scatter(x,zeros(size(x)),'filled');
    lim = 1.1*max(abs(x));
    axis([-lim,lim,-lim,lim]);
else
    scatter(real(x),imag(x),'filled');
    lim = 1.1*max(max(abs(real(x))),max(abs(imag(x))));
    axis([-lim,lim,-lim,lim]);
end
