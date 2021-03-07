function offset_squares(x, y)
%This function generates an optical illusion in an offset checkerboard
%pattern, which gives the illusion of slanted lines

%allows user to pick the size and color of the optical illusion
x = input('How tall do you want your illusion to be? Input any natural number\n');
y = input('Do you want your optical illusion to be white, cyan, or pink?\n','s');

illusion = zeros(x, 4*x); %initialize a matrix of zeros with the user input of size

%puts 1s into the matrix such that each row is alternatingly offset by 1 column
illusion(2:2:x, 1:4:4*x) = 1;
illusion(:, 2:4:4*x) = 1;
illusion(1:2:x, 3:4:4*x) = 1;

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