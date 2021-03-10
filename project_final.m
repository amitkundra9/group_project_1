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

section_index = 1;

while 1
    if section_index == 1
        
        % table of contents
        [screenXpixels, screenYpixels] = Screen('WindowSize', window);
        Screen('TextSize', window, 35);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window,...
            '1. Table of Contents\n2. Make Squares\n3. Scintillating Grid\n4. Offset Squares\n5. Wavy Squares\n6. Shaded Illusion\n8. Exit program',...
            screenXpixels*0.2, screenYpixels * 0.2, [1 1 1]);
        section_index = Ask(window,'Please enter a corresponding section number: ',...
            [1 1 1], [black], 'GetChar','center', 'center');
        section_index = str2double(section_index);
        Screen('Flip', window);
        
        %%%%%%%%%%%%%%%%%%% Make Squares %%%%%%%%%%%%%%%%%%%
    elseif section_index == 2
        
        Screen('TextSize', window, 35);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, 'Hello and Welcome to our Optical Illusions Project. \n \n You can always press any key to continue to the next page.',...
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
        section_index = 1;
        
        %%%%%%%%%%%%%%%%%%% Scintillating Grid %%%%%%%%%%%%%%%%%%%
    elseif section_index == 3
        Screen('TextSize', window, 35);
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
        fprintf(scintillating_txt, '%0.3f\n', more_prounounced_scintillating);
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
            ('You thought option %d led to the most pronounced illusion. \n Most people thought option %d led to the most pronounced illusion.',...
            [more_prounounced_scintillating mode_pronounced]),...
            'center', screenYpixels * 0.5, [0 0 0]);
        Screen('Flip', window);
        KbStrokeWait;
        %displays to the user the collected info about which number of squares
        %users most often felt led to more pronounced illusions
        
        Screen('TextSize', window, 40);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, sprintf...
            ('You spent %0.2f seconds on this illusion. \nThe average user spent %0.2f seconds on this illusion.', [time_spent_scint avg_time_scint]),...
            'center', screenYpixels * 0.5, [0 0 0]); % print out time to 2 decimals
        Screen('Flip', window);
        KbStrokeWait;
        %displays info to user about our collected time data
        section_index = 1;
        
        %%%%%%%%%%%%%%%%%%% Scintillating Grid %%%%%%%%%%%%%%%%%%%
    elseif section_index == 4
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
            DrawFormattedText(window, 'How tall should your illusion be?',...
                'center', screenYpixels * 0.5, [1 1 1]);
            height = Ask(window,'Enter an integer between 1 and 30 (or qqq to quit) and then press enter:', [1 1 1], [black], 'GetChar','center', 'center');
            
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
        section_index = 1;
        
        %%%%%%%%%%%%%%%%%%% Wavy Squares %%%%%%%%%%%%%%%%%%%
    elseif section_index == 5
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
        wavy_squares(18,8);
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
            wavy_squares(num_squares,8);
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
        
        % page7
        Screen('TextSize', window, 40);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, ...
            'Which one of the following illusions is more pronounced?',...
            'center', screenYpixels * 0.5, [1 1 1]);
        Screen('Flip', window);
        KbStrokeWait;
        
        % page8
        % side by side comparison, different circle_r
        subplot(1,2,1);
        wavy_squares(16,4);
        subplot(1,2,2);
        wavy_squares(16,8);
        set(gcf, 'InvertHardCopy', 'off');
        saveas(gcf,'wavy_squares.png');
        close(gcf);
        
        % scale image to fit screen
        the_image = imread('wavy_squares.png');
        [s1, s2, ~] = size(the_image);
        scale = 1.8*min(screenXpixels/1.5/s1,screenYpixels/1.5/s2);
        firstX = (screenXpixels-s2*scale)/2; firstY = (screenYpixels-s1*scale)/2;
        lastX = firstX+s2*scale; lastY = firstY+s1*scale;
        
        % display image
        imageTexture = Screen('MakeTexture', window, the_image);
        Screen('DrawTexture', window, imageTexture, [], [firstX, firstY, lastX, lastY], 0);
        Screen('Flip', window);
        KbStrokeWait;
        
        % page 9
        % record user choice
        Screen('TextSize', window, 40);
        Screen('TextFont', window, 'Courier');
        user_choice = Ask(window,'Enter 1 for left and 2 for right: ',...
            [1 1 1], [black], 'GetChar','center', 'center');
        user_choice = str2double(user_choice);
        
        choice_output = fopen('wavy_squares_choice_output.txt','a');
        fprintf(choice_output, '%d\n', user_choice);
        fclose(choice_output);
        all_user_choice = dlmread('wavy_squares_choice_output.txt');
        
        % report user choice and average user response
        count1 = numel(find(all_user_choice==1));
        count2 = numel(find(all_user_choice==2));
        num_count1 = 100*count1/length(all_user_choice);
        num_count2 = 100*count2/length(all_user_choice);
        Screen('TextSize', window, 35);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, sprintf...
            ('You chose illusion %d. \n%0.1f%% of the users chose illusion 1, and %0.1f%% chose illusion 2.',...
            [user_choice num_count1 num_count2]),...
            'center', screenYpixels * 0.5, [1 1 1]);
        Screen('Flip', window);
        KbStrokeWait;
        
        end_time = GetSecs; % get time again
        time_spent = end_time - start_time; % calculate time user spent
        time_output = fopen('wavy_squares_time_output.txt','a');
        fprintf(time_output, '%0.3f\n', time_spent);
        fclose(time_output);
        all_user_time = dlmread('wavy_squares_time_output.txt');
        avg_time = mean(all_user_time);
        
        % page10
        Screen('TextSize', window, 40);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, sprintf...
            ('You spent %0.2f seconds on this illusion. \nAverage user spent %0.2f seconds on this illusion.',...
            [time_spent avg_time]),...
            'center', screenYpixels * 0.5, [1 1 1]); % print out time to 2 decimals
        Screen('Flip', window);
        KbStrokeWait;
        section_index = 1;
        
        %%%%%%%%%%%%%%%%%%% Shaded illusion %%%%%%%%%%%%%%%%%%%
    elseif section_index == 6
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
        section_index = 1;
    else
        sca;
    end
end

