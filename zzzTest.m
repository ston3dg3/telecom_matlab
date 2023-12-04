% TEST FILE
fprintf("\n");
% ====================================== variabe declaration
seq_in = uint8([1 1 0 1 0 0 1 1 1 0]);
X = [1 1i -1 -1i];
label = [0 0 ; 0 1 ; 1 1 ; 1 0];
% ============================== test for map_constellation():
fprintf("========= map_to_constellation() ==============\n");
fprintf("seq_in: %s\n", mat2str(seq_in));
seq_out = modulation.map_to_constellation(seq_in,X,label);
fprintf("seq_out: %s\n", mat2str(seq_out));
fprintf("===============================================\n");
% ============================== test for demapping/hd.m()
fprintf("================ demapping.hd() ===============\n");
fprintf("X vector: %s\n", mat2str(X));
fprintf("original: %s\n", mat2str(seq_out));
demapped_seq = demapping.hd(seq_out, X, label);
fprintf("demapped: %s\n", mat2str(demapped_seq));
fprintf("===============================================\n");
% ===================== test for map_to_diff_constellation()
fprintf("========= map_to_diff_constellation() ==========\n");
fprintf("seq_in: %s\n", mat2str(seq_in));
seq_out = modulation.map_to_diff_constellation(seq_in, X, label);
fprintf("seq_out: %s\n", mat2str(seq_out));
fprintf("================================================\n");
% ===================== test for hd_diff =====================
fprintf("========= demapping.hd_diff() ===================\n");
fprintf("X vector: %s\n", mat2str(X));
fprintf("original: %s\n", mat2str(seq_out));
demapped_seq = demapping.hd_diff(seq_out, X, label);
fprintf("demapped: %s\n", mat2str(demapped_seq));
fprintf("=================================================\n");
% ===================== test for soft decoding ================
M = 8;
N0 = 4;
repSpace = 12;
mySeq = uint8([0 0 1 0 1 1 1 0 1 0 1 0 1 1 0 0 0 0 0 1 0 1 0 1 1 0 1 0 0 0]);
m = log2(M);
n_r = repSpace/m;
[~, myLabel] = modulation.get_ask(M);
myX = [-7 -5 -3 -1 1 3 5 7];
fprintf("========= soft decoding ==============\n");
fprintf("seq_in: %s\n", mat2str(mySeq));
% add redundancy throuhgh repetition codes:
seq_inMat = reshape(mySeq, m, length(mySeq)/m)';
seq_outMat = repmat(seq_inMat, 1, n_r);
repeated_seq = uint8(reshape(seq_outMat', numel(seq_outMat), 1)');
modulated_seq = modulation.map_to_constellation(repeated_seq,myX,myLabel);
fprintf("seq_out: %s\n", mat2str(modulated_seq));

% add noise:
fprintf("nosiy seq: %s\n", mat2str(channel.awgn(modulated_seq, channel.get_N0('snr', 15, 8, myX, 1)),2))
harddemapped_seq = demapping.hd(modulated_seq, myX, myLabel);
softdemapped_seq = demapping.sd(modulated_seq, myX, myLabel, N0);
fprintf("hard demapped seq: %s\n", mat2str(harddemapped_seq, 2));
fprintf("soft demapped seq: %s\n", mat2str(softdemapped_seq, 2));
i = 1;
j = 1;
harddecoded_seq = zeros(1, length(mySeq));
softdecoded_seq = zeros(1, length(mySeq));
while(i<length(harddemapped_seq) && j < length(harddemapped_seq))
    harddecoded_seq(i:i+m-1) = channel_decoding.hard_repetition(harddemapped_seq(j:j+repSpace-1), repSpace, m);
    softdecoded_seq(i:i+m-1) = channel_decoding.soft_repetition(softdemapped_seq(j:j+repSpace-1), repSpace, m);
    i = i + m;
    j = j + repSpace;
end
fprintf("coparison mySeq: %s\n", mat2str(mySeq));
fprintf("harddecoded seq: %s\n", mat2str(harddecoded_seq));
fprintf("softdecoded seq: %s\n", mat2str(softdecoded_seq));
fprintf("===============================================\n");

% =============================================================
% =============================================================
% =============================================================
% =============================================================
% =============================================================
% =============================================================
% =============================================================
% =============================================================
% =============================================================
% =============================================================


