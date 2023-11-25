clear
param.modulation.type = 'ask'; % one of 'ook', 'ask', 'psk', 'qam', Not: 'dpsk'
param.modulation.M = 4;
param.demapping.type = 'soft';
param.demapping.is_initialized = true;
param.channel.type = 'awgn';
param.channel.N0 = 1e-2; % very low noise, actually we do not add noise to the sequence in this test file

% initialize parameter
param = modulation.initialize(param);

% create random bit sequence
u = uint8(randi([0,1],1,1000));


% modulate
x = modulation(param,u);

% demapping
L = demapping(param,x);
if ~isrow(L)
    error('L is not a row vector.');
end

% check if L is positive or negative and decide for 0 or 1, respectively
u_hat = zeros(size(L));
u_hat(L > 0) = 0;
u_hat(L < 1) = 1;

if ~isequal(u_hat,u)
    error('u_hat is not equal to u')
end

