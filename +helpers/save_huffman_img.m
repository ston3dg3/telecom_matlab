% loads sample image, generates differential image (pixels) and finds
% the empirical distribution of the difference values.

% load sample image
param.source.type = 'image';
param.source.filename = 'files/lena.pgm';
param = source.initialize(param); % init source

% reshape image such that it is in matrix form as defined before
img = reshape(param.source.sequence, [param.source.image.width, param.source.image.height])';
% image is 512 by 512 pixels


%A_diff(i+1,j+1) = (A(i+1,j+1) - A(i+1,j));

% slice1 = 
% slice2 = 

% create huffman structure. 
huffman_structure = helpers.create_huffman(M, pM, 1);

% Define the full path to the image file in the 'files' subfolder
filePath = fullfile('..', 'files', 'huffman_img.mat');

% Save the struct to a .mat file
save(filePath, "huffman_structure");






