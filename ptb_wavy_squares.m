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