Coursera Project 3
===================================================================================

Review the data with the folowing code:

	filePath <- "https://github.com/spinkava/Project3/tidyMeans.csv"
	tidyMeans <- read.csv(filePath, header = TRUE)
	view(tidyMeans)

In extracting the data, I only included variables that contained "mean" or "std". This did mean that several of the angle variables were not included (as the "Mean" is capitalized in those variables). However, these variables were ultimately angles and not means, so I felt that it was alright to exclude them. 

The data is tidy because it follows the three rules: 

1. Each variable forms a column.

2. Each observation forms a row.

3. Each type of observational unit forms a table.

The variables were "Subject", "Activity", and the 79 measurements containing "mean" and "std" that I extracted from the original 561. This resulted in 81 columns. Combining the 7352 observations from "train" and the 2947 observations from "test", we had 10299 observations. However, after grouping by subject and activity, and taking the mean of each measurement, we had 180 seperate observations in the end. There was no need for a seperate table as the provided table is entirely means of measurements.
