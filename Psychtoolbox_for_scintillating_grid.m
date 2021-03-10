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
DrawFormattedText(window, 'Now, let''s check out some more illusions! \n \n Remember, you can always press any key to continue to the next page.',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%adding text for an intro to the next illusion, and reminding the user that they can press
%any key always to move to the next page

DrawFormattedText(window, 'This next illusion is a bit more interesting. \n \n It shows a number of black squares, \n with gray lines in between them, \n and white dots at the intersections.',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%introduces scintillating grid illusion

DrawFormattedText(window, 'Some of these white dots might appear black to you however, \n especially if you focus your vision on one specific dot. \n This is the scintilalting grid illusion. \n Check it out!',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%continues introducing scintillating grid illusion

start_time_scint = GetSecs;
%gets real time of execution of this line

scintillating_grid_final(7);
set(gcf,'InvertHardCopy', 'off');
saveas(gcf, 'first_scintillating_grid.png');
close(gcf);
%calling my function for display on the screen, with 35 squares to start

the_image = imread('first_scintillating_grid.png');
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
DrawFormattedText(window, 'Again, you can make any m x m grid of squares appear in this grid illusion!',...
'center', screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
%we will be allowing the user to input the number of squares they want to
%see in the grid illusion

while 1
    Screen('TextSize', window, 60);
    Screen('TextFont', window, 'Courier');
    input_squares = Ask(window,'Enter integer m from 7-15 to make an m x m grid (try small & large inputs), or enter qqq to quit: ',...
        [0 0 0], [white], 'GetChar','center', 'center');
    givenNumber = str2double(input_squares);
    
    if input_squares == "qqq" || givenNumber<7 || givenNumber>15
        break
    end
    %takes the user input and echoes to screen
    
    Screen('TextSize', window, 40);
    Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, 'Here is your custom made grid illusion:',...
        'center', screenYpixels * 0.5, [0 0 0]);
    Screen('Flip', window);
    KbStrokeWait;
    
    scintillating_grid_final(givenNumber);
    set(gcf, 'InvertHardCopy', 'off');
    saveas(gcf,'second_scintillating_grid.png');
    close(gcf);
    %calling my function for display on the screen,
    %with the user input value givenNumber to start
    
    the_image = imread('second_scintillating_grid.png');
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

end_time_scint = GetSecs;
%gets real time at end of illusion

Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
more_prounounced_scintillating = Ask(window,'Was the illusion more pronounced with less or more squares? Answer (1) for less, or (2) for more : ',...
        [0 0 0], [white], 'GetChar','center', 'center');
more_prounounced_scintillating = str2double(more_prounounced_scintillating);
%asking the user if they felt the illusion was more pronounced with more or
%less squares

scintillating_txt = fopen('pronounced_scintillating.txt','a');
fprintf(scintillating_txt, '%0.3f\n', fav_illusion);
fclose(scintillating_txt);
compiled_user_time_scint = dlmread('pronounced_scintillating.txt');
mode_pronounced = mode(compiled_user_time_scint);
%storing user info about which amount of squares made the illusion seem
%more pronounced, and calculating the mode



time_spent_scint = end_time_scint - start_time_scint;
%calculates the total time the user spent on the illusion

time_output_scint = fopen('make_squares_time_output.txt','a');
fprintf(time_output_scint, '%0.3f\n',time_spent_scint);
fclose(time_output_scint);
all_user_time_scint = dlmread('make_squares_time_output.txt');
avg_time_scint = mean(all_user_time_scint);
%calculates average time spent by all users on the illusion

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, sprintf...
        ('You thought option %d led to the most pronounced illusion. \n Most people thought option %d led to the most pronounced illusion.', [more_pronounced_illusion mode_pronounced]),...
        'center', screenYpixels * 0.5, [1 1 1]); 
Screen('Flip', window);
KbStrokeWait;
%displays to the user the collected info about which number of squares
%users most often felt led to more pronounced illusions

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, sprintf...
        ('You spent %0.2f seconds on this illusion. \nThe average user spent %0.2f seconds on this illusion.', [time_spent_scint avg_time_scint]),...
        'center', screenYpixels * 0.5, [1 1 1]); % print out time to 2 decimals
Screen('Flip', window);
KbStrokeWait;
%displays info to user about our collected time data
    
    


sca;
