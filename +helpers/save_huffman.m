% creates a struct from create_huffman with parameters from subtask 1.1 and
% stores the struct in a file files/huffman_dms.mat

% M = [4, 2, 7, 1, 5, 17];
% pM = [4, 10, 12, 14, 20, 50];

M = [1, 2, 3];
pM = [20, 50, 30];
B = 2;


tree_struct = create_huffman(M, pM, B);

disp(tree_struct.combs);
disp(tree_struct.tree);

% Save the struct to a .mat file
save('files\huffman_dms.mat', "tree_struct");
