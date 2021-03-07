function offset_squares_1(x, y)
%offset_squares1  generates an optical illusion with a more offset checkerboard
%pattern than offset_squares, which gives the illusion of slanted lines. I want to see
%if the degree of offset between the checkers influences the intensity of
%the illusion

%allows user to pick the size and color of the optical illusion
x = input('How tall do you want your illusion to be? Input any natural number\n');
y = input('Do you want your optical illusion to be white, cyan, or pink?\n','s');

%initialize a matrix of zeros with the user input of size
illusion = zeros(x, 5*x);

%puts 1s into the matrix such that each row is offset by 2 columns, giving
%more prounounced offset which may make the illusion more pronounced
illusion(:, 3:8:5*x) = 1;
illusion(:, 4:8:5*x) = 1;
illusion(1:2:x, 5:8:5*x) = 1;
illusion(1:2:x, 6:8:5*x) = 1;
illusion(2:2:x, 1:8:5*x) = 1;
illusion(2:2:x, 2:8:5*x) = 1;

%allows the user to select a white and black checkerboard
if strcmp(y,'white') || strcmp(y,'White')
    whiteillusion = cat(3, illusion, illusion, illusion);

    %Illusion is more pronounced when lines are placed in between each row of
    %the matrix, for loop allows for user input
    imagesc(whiteillusion);
    hold on;
    for ii = 1.5:1:(x + 0.5)
        yline(ii,'b','LineWidth',2);
    end
    colormap gray;
    axis off;
end

%allows the user to select a cyan and black checkerboard
if strcmp(y,'cyan') || strcmp(y,'Cyan')
    cyanillusion = cat(3, 0*illusion, illusion, illusion);

    imagesc(cyanillusion);
    hold on;
    for ii = 1.5:1:(x + 0.5)
        yline(ii,'b','LineWidth',2);
    end
    axis off;
end

%allows the user to select a pink and black checkerboard
if strcmp(y,'pink')  || strcmp(y,'Pink')
    pinkillusion = cat(3, illusion, 0*illusion, illusion);

    imagesc(pinkillusion);
    hold on;
    for ii = 1.5:1:(x + 0.5)
        yline(ii,'b','LineWidth',2);
    end
    axis off;
end

end