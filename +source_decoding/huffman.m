function [output] = huffman(huffman_structure,input_seq)
%huffman - reverts the Huffman coding. Takes a bit string of arbitrary
%length and returns the symbols according to the table created in create_huffman

% define useful variables
table = huffman_structure.symbol_codes;
max_depth = huffman_structure.depth;

% at the time of decoding we do not know how long the bit stream should be,
% therefore we read the bit stream until a symbol cannot be resolved.

% start timer
tic

out1 = alwaysSearchForBuffer(table, input_seq, max_depth);
output = out1;

% out2 = searchForSingleBit(table, input_seq, max_depth);
% output = out2;

% out3 = trieSolution(table, input_seq, max_depth);
% output = out3;

elapsed_time = toc;
fprintf("[Log] Finished decoding\n")
fprintf('[Log] Elapsed time: %.4f seconds\n', elapsed_time);
fprintf("======================================\n");

% ======================== Functions ===============================
% Below are two implementations of decoding, the first one works and
% is currently faster for small input data.

% IMPLEMENTATION 1
function [decoded_symbols] = alwaysSearchForBuffer(table, input_seq, max_depth)
decoded_symbols = [];
codewords = table(:,2);
symbols = table(:,1);
pointer = 1;
while pointer < length(input_seq)
    % preallocate buffer
    buffer = [];

    for i = pointer : pointer + max_depth

        % make sure we don't go beyond bit stream
        if(i>length(input_seq))
            error("Codeword:\n%s\nis not defined!", mat2str(buffer));
            break;
        end
        
        % prepare the next bit and add it to the buffer
        bit = input_seq(i);
        buffer = [buffer bit];

        % Search for the codeword in the codewords cell array
        index = find(cellfun(@(x) isequal(x, buffer), codewords), 1);

        if ~isempty(index)
            % match found
            symbol_index = index;
            symbol = uint8(symbols{index});
            decoded_symbols = [decoded_symbols symbol];
            % update pointer
            pointer = pointer + length(buffer);
            break;
        elseif length(buffer) == max_depth
            error("Codeword:\n%s\nis not defined!", mat2str(buffer));
        end
    end
end
end






% IMPLEMENTATION 2
function [decoded_symbols] = searchForSingleBit(table, input_seq, max_depth)
decoded_symbols = [];
pointer = 1;
while pointer <= length(input_seq)
    % start with full table and all indices available
    codewords = table(:,2);
    eliminate_indices = 1:length(codewords);
    % check if the string of bits read so far corresponds to a codeword
    match_found = false;

    % define a buffer for read bits.
    buffer = [];

    % start reading bits one by one
    for i = pointer : pointer + max_depth
        if(i>length(input_seq))
            fprintf("Reached end of the stream");
            break;
        end
        celldisp(codewords);
        % get the next bit and add it to the buffer
        bit = input_seq(i);
        buffer = [buffer bit];
        bit_index = i + 1 - pointer;

        % go through all bit arrays in huffman table
        % replace all non-matching codes with empty arrays and keep reading.
        eliminate = cellfun(@(x) x(bit_index) ~= bit, codewords(eliminate_indices), 'UniformOutput',false);
        nonEmptyIndices = find(cellfun(@(x) ~isempty(x), codewords));
        eliminate_indices = find(cellfun(@(x) isempty(x), codewords));
        codewords(eliminate_indices) = {[]};


        % once there is only 1 array left, it can be unambiguosly decoded
        if(length(nonEmptyIndices) == 1)
            match_found = true;
            symbol_index = nonEmptyIndices(1);
            symbol = uint8(table{1}(symbol_index));
            decoded_symbols = [decoded_symbols ; symbol];
            break;
        end

    end
    % symbols with codewords longer than those defined in huffman table
    % are undefined.
    if ~match_found
        fprintf("Codeword:\n%s\nis not defined!", mat2str(buffer));
        pointer = pointer + 1;
    end
end
end



% IMPLEMENTATION 3
function decoded_symbols = trieSolution(table, input_seq, max_depth)
    % Create a trie from the codewords
    trie = buildTrie(table(:,2), table(:,1));

    disp(trie);

    % print the tree

 
    % Initialize variables
    decoded_symbols = [];  % Initialize as an empty array
    current_node = trie;
    code_length = 1;
    
    % Decode the input sequence
    for i = 1:length(input_seq)
        % make sure we aren't exceeding max_depth of the tree
        assert(code_length<=max_depth, sprintf("Codeword of length %d found in encoded message is not defined!", code_length));

        % Go to either left child (1) or right child (2) of current node
        current_node = current_node.children{input_seq(i) + 1};

        % If a symbol is reached, add it to the decoded symbols
        % Then reset the node to root of trie.
        if ~isempty(current_node.symbol)
            decoded_symbols = [decoded_symbols, current_node.symbol];
            current_node = trie;  % Reset to the root of the trie
            code_length = 1; % reset code length
        else
            code_length = code_length + 1;
        end
    end
end

% a trie (prefix tree) is a data structure that works like a binary tree
% but it ensures that no codeword is a prefix of another codeword.
function trie = buildTrie(codewords, symbols)
    % Initialize the root of the trie
    trie = struct();
    trie.children = cell(1, 2);
    trie.symbol = [];

    % Populate the trie with codewords and corresponding symbols
    for i = 1:length(codewords)
        disp(trie);
        code = codewords{i};
        fprintf("\n=========== %d ============\n", i);

        current_node = trie;

        % Traverse the trie, creating nodes as needed
        for j = 1:length(code)
            % if its the first time creating children, start from root node
            if i==1
                trie = current_node;
            end
            
            % get next bit
            bit = code(j) + 1;  % Assuming code(j) is 0 or 1

            if isempty(current_node.children{bit})
                child_node = struct();
                child_node.children = cell(1, 2);
                child_node.symbol= [];
                current_node.children{bit} = child_node;
            end
            fprintf("== %d ==\n",j);
            disp(current_node);
            current_node = current_node.children{bit};
            disp(current_node);
        end

        % Assign the symbol to the leaf node
        current_node.symbol = symbols{i};
        fprintf("found symbol:\n")
        disp(current_node);
    end
end

% helper print function for objects
function printer(string, obj)
    fprintf("%s\n", string);
    disp(obj);
end

% useful print for the huffman table
function printHuff(table)
fprintf("\n======================\n");
for i=1:length(table)
    fprintf("s: %s | c: %s\n", mat2str(table{i,1}), mat2str(table{i,2}));
end
fprintf("======================\n")
end

function printTrie(node, prefix)
    % Recursive function to print the trie structure
    disp([prefix 'Symbol: ' num2str(node.symbol)]);
    
    for i = 1:2
        if ~isempty(node.children{i})
            printTrie(node.children{i}, [prefix num2str(i-1)]);
        end
    end
end

% end of main function
end

