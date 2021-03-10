sca;
close all;
clear all;
PsychDefaultSetup(2);

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
table_of_contents = Ask(window,'Table of contents: \n 1. Offset Squares \n 2. Wavy Squares', [1 1 1], [black], 'GetChar','center', 'center');
      
table_of_contents = str2double(table_of_contents);


while table_of_contents == 1
%PTB boiler plate
sca;
close all;
clear all;
PsychDefaultSetup(2);

%identifying screens
screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

%screen info
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);

%first page, displays explanatory text, pressing any button will navigate
%to next slide
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Time for another illusion... \n Press any key to go to subsequent pages',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

start_time = GetSecs;

%second page, displays explanatory text, pressing any button will navigate
%to next slide
DrawFormattedText(window, 'This is the offset squares illusion. \n It uses an offset checkerboard \n to make the squares look slanted',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

%third page, displays explanatory text, pressing any button will navigate
%to next slide
DrawFormattedText(window, 'Assess the effectiveness of the illusion \n with different colors and numbers of squares',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

%fourth page, displays explanatory text, pressing any button will navigate
%to next slide
DrawFormattedText(window, 'This is an example of the illusion in white with height 5',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

%fifth page, shows example optical illusion
offset_squares_fxn(5,1);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf,'offset_squares.png');
close(gcf);
illusion = imread('offset_squares.png');

imageTexture = Screen('MakeTexture', window, illusion);
Screen('DrawTexture', window, imageTexture, [], [], 0);
Screen('Flip', window);
KbStrokeWait;


while true
    %sixth page, asks user for height input
    Screen('TextSize', window, 40);
    Screen('TextFont', window, 'Courier');
    height = Ask(window,'How tall should your illusion be? (Integer between 1 and 30, qqq to quit):', [1 1 1], [black], 'GetChar','center', 'center');
        
    doubleheight = str2double(height);
    
    %breaks if input is outside of parameters or the user quits with "qqq"
    if height == "qqq" || doubleheight <= 0 || doubleheight > 50
        break
    end

    %seventh page, asks user for color input
    Screen('TextSize', window, 40);
    Screen('TextFont', window, 'Courier');
    color = Ask(window,'What color should your illusion to be? (1 = white, 2 = cyan, 3 = pink):',...
    [1 1 1], [black], 'GetChar','center', 'center');
    doublecolor = str2double(color);
    
    %breaks if input is outside of parameters
    if color == "qqq" || doublecolor < 1 || doublecolor > 3
        break
    end

    %eighth page, shows custom illusion by calling the function offset_squares_fxn
    offset_squares_fxn(doubleheight,doublecolor);
    set(gcf, 'InvertHardCopy', 'off');
    saveas(gcf,'offset_squares.png');
    close(gcf);
    illusion = imread('offset_squares.png')

    imageTexture = Screen('MakeTexture', window, illusion);
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    Screen('Flip', window);
    KbStrokeWait;
end

%ninth page, asks user for color input
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
best_height = Ask(window,'Which size produced the best illusion?:',...
[1 1 1], [black], 'GetChar','center', 'center');
best_height = str2double(best_height);

%storing best height in separate txt file
best_height_txt = fopen('offset_squares_height_output.txt','a');
fprintf(best_height_txt, '%0.3f\n', best_height);
fclose(best_height_txt);
aggregate_user_time = dlmread('offset_squares_height_output.txt');
average_height = mean(aggregate_user_time);

%opens txt file and stores the time spent in it, also calculates the
%average time of all users
end_time = GetSecs; % store the end time in end_time
time_spent = end_time - start_time;
time_output = fopen('offset_squares_time_output.txt','a');
fprintf(time_output, '%0.3f\n', time_spent);
fclose(time_output);
all_user_time = dlmread('offset_squares_time_output.txt');
avg_time = mean(all_user_time);

% tenth page
% displays the average time and the amount of time the user spent on this
% section to two decimal places
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, sprintf('You spent %0.2f seconds in this section. \n The average user spent %0.2f seconds.', [time_spent avg_time]),'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

% eleventh page - displaying best height info
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, sprintf...
        ('You thought %d was the best height. \n The average favorite height was %.0f', [best_height average_height]),...
        'center', screenYpixels * 0.5, [1 1 1]); 
Screen('Flip', window);
KbStrokeWait;

sca; 
end

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
table_of_contents = Ask(window,'Table of contents: \n 1. Offset Squares \n 2. Wavy Squares', [1 1 1], [black], 'GetChar','center', 'center');
      
table_of_contents = str2double(table_of_contents);


while table_of_contents == 2
% append to the beginning of any script
sca; % abbreviation for Screen(‘CloseAll’).
close all;
clear all;
PsychDefaultSetup(2);

screens = Screen('Screens'); % #of screens attached
screenNumber = max(screens); % choose one

% define white, black, and grey
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

% set screen black
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% get screen info
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);

