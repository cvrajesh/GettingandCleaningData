     Explaining the run_analysis.R file



Save the "run_analysis.R " file from git hub to  your working directory to run the file. 

IMPORTANT NOTE: All the read.csv commands assume that you have extracted the samsung files into your working directory.

Hence the directory is "./UCI HAR Dataset/". If you have stored the .txt files differently please modify accordingly.

If you are using Rstudio select all contents of the  file.

Then Click the run command and the  file tidydata.txt will be saved in your working directory.

You can read in the tidydata file as a datframe using the following command

tidy <- read.csv("tidydata.txt",header=TRUE,sep= " ")

Please read the comments provided in the "run_analysis.R " file for understanding the script.

Codebook.md file gives an explanation of the variables in the tidydata file.