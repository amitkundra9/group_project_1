% append to the beginning of any script
sca; % abbreviation for Screen(‘CloseAll’).
close all;
clear all;
PsychDefaultSetup(2);

screens = Screen('Screens'); % finds # of screens attached
screenNumber = max(screens); % chooseses the one with highest value(external if possible)

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

% sets screen to black
[window, windowRect] =  PsychImaging('OpenWindow', screenNumber, black);

% gets info about screen
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);

% first page
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Welcome to the next illusion \n The Shaded Illusion',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

% second page
DrawFormattedText(window, 'For this illusion, there will be \n two dots on a color gradient',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

% third page
DrawFormattedText(window, 'You will choose a number between 1-7 \n to select the type of color gradient',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

% fourth page
DrawFormattedText(window, 'Here is an example with the input 1',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

% fifth page
% call function shadedillusion
shadedillusion(1);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf,'shadedillusion.png');
close(gcf);

% scale image to fit screen
the_illusion = imread('shadedillusion.png');
[s1, s2, ~] = size(the_illusion);
scale = min(screenXpixels/1.5/s1,screenYpixels/1.5/s2);
firstX = (screenXpixels-s2*scale)/2; firstY = (screenYpixels-s1*scale)/2;
lastX = firstX+s2*scale; lastY = firstY+s1*scale;

% display image
imageTexture = Screen('MakeTexture', window, the_illusion);
Screen('DrawTexture', window, imageTexture, [], [firstX, firstY, lastX, lastY], 0);
Screen('Flip', window);
KbStrokeWait;

%sixth page
Screen('TextSize', window, 35);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, ...
    'try all the options to see which \n illusion is the most pronounced',...
    'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

%sixth page
Screen('TextSize', window, 35);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, ...
    'The two squares should look \n like different colors \n but they''re actually the same',...
    'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

time_start = GetSecs;
while 1
    % seventh page
    % take user keyboard input, echo it to screen.
    Screen('TextSize', window, 35);
    Screen('TextFont', window, 'Courier');
    user_input = Ask(window,'enter an integer 1-7 or enter qqq to quit: ',...
        [1 1 1], [black], 'GetChar','center', 'center');
    input_color = str2double(user_input);
    
    if user_input == "qqq" || ~input_color == 1 || ~input_color == 2 || ~input_color == 3
        break
    end

    % page 8
    Screen('TextSize', window, 40);
    Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, 'here is another custom illusion',...
        'center', screenYpixels * 0.5, [1 1 1]);
    Screen('Flip', window);
    KbStrokeWait;
    
    % page 9
    % call function shadedillusion (again)
    shadedillusion(input_color);
    set(gcf, 'InvertHardCopy', 'off');
    saveas(gcf,'shadedillusion.png');
    close(gcf);
    
    the_image = imread('shadedillusion.png');
    [s1, s2, ~] = size(the_image);
    scale = min(screenXpixels/1.5/s1,screenYpixels/1.5/s2);
    firstX = (screenXpixels-s2*scale)/2; firstY = (screenYpixels-s1*scale)/2;
    lastX = firstX+s2*scale; lastY = firstY+s1*scale;
    
    imageTexture = Screen('MakeTexture', window, the_image);
    Screen('DrawTexture', window, imageTexture, [], [firstX, firstY, lastX, lastY], 0);
    Screen('Flip', window);
    KbStrokeWait;
end

time_end = GetSecs;
% tenth page
% asking which illusion was the most pronounced.
Screen('TextSize', window, 35);
Screen('TextFont', window, 'Courier');
fav_illusion = Ask(window,'Which illusion (by number) was the most pronounced: ',...
        [1 1 1], [black], 'GetChar','center', 'center');
fav_illusion = str2double(fav_illusion);

%storing data about fav illusions to .txt file, calculating mode
fav_ill_txt = fopen('fav_illusions.txt','a');
fprintf(fav_ill_txt, '%0.3f\n', fav_illusion);
fclose(fav_ill_txt);
compiled_user_time = dlmread('fav_illusions.txt');
mode_illusion = mode(compiled_user_time);

%calculating the time spent viewing illusions, saving to .txt, calculating
%the mean for display later
total_time = time_end - time_start;
time_out = fopen('time_out.txt','a');
fprintf(time_out, '%0.3f\n', total_time);
fclose(time_out);
compiled_user_time = dlmread('time_out.txt');
mean_time = mean(compiled_user_time);

% page11 - displaying info regarding collected time data
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, sprintf...
        ('You spent %0.2f seconds on this illusion. \nThe average user spent %0.2f seconds on this illusion.', [total_time mean_time]),...
        'center', screenYpixels * 0.5, [1 1 1]); % prints out time to 2 decimals
Screen('Flip', window);
KbStrokeWait;


% page12 - displaying info regarding collected fav illusion data
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
    DrawFormattedText(window, sprintf...
        ('You thought %d was the most pronounced illusion. \n Most people thought %d was the most pronounced illusion.', [fav_illusion mode_illusion]),...
        'center', screenYpixels * 0.5, [1 1 1]); 
Screen('Flip', window);
KbStrokeWait;
%%psychtoolbox for the 'shadedillusion' - in total, including internet
%%searches this took around 8 hours to put together the 'slideshow' aspect. After that, around 3
%%hours of debugging and consulting with group members to resolve issues
%%and establish continuity with other aspects. The interactive elements,
%%including exporting the user data to a txt file and then calling it back
%%into this script took another 2 hours, with an hour to debug. -amit
sca;

