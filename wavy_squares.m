% wavy_squares(num_squares) generates a checkerboard pattern with black and 
% white circles at the junctions. The resulting image will create an optical 
% illusion that makes the squares seem wavy.
% The input num_squares need to be an even number

function  wavy_squares(num_squares)

assert(isnumeric(num_squares),'Input must be numeric.') 
assert(mod(num_squares,2)==0,'Input must be an even number.') 

% use repmat to generate grayscale images of dark gray squares
dark_gray = repmat(155,50,50);
light_gray = repmat(210,50,50);

% make a 2*2 grid (4 alternating squares)
twobytwo = [dark_gray, light_gray; light_gray, dark_gray];

% use repmat again to make the full checkerboard pattern
img = repmat(twobytwo,(num_squares/2),(num_squares/2));
imshow(uint8(img),[0,255]);
hold on

% to produce the optical illusion, use function "filled_circle" to plot 
% circles centered at (x,y) and color 'k' or 'w', arrange the circles by 
% the pattern specified in matrix M.
v = [0 1 1 0 1 0 0 1];
w = repmat(v,1,ceil(num_squares/8)+1);
first_row = w(1:num_squares+1);
M = first_row;

for ii = 1:num_squares+1
    M = [M; circshift(first_row,ii)]; % each row is the previous row shifted to the right by 1 
    y = 50*(ii-1)+0.5; 

    x1_all = 50*(find(M(ii,:)==1)-1)+0.5; % x coordinates of black circles 
    % plot black circles centered at (x1,y) with radius = 8
    for x1 = x1_all(1:end)
        angle_step = 0:pi/50:2*pi;
        coordinate_x = 8 * cos(angle_step) + x1;
        coordinate_y = 8 * sin(angle_step) + y;
        plot(coordinate_x, coordinate_y);
        fill(coordinate_x, coordinate_y,'k','LineStyle','none');
    end
    
    x2_all = 50*(find(M(ii,:)==0)-1)+0.5; % x coordinates of white circles 
    % plot  white circles centered at (x2,y) with radius = 8
    for x2 = x2_all(1:end)
        angle_step = 0:pi/50:2*pi;
        coordinate_x = 8 * cos(angle_step) + x2;
        coordinate_y = 8 * sin(angle_step) + y;
        plot(coordinate_x, coordinate_y);
        fill(coordinate_x, coordinate_y,'w','LineStyle','none');
    end
    
end