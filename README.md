# group_project_1

Our project focused on the use of PsychToolbox to run a basic experiment with several tasks. 
The user will interact with the experiment, which has instructions that will display on the screen.
Each group member created optical illusions using MatLab matrix manipulation, and also created a "ptb" file to accompany the created illusion. 
  The "ptb" files were the most work intesive part of our project, as they required the completion of the PsychToolbox tutorial to begin work on, and were also the most code heavy aspect of the project.
  Besides displaying text, calling our illusion functions, and walking the user through the experiment, the "ptb" files also contain code that stores data from each user, based on prompt, and has basic data analytic capabilities. 
  These functions will also tell the user their responses, and compare them to the "average" user of this experiment. 
  The data gets stored in .txt files, which is why there are so many of them in the repository. 
  Additionally, each individual "ptb" file was created separately, and then combined at the end of the project with a "table of contents" aspect, because it was easier to work on each specific portion. 
  
  
  The "project_final.m" is the combined file, with the whole experiment and table of contents loaded onto it.
    When you run the program, you will see the table of contents asking you to input which (specified) page you'd like to navigate to by selecting a number from your keyboard. 
    In order of appearance, the other "ptb" files that were combined into this are:
      "Psychtoolbox_for_make_squares_final.m"
      "Psychtoolbox_for_scintillating_grid.m"
      "offset_squares_ptb.m"
      "ptb_wavy_squares.m"
      "shadedillusion_ptb.m"
      
        Each file corresponds to a different section in the experiment, and a different number in the table of contents. 
        Each of the sections prompts the user with text, describing how to navigate the section, and then showing an example of the illusion. 
        The user is then prompted to "customize" the illusion via a series of paramaters specified in each individual section, and encouraged to try a variety of different inputs
        After this, some of the sections prompt the user to evaluate something they saw regarding the illusions, whether it be which version of the illusion worked best, or whether the illusion worked better with larger/smaller inputs
        The user is then shown the time they spent on this section, as well as the average time a user typically spends on that section.
        If the user was prompted to input some other data, that will be returned to them, along with the average users data point, allowing the user to see how they compare. 
      
        All of these files will run independently, and should act as stand alone psuedo-experiments if run by itself. 
      
  We have commented in GitHub commit history, the time and people that went into and worked on each aspect. 
  
  In order to run this project, load "project_final.m", and run the script using the "Run" button in MatLab.
  
  We were unable to record and input a video into the readme, because PsychToolbox did not allow us to record our screen while the experiment ran. 
