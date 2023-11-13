% creates a struct from create_huffman with parameters from subtask 1.1 and
% stores the struct in a file files/huffman_dms.mat

% test 1 (covers almost all cases)
% M = [4, 2, 7, 1, 5, 17];
% pM = [4, 10, 12, 14, 20, 50];
% B = 1;

% test 2 (B > 1 test)
% M = [1, 2, 3];
% pM = [20, 50, 30];
% B = 2;

% test 3 (large dataset test)
% M = linspace(1,80,80);
% pM = linspace(0,1,80);
% B = 2;

M = [0 1 2];
pM = [0.27, 0.46, 0.27];
B = 2;

huffStruct = helpers.create_huffman(M, pM, B);

% ============= testing ===========================
% disp(huffStruct.combs);
% disp(huffStruct.symbol_codes);
% message = [0 2 1 1 0 2 2 2 2 1 0 2 1 0 2 0 2 1 1 1 0 2 2 0 1 0 1 0 2 1 1 1];
% cipher = source_encoding.huffman(huffStruct, message);
% disp(cipher);
% message_decoded = source_decoding.huffman(huffStruct, cipher);
% disp(message_decoded);
% =================================================

% uncomment below to use the script from anywhere in the project
% make sure to replace full path with the path of the project
% scriptPath = fileparts(mfilename('full path'));

% Define the full path to the file in the 'files' subfolder
filePath = fullfile('..', 'files', 'huffman_dms.mat');

% Save the struct to a .mat file
save(filePath, "huffStruct");
