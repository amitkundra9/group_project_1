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
DrawFormattedText(window, 'Hello and Welcome to our Optical Illusions Project. \n \n You can always press any key to continue to the next page.',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%adding text for an intro page, and telling the user that they can press
%any key always to move to the next page

DrawFormattedText(window, 'This first illusion is simple. \n \n It shows a number of black squares, \n and you might see black dots at the intersections, \n where there aren''t any',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%introduces first illusion

start_time = GetSecs;
%gets real time of execution of this line

make_squares_final(7);
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
DrawFormattedText(window, 'You can make any m x m grid of squares appear in this grid illusion!',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%we will be allowing the user to input the number of squares they want to
%see in the grid illusion

while 1
    Screen('TextSize', window, 60);
    Screen('TextFont', window, 'Courier');
    input_squares = Ask(window,'Enter integer m from 5-14 to make an m x m grid (try small & large inputs), or enter qqq to quit: ',...
        [0 0 0], [white], 'GetChar','center', 'center');
    givenNumber = str2double(input_squares);
    
    if input_squares == "qqq" || givenNumber<5 || givenNumber>14
        break
    end
    %takes the user input and echoes to screen
    
    Screen('TextSize', window, 40);
    Screen('TextFont', window, 'Courier');
    
    DrawFormattedText(window, 'Here is your custom made grid illusion:',...
        'center', screenYpixels * 0.5, [0 0 0]);
    Screen('Flip', window);
    KbStrokeWait;
    
    make_squares_final(givenNumber);
    set(gcf, 'InvertHardCopy', 'off');
    saveas(gcf,'second_grid_illusion.png');
    close(gcf);
    %calling my function for display on the screen,
    %with the user input value givenNumber to start
    
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
    
end_time = GetSecs;
%gets real time at end of illusion

Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
more_prounounced_illusion = Ask(window,'Was the illusion more pronounced with less or more squares? Answer (1) for less, or (2) for more : ',...
        [0 0 0], [white], 'GetChar','center', 'center');
more_prounounced_illusion = str2double(more_prounounced_illusion);
%asking the user if they felt the illusion was more pronounced with more or
%less squares

pronounced_txt = fopen('pronounced_illusion.txt','a');
fprintf(pronounced_txt, '%d\n', more_prounounced_illusion);
fclose(pronounced_txt);
compiled_user_time = dlmread('pronounced_illusion.txt');
mode_pronounced = mode(compiled_user_time);
%storing user info about which amount of squares made the illusion seem
%more pronounced, and calculating the mode



time_spent = end_time - start_time;
%calculates the total time the user spent on the illusion

time_output = fopen('make_squares_time_output.txt','a');
fprintf(time_output, '%0.3f\n',time_spent);
fclose(time_output);
all_user_time = dlmread('make_squares_time_output.txt');
avg_time = mean(all_user_time);
%calculates average time spent by all users on the illusion

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, sprintf...
        ('You thought option %d led to the most pronounced illusion. \n Most people thought option %d led to the most pronounced illusion.',...
        [more_pronounced_illusion mode_pronounced]),...
        'center', screenYpixels * 0.5, [0 0 0]); 
Screen('Flip', window);
KbStrokeWait;
%displays to the user the collected info about which number of squares
%users most often felt led to more pronounced illusions

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, sprintf...
        ('You spent %0.2f seconds on this illusion. \nThe average user spent %0.2f seconds on this illusion.', [time_spent avg_time]),...
        'center', screenYpixels * 0.5, [0 0 0]); % print out time to 2 decimals
Screen('Flip', window);
KbStrokeWait;
%displays info to user about our collected time data




sca;

