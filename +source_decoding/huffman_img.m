function [output] = huffman_img(huffman_structure, img_width, img_height, encoded_seq)
% uses huffman decoder in huffman.m to reconstruct the differential image.
% Restores the original image from the differential image

% encode the differential image sequence
symbol_stream = source_decoding.huffman(huffman_structure, encoded_seq);
	
% reshape image to matrix form
% ERRROR
image = reshape(symbol_stream, [img_width, img_height])';

fprintf("decoded diff image\n")
disp(image);

% get original image from differential image
output = restoreFromDiff(image, 256);



% ====================== HELPER FUNCTIONS ===================================

function [recovered_img] = restoreFromDiff(diff_img, int_size)
% recover original image from differential
zero_column = zeros(size(diff_img, 1), 1);
slice = diff_img(:, 1:end-1);
shifted_slice = [zero_column slice];
recovered_img = mod((diff_img + shifted_slice), int_size);
end

end
