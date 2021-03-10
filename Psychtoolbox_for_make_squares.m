Screen('Preference', 'SkipSyncTests', 1);
% my initial screenTest command failed, so here I am skipping some tests

sca;
close all;
clear all;
% This is the given Boilerplate for the start of all scripts
% It clears all screens and figures and also clears all workspace variables

 

PsychDefaultSetup(2);
%calling default settings for Psychtoolbox setup

screens = Screen('Screens');
%This tells us the number of screens for my computer, default should be 0

screenNumber = max(screens);
%This finds the maximum screen number; if there is more than one screen
%attached to my computer, the higher numbered one will be treated as the
%external display. we want to use the external display

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
%Here we define white, black, and grey according to luminance values for
%the display

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);
%this opens a new window on the screen number (screenNumber) we set, and
%colors it black

[screenXpixels, screenYpixels] = Screen('WindowSize', window);
%we store the width of the screen in pixels in the variable screenXpixels,
%and the height in the variable screenYpixels

ifi = Screen('GetFlipInterval', window);
%stores minimum possible time between two screen drawings (a frame),
%inter-frame-interval, in variable ifi

rr = FrameRate(window);
%stores refresh rate of screen into variable rr

topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);
%sets program at max priority level so it can run uninterrupted by other
%programs

[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Hello and Welcome to our Optical Illusions Project \n \n You can always press any key to continue to the next page',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%adding text for an intro page, and telling the user that they can press
%any key always to move to the next page

DrawFormattedText(window, 'This first illusion is simple \n \n It shows a number of black squares, \n and you might see black dots at the intersections, \n where there aren''t any',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%introduces first illusion

make_squares(35);
set(gcf,'InvertHardCopy', 'off');
saveas(gcf, 'first_grid_illusion.png');
close(gcf);
%calling my function for display on the screen, with 35 squares to start

the_image = imread('first_grid_illusion.png');
[s1, s2, ~] = size(the_image);

if s1 > screenYpixels || s2 > screenXpixels
    disp('Image is bigger than the screen');
    sca;
    return;
end
%this aborts the process in case our image is too big to fit on our screen

imageTexture = Screen('MakeTexture', window, the_image);
%this creates a "texture" out of the image so that Psychtoolbox can
%understand it

Screen('DrawTexture', window, imageTexture, [],[],0);
%actually draws the image on the screen

Screen('Flip', window);
%calls the flip function so we can see the image drawn on the screen
KbStrokeWait;

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'You can choose how many squares you want to see in this grid illusion!',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%we will be allowing the user to input the number of squares they want to
%see in the grid illusion

while 1
    Screen('TextSize', window, 60);
    Screen('TextFont', window, 'Courier');
    input_squares = Ask(window,'Enter a number between 25 and 70, and divisible by 5, or enter qqq to quit: ',...
        [0 0 0], [white], 'GetChar','center', 'center');
    numSquares = str2double(input_squares);
    
    if input_squares == "qqq" || ~mod(numSquares,5)==0 || numSquares<25 || numSquares>70
        break
    end
    %takes the user input and echoes to screen
    
    Screen('TextSize', window, 40);
    Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, 'Here is your custom made grid illusion:',...
        'center', screenYpixels * 0.5, [0 0 0]);
    Screen('Flip', window);
    KbStrokeWait;
    
    make_squares(numSquares);
    set(gcf, 'InvertHardCopy', 'off');
    saveas(gcf,'second_grid_illusion.png');
    close(gcf);
    %calling calling my function for display on the screen,
    %with the user input value numSquares to start
    
    the_image = imread('second_grid_illusion.png');
    [s1, s2, ~] = size(the_image);

    if s1 > screenYpixels || s2 > screenXpixels
    disp('Image is bigger than the screen');
    sca;
    return;
    end
    %this aborts the process in case our image is too big to fit on our 
    %screen

    imageTexture = Screen('MakeTexture', window, the_image);
    %this creates a "texture" out of the image so that Psychtoolbox can
    %understand it

    Screen('DrawTexture', window, imageTexture, [],[],0);
    %actually draws the image on the screen

    Screen('Flip', window);
    %calls the flip function so we can see the image drawn on the screen
    KbStrokeWait;
end
    
    
    


sca;

