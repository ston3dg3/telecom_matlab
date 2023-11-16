function [output] = huffman_img(huffman_structure, img_width, img_height, input_seq)
% calculates the differential image and uses Huffman encoder in huffman.m
% to compress the image

% reshape image to matrix form
image = reshape(input_seq, [img_width, img_height])';

% get differential image
diff_img_mod = calculateDifferentialImg(image, 256);

% convert image back to vector
diff_img_sequence = reshape(diff_img_mod, 1, numel(diff_img_mod));

% encode the differential image sequence
output = source_encoding.huffman(huffman_structure, diff_img_sequence);

% ====================== HELPER FUNCTIONS ===================================

function [diff_img_mod] = calculateDifferentialImg(img, int_size)
% generate differential modulo image
zero_column = zeros(size(img, 1), 1);
slice1 = img(: , 1:end-1);
shifted_slice = [zero_column slice1];
diff_img = img - shifted_slice;
diff_img_mod = mod(diff_img, int_size);
end

end

