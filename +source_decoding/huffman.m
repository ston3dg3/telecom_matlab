function [output] = huffman(huffman_structure,input_seq)
%huffman - reverts the Huffman coding. Takes a bit string of arbitrary
%length and returns the symbols according to the table created in create_huffman

% define useful variables
table = huffman_structure.symbol_codes;
max_depth = huffman_structure.depth;

% at the time of decoding we do not know how long the bit stream should be,
% therefore we read the bit stream until a symbol cannot be resolved.

out1 = alwaysSearchForBuffer(table, input_seq, max_depth);
output = out1;

% out2 = searchForSingleBit(table, input_seq, max_depth);
% output = out2;

% ======================== Functions ===============================
% Below are two implementations of decoding, the first one works and
% is currently faster for small input data.

% IMPLEMENTATION 1
function [decoded_symbols] = alwaysSearchForBuffer(table, input_seq, max_depth)
fprintf("\n======== STARTED DECODING ==============\n");
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
fprintf("\n======== FINISHED DECODING ==============\n");
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
        disp(eliminate);
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


function printer(string, obj)
    fprintf("%s\n", string);
    disp(obj);
end

% end of main function
end

