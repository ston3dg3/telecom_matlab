function [huffman_structure] = create_huffman(M, pM, B)
%CREATE_HUFFMAN creates a huffman tree structure from a list of symbols and their probabilities 
%   Detailed explanation goes here
%   Inputs:
%       M: all possible source symbols
%       pM: probabilities of the source symbols
%       B: numbers of source symbols to combine
%   Outputs:
%       huffman_structure: struct containing huffman data tree

huffman_structure = struct();
huffman_structure.B = B;
huffman_structure.M = M;

% Check for incorrect user input
if B > length(M)
    error('B is greater than the length of M.');
end

if length(M) ~= length(pM)
    error('The lengths of M and pM dont match')
end

% =================== GETTING ALL COMBINATIONS ========================

% Generate all possible messages (combinations of length B of symbols from M);
cell_arr = cell(1,B);
for i = 1:B
    cell_arr{i} = M;
end
combs = combinations(cell_arr{:});
% convert table to matrix
combs = combs{:,:};

% calculate probability for all messages in combs (all rows)
% then add the probability as first column of matrix 'table'
prob=zeros(length(combs),1);
for i=1:length(combs)
    % p is the probability of the new symbol of length B
    p=1;
    for j=1:B
        probIndex = M==combs(i,j);
        p = p * pM(probIndex);
    end
    prob(i) = p;
end
table = [prob, combs];

% sort messages with respect to (increasing) probability
sortedTable = sortrows(table,1);
% note: this is required for the generation of the huffman tree

% disp(sortedTable);
huffman_structure.combs = sortedTable;

% ==================== TREE GENERATION ==============================

% huffman coding using array trees.
% idea: have the main cell array hold matrices of size 2xL where L is the length of the
% tree at the corresponding position (L+1 is always a power of 2). First row of each matrix is the
% probability and all other rows represent the new symbol string to send.
% The trees (matrices) will be dynamically scaled with each iteration of
% the loop in order to store more nodes. At the end we will have just one matrix with all symbols and
% their probabilites which allows for easy symbol-probability lookups.

% main cell array cell_arr stores cell arrays that store struct huffNode
cell_arr = cell(1, size(sortedTable,1));

for i=1:size(sortedTable,1)
    % create a starter tree with one node (a column vector)
    huffTree = sortedTable(i,:)';
    % position 1 of huffNode is probability, the rest are symbols
    % note: huffTree has length 1+B
    % insert tree into main cell array
    cell_arr{i} = huffTree;
end

while(length(cell_arr)>=1)
    % get 2 nodes with smallest probability
    S_L = cell_arr{1}; % get left child (type: matrix (tree))
    S_R = cell_arr{2}; % get right child (type: matrix (tree))

    % remove first 2 elements from main cell array
    cell_arr(1:2) = [];

    % create new node with combined probability
    empty = -1;
    empty_symbols = empty * ones(1, B);
    % 1 for pobability, 1 for first element in child tree
    combined_p = S_L(1,1) + S_R(1,1);
    S_root = [combined_p empty_symbols]';

    % preallocate an empty matrix of appriopriate size assuming complete binary
    % tree.
    length_L = size(S_L, 2);
    length_R = size(S_R, 2);
    bigger_length = max(length_L, length_R);
    new_length = 2*bigger_length+1;
    new_tree = zeros(1+B, new_length);

    % expaned the tree by adding a root node and putting S_L und S_R at the
    % right indices (S_L goes to 2*i, S_R goes to 2*i+1) 
    new_tree(:, 1) = S_root;
    
    i = 1;
    % fill new_tree with slices from S_L 
    while(i-1 < length_L)
        % get slice of S_L - size increasing with power of 2
        fprintf("L | i:%d, 2*i-1:%d\n",i, 2*i-1); % uncomment for debug
        S_L_slice = S_L(:, i:2*i-1);
        % determine start and end index for each level of the tree
        start_index = i*2;
        end_index = i*2 + (i-1);
        % add the slice to the tree at the right position
        new_tree(:, start_index:end_index) = S_L_slice;
        % index increases exponentially
        i = i * 2;
    end

    % reset index i
    i = 1;
    % fill new_tree with slices from S_R
    while(i-1 < length_R)
        % get slice of S_R - size of slice increasing with power of 2
        fprintf("R | i: %d, 2*i-1: %d\n",i, 2*i-1); % uncomment for debug
        S_R_slice = S_R(:, i:2*i-1);
        % determine start and end index for each level of the tree
        start_index = i*2 + (i);
        end_index = 4*i - 1;
        % add the slice to the tree at the right position
        new_tree(:, start_index:end_index) = S_R_slice;
        % index increases exponentially
        i = i * 2;
    end

    % if last 2 trees are being combined, no need to check for insert index
    if(isempty(cell_arr))
        cell_arr{1} = new_tree;
        % uncomment for debugging
        % fprintf("final matrix:\n");
        % celldisp(cell_arr);
        break
    end
    
    biggest_p = true;
    % insert sort the newly created tree by considering p of the root of each
    % tree. Search for the right index of the main cell array
    for i=1:length(cell_arr)
        % get tree to compare with new_tree
        current_tree = cell_arr{i};
        % get probability of the root node
        p_i = current_tree(1, 1);
        
        % compare probabilities
        if(combined_p <= p_i)
            % the combined p is not the biggest p
            biggest_p = false;
            % insert new tree at this index
            cell_arr = [cell_arr(1:i-1), new_tree, cell_arr(i:end)];
            break;
        end
    end
    % if the combined p is biggest yet, add new_tree at the end
    if(biggest_p)
        cell_arr = [cell_arr(1:end), new_tree];
    end

    % uncomment for debugging
    % celldisp(cell_arr);
    % fprintf("==================breaker===============\n");
end

% extract the resulting matrix from the cell array
table = cell_arr{1};
% remove zeros from the matrix so that it's shorter and more readable for
% debug
% table(:,any(table==0)) = [];
% note that probability 0 does not make sense and therefore can be used as
% an "empty" value in the matrix

% uncomment for debugging
% disp(table);

% assign table to the struct
huffman_structure.tree = table;
	
end

