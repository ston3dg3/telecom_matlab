clear
param.modulation.type = 'ask'; % one of 'ook', 'ask', 'psk', 'qam', 'dpsk'
param.modulation.M = 4;
param.demapping.type = 'hard';
param.demapping.is_initialized = true;

% initialize parameter
param = modulation.initialize(param);

% create random bit sequence
u = uint8(randi([0,1],1,1000));


% modulate
x = modulation(param,u);

% demapping
L = demapping(param,x);

%% Checks
if ~isa(L,'uint8')
    error('L is not of type uint8')
end
if ~isrow(L)
    error('L is not a row vector.');
end
if ~isequal(L,u)
    error('L is not equal to u')
end
