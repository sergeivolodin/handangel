Here the codes and datasets can be accessed.

In the main code, the first part contains loading the datasets (data_1.csv, data_2.csv, data_3.csv) and the reference labels (ref_1.csv, ref_2.csv, ref_3.csv). There are three datasets, the first two measurements (data_1.csv, data_2.csv) are for washing hands and the last one for face touching (data_3.csv). The reference values include the lables that were logged down as the ground truth labels. Also for each dataset, its corresponding start_time from the code should be run. It's for synchronizing the labels and the measurements.

In the next part, the time domain and frequency domain features were extracted from the accelerometer signal after some filtering and preprocessing.

Finally, a classifier was trained and based on 5-fold cross validation was tested on the dataset.

The LauzHack_main.m is the main file that can be generated. The trainCLassifier.m is a decision tree classifier and trainClassifierSVM.m is the support vector machine classifier with quadratic kernel function.