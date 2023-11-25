clear
param.modulation.type = 'ask'; % one of 'ook', 'ask', 'psk', 'qam', 'dpsk'
param.modulation.M = 2;
param.channel_coding.type = 'rep';
param.channel_coding.decoder = 'hard';
param.channel_coding.k = 2;
param.channel_coding.rep_factor = 3; %=> n = 2 * 3 = 6
param.pulse_shaping.type = 'none';
param.channel.type = 'awgn';
param.channel.snr_type = 'snr';
param.channel.snr = 10; % with 10 dB there should not occur errors with the settings from above
param.channel.is_bandwidth_limited = false;
param.carrier_modulation.type = 'none';


% initialize parameter
param = channel_encoding.initialize(param);
param = modulation.initialize(param);
param = channel.initialize(param);
param = channel_decoding.initialize(param);

% create random bit sequence
u = uint8(randi([0,1],1,1000));

% channel encoding
c = channel_encoding(param,u);
if ~isa(c,'uint8')
    error('c is not of type uint8')
end

% modulate
x = modulation(param,c);

% channel
y = channel(param,x);

% demapping
L = demapping(param,y);

% channel decoding
u_hat = channel_decoding(param,L);

%% Checks
if ~isa(u_hat,'uint8')
    error('u_hat is not of type uint8')
end
if ~isrow(u_hat)
    error('u_hat is not a row vector.');
end
if ~isequal(u_hat,u)
    error('L is not equal to u')
end
