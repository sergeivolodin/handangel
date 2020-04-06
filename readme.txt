Here the codes and datasets can be accessed.

In the main code, the first part contains loading the datasets and the reference labels. There are three datasets, the first two measurements are for washing hands and the last one for face touching. The reference values include the lables that were logged down as the ground truth labels. Also for each dataset, its corresponding start_time should be run. It's for synchronizing the labels and the measurements.

In the next part, the time domain and frequency domain features were extracted from the accelerometer signal after some filtering and preprocessing.

Finally, a classifier was trained and based on 5-fold cross validation was tested on the dataset.

The LauzHack_main.m is the main file that can be generated. The trainCLassifier.m is a decision tree classifier and trainClassifierSVM.m is the support vector machine classifier with quadratic kernel function.