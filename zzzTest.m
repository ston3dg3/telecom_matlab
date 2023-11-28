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
% =============================================================


