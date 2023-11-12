% creates a struct from create_huffman with parameters from subtask 1.1 and
% stores the struct in a file files/huffman_dms.mat

% M = [4, 2, 7, 1, 5, 17];
% pM = [4, 10, 12, 14, 20, 50];
% B = 1;

% M = [1, 2, 3];
% pM = [20, 50, 30];
% B = 2;

M = linspace(1,80,80);
pM = linspace(0,1,80);
B = 2;

huffStruct = helpers.create_huffman(M, pM, B);

disp(huffStruct.combs);
disp(huffStruct.symbol_codes);

% Save the struct to a .mat file
save('files\huffman_dms.mat', "huffStruct");
