
 	An application analyzes historical data set of closed BUGS
 from Bugzilla tracker and then predicts time interval, during which
 given open tickets will be most likely closed by developers.
 The aplication based on neural nets (NN) and it uses "Matlab" tools.
 Input data for aplication are two csv - files from Bugzilla tracker  with same formats.
 The first file contains "closed BUGS" , and it is used for training  the neural nets.
 The second file contains "open tickets" as strings.  
 Input data for application are two csv-files from Bugzilla tracker with same formats.
	The first file ("data_for_training.csv") contains "closed BUGS" , and it is used
 for training the neural nets. The second file("data_for_work.csv") contains
 "open tickets" as strings. You must dounload files from Bugzilla tracker and
 rename them like these.
	Programme makes the prediction for all tickets from file "data_for_work.csv"
   The format of this files must contain Bugzilla columns "Opened" and "Changed"
 others columns can be variable, but a composition of them
 is important for the truelity level of results. I recommend the formats
 of files ("data_for_work.csv" , "data_for_training.csv"),  which are in the application
 for a testing.
 The application also includes tools for an analysis of the getting results.
 All meta information is contained in cell P,which saves in the file "Stat.inf.mat"
 Input data for neural net is numeric matrixes. For bilding numerical input, 
 at first, lists of keywords for every column of file "data_for_training.csv",
 are created, and then they are unioned in the index list ( create_dictionary_d()).
	The input training matrix contains the column for each row from file 
"data _for_ training", and the row for each word from index list.
	For every word from the index list, row in training input matrix is formed.
This row contains  number 1 in that column, where the word from index falls into
the file's row, otherwise 0.
	The main part of the application is the recursive function (main()).
This function creates NN, trainings NN, runs NN to get a forecast for a ticket
at the current iteration and prepares an input data for the next iteration.
    The NN is created by ML function "patternnet()" and trained by ML function 
"train(net,input,target)". This NN classifies input vectors by classes.
 In our case classes are intervals, to which we divide the whole interval
 for forecasting (predict_period). This time interval, during which the main part 
 of open tickets (but not necessary all) may be closed (for example 1024 days).
 We divide this interval on 2 parts, then on 4 and etc. The depth of dividing is set
 by the parameter "deep_of_search".
   In the result, the program for all the tickets ( rows of file  "tickets")
gives out:
1) a forecast as the row of the format:
"from 'date of the beginning of the interval' to 'date of the end of the interval'";

2)the probability of the reliability of this forecast;

3)the depth of the search.
	The program is trying to do the most deep search
(max accuracy of approximating the predicted data), which compliances with
 the required level of reliability.
   For using as "tickets" file it is recommended file "new tickets" from
Bugzilla tracker.
	The programme has 3 mode of work: "new", "stable" and "experimental".
Mode "stable" is using when the same "data _for_ training" is using a lot of times.
In this mode the programme has property of "self education". The best net from 
early runnings is transported to later ones.
   Before  runnig "stable" mode for this "data _for_ training" you need to run the programme
in "new" mode.
   The application has next starting settings:
mode = "new"; % "stable", "new" or "exp"
save_in_file = 'stat_inf'; %   file - stat_inf.mat
predict_period = 512; % the duration of the main predictable interval
min_trulity_level = 0.5;
step_repeat = 15; % the quantity for the repetitions of searching
deep_of_search = 6;
deep_of_check = 6; % not more than deep_of_search
loop_repeats_quant = 5; % the quantity of the repetitions during training the net 
layers_quant = 10;  % parameter for NN
c_g = 2; % the coefficient for dividing of the predict interval, it may be 3,and more
	These the default values for settings may be changed in the file "start.m".
	Result is the table "table_predictation" with columns
 'Date' 'Trulity_level' 'Depth_of_search', and its is loaded in file "predictation.csv"