% page1
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'The next optical illusion is called "the wavy squares"',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

start_time = GetSecs; % get real world time when this line is executed
% page2
% call function wavy_squares
wavy_squares(16);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf,'wavy_squares.png');
close(gcf);

% scale image to fit screen
the_image = imread('wavy_squares.png');
[s1, s2, ~] = size(the_image);
scale = min(screenXpixels/1.5/s1,screenYpixels/1.5/s2);
firstX = (screenXpixels-s2*scale)/2; firstY = (screenYpixels-s1*scale)/2;
lastX = firstX+s2*scale; lastY = firstY+s1*scale;

% display image
imageTexture = Screen('MakeTexture', window, the_image);
Screen('DrawTexture', window, imageTexture, [], [firstX, firstY, lastX, lastY], 0);
Screen('Flip', window);
KbStrokeWait; 

% page3
Screen('TextSize', window, 35);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, ...
    'You can make a customized wavy squares illusion \nby changing the number of squares in each row/column',...
    'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

while 1
    % page4
    % take user keyboard input, echo it to screen.
    Screen('TextSize', window, 35);
    Screen('TextFont', window, 'Courier');
    input_squares = Ask(window,'Enter an even number beween 10 and 40 or enter qqq to quit: ',...
        [1 1 1], [black], 'GetChar','center', 'center');
    num_squares = str2double(input_squares);
    
    if input_squares == "qqq" || ~mod(num_squares,2)==0 || num_squares<10 || num_squares>40
        break
    end

    % page5
    Screen('TextSize', window, 40);
    Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, 'Here is your custom made illusion',...
        'center', screenYpixels * 0.5, [1 1 1]);
    Screen('Flip', window);
    KbStrokeWait;
    
    % page6
    % call function wavy_squares (again)
    wavy_squares(num_squares);
    set(gcf, 'InvertHardCopy', 'off');
    saveas(gcf,'wavy_squares.png');
    close(gcf);
    
    the_image = imread('wavy_squares.png');
    [s1, s2, ~] = size(the_image);
    scale = min(screenXpixels/1.5/s1,screenYpixels/1.5/s2);
    firstX = (screenXpixels-s2*scale)/2; firstY = (screenYpixels-s1*scale)/2;
    lastX = firstX+s2*scale; lastY = firstY+s1*scale;
    
    imageTexture = Screen('MakeTexture', window, the_image);
    Screen('DrawTexture', window, imageTexture, [], [firstX, firstY, lastX, lastY], 0);
    Screen('Flip', window);
    KbStrokeWait;
end

end_time = GetSecs; % get time again
time_spent = end_time - start_time; % calculate time user spent
time_output = fopen('wavy_squares_time_output.txt','a');
fprintf(time_output, '%0.3f\n', time_spent);
fclose(time_output);
all_user_time = dlmread('wavy_squares_time_output.txt');
avg_time = mean(all_user_time);

% page7
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, sprintf...
        ('You spent %0.2f seconds on this illusion. \nAverage user spent %0.2f seconds on this illusion.', [time_spent avg_time]),...
        'center', screenYpixels * 0.5, [1 1 1]); % print out time to 2 decimals
Screen('Flip', window);
KbStrokeWait;

sca;
end