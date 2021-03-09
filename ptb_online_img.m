% append to the beginning of any script
sca; % abbreviation for Screen(‘CloseAll’).
close all;
clear all;
PsychDefaultSetup(2);

screens = Screen('Screens'); % #of screens attached
screenNumber = max(screens); % choose one

% Define white, black, and grey using the luminance values for the display.
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% get screen info
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);

% page1
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Here are some images we found online',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

% page2
DrawFormattedText(window, 'Illusion #1',...
'center', screenYpixels * 0.15, [1 1 1]);
url = 'https://i.pinimg.com/originals/a1/98/90/a19890837b928e022da7192e093316c0.jpg';
the_image = webread(url);

% scale image to fit screen
[s1, s2, ~] = size(the_image);
scale = 0.7*min(screenXpixels/1.5/s1,screenYpixels/1.5/s2);
firstX = (screenXpixels-s2*scale)/2; firstY = (screenYpixels-s1*scale)/2;
lastX = firstX+s2*scale; lastY = firstY+s1*scale;

% display image
imageTexture = Screen('MakeTexture', window, the_image);
Screen('DrawTexture', window, imageTexture, [], [firstX, firstY, lastX, lastY], 0);
Screen('Flip', window);
KbStrokeWait; 

% page3
[the_gif,color_map]=imread('rotating_squares','gif','frame','all');
for k=1:size(the_gif,4)
    DrawFormattedText(window, 'Illusion #2',...
    'center', screenYpixels * 0.15, [1 1 1]);
    the_image =imread('rotating_squares','gif', k);
    imageTexture = Screen('MakeTexture', window, the_image);
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    Screen('Flip', window);
    pause(0.04);
end
KbStrokeWait;
sca;