sca;
close all;
clear all;
PsychDefaultSetup(2);


screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

[screenXpixels, screenYpixels] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);

%first page
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Time for another illusion... \n Press any key to go to subsequent pages',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

%second page
DrawFormattedText(window, 'This is the offset squares illusion. \n It uses an offset checkerboard \n to make the squares look slanted',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

%second page
DrawFormattedText(window, 'Assess the effectiveness of the illusion \n with different colors and numbers of squares',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

%third page
DrawFormattedText(window, 'This is an example of the illusion in white with height 5',...
'center', screenYpixels * 0.5, [1 1 1]);
Screen('Flip', window);
KbStrokeWait;

%fourth page
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
    %fifth page
    Screen('TextSize', window, 40);
    Screen('TextFont', window, 'Courier');
    height = Ask(window,'How tall should your illusion be? (Integer between 1 and 30, qqq to quit)',...
        [1 1 1], [black], 'GetChar','center', 'center');
    doubleheight = str2double(height);
    
    if height == "qqq" || doubleheight <= 0 || doubleheight > 50
        break
    end

    %sixth page
    Screen('TextSize', window, 40);
    Screen('TextFont', window, 'Courier');
    color = Ask(window,'What color should your illusion to be? (1 = white, 2 = cyan, 3 = pink)',...
    [1 1 1], [black], 'GetChar','center', 'center');
    doublecolor = str2double(color);
    
    if doublecolor < 1 || doublecolor > 3
        break
    end

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
sca;