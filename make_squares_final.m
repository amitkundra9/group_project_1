function [the_illusion] = make_squares(actual_number)

assert(isnumeric(actual_number), 'Need input to be numeric.');
%makes sure that the input given is indeed numeric

numSquares = actual_number*5;
my_vec = ones(1, numSquares);
%creates a row vector of ones equal to the input number multiplied by 5

my_vec(5:5:numSquares) = 0;
%sets every 5 indices at a value of 0

my_vec2 = my_vec';
%creates a new column vector as the transpose of the first

the_mat = my_vec.*my_vec2;
%creates a new matrix using the outer product of the two created vectors

the_mat2 = ~the_mat;
%creates a new matrix equal to the transpose of the previously created
%matrix

the_illusion = the_mat2;
%sets this matrix to be the output of our function, the illusion

imagesc(the_illusion);
%displays the data in the matrix as an image

colormap gray
axis image;
axis off;
%makes the axes look nicer
