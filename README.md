# README

## 1. Files

The following files are included in this repo:
* *CodeBook.md*;
* *mean-data-tidy.csv*, the derived data set, the contents of which are described in *CodeBook.md*; and
* *run_analysis.R*, an R script which generates the tidy data set *mean-data-tidy.csv*.

## 2. Description of run_analysis.R

<h3>Dependencies</h3>

The script *run_analysis.R* uses the following library(ies):
* plyr

<h3>Overview of script operations</h3>

The script *run_analysis.R* carries out the following steps:
* Load the test, train, and features data into R, as well as the activity labels, from the source data set.
* Extract and merge all data into a single data frame:
  * Concatenate the subject ID numbers ("subjectId" variable), activity labels ("activity" variable), and measurement data (remaining variables) from the test and train data, so that there is a single vector/data frame for each of these three variables or groups of variables. This is carried out via the *rbind()* function.
  * Extract a subset of the measurement variables containing the "-mean(" or "-std(" regular expressions in their names.
  * Create a new data frame consisting of the subject ID numbers, activity names, and measurement data. This is carried out via the *cbind()* function.
* Generate the tidy data set containing the means of the observed measurement variable values (per subject and per activity):
  * The data set is generated using the *aggregate()* function, where *mean* is the function to be applied, and the means are taken *by* the subjectId and activity variables.
  * Save the data set to the current directory via the *write.csv()* function.
