function [the_illusion] = make_squares(numSquares)

assert(isnumeric(numSquares), 'Need input to be numeric.');
assert(mod(numSquares,5)==0, 'Need input to be divisible by 5.');

my_vec = ones(1, numSquares);
my_vec(5:5:numSquares) = 0;
my_vec2 = my_vec';
the_mat = my_vec.*my_vec2;
the_mat2 = ~the_mat;
the_illusion = the_mat2;
imagesc(the_illusion);
colormap gray
axis image;
axis off;
