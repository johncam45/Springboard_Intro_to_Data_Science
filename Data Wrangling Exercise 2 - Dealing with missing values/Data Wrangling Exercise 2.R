# Data Wrangling Exercise 2 - Dealing with missing values
#library(tidyr)
#library(dplyr)

#-----------------------------------------------
# 0: Load the data in RStudio.
#-----------------------------------------------
path_in <- file.path("Data", "titanic_original.csv")
dataset <- read.csv(path_in, stringsAsFactors=FALSE, na.strings = "")

#Explore dataset.
#class(dataset)       # verify data.frame
#dim(dataset)         # check size
#names(dataset)       # column names
#str(dataset)         # structure
#glimpse(dataset)     # structure
#summary(dataset)     # summary of data
#head(dataset, n=10)  # top of data
#tail(dataset, n=10)  # bottom of data
#View(dataset)        # examine in data viewer

#--------------------------------------------------------------------------------
# 1: Port of embarkation. (done)
#    The embarked column has some missing values, which are known to correspond 
#    to passengers who actually embarked at Southampton. Find the missing values 
#    and replace them with S. (Caution: Sometimes a missing value might be read 
#    into R as a blank or empty string.)
#--------------------------------------------------------------------------------
dataset$embarked[which(is.na(dataset$embarked))] <- "S"


#--------------------------------------------------------------------------------
# 2: Age. (done)
#    You’ll notice that a lot of the values in the Age column are missing. While 
#    there are many ways to fill these missing values, using the mean or median 
#    of the rest of the values is quite common in such cases.
#      1. Calculate the mean of the Age column and use that value to populate the 
#         missing values
#      2. Think about other ways you could have populated the missing values in 
#         the age column. Why would you pick any of those over the mean (or not)?
#         A: I'd use the median value since it's less sensitive to outliers.
#--------------------------------------------------------------------------------
dataset$age[which(is.na(dataset$age))] <- mean(dataset$age, na.rm=TRUE)


#--------------------------------------------------------------------------------
# 3: Lifeboat (done)
#    You’re interested in looking at the distribution of passengers in different 
#    lifeboats, but as we know, many passengers did not make it to a boat :-( 
#    This means that there are a lot of missing values in the boat column. Fill 
#    these empty slots with a dummy value e.g. the string 'None' or 'NA'.
#--------------------------------------------------------------------------------
dataset$boat[which(is.na(dataset$boat))] <- "None"


#--------------------------------------------------------------------------------
# 4: Cabin
#    You notice that many passengers don’t have a cabin number associated with them.
#       - Does it make sense to fill missing cabin numbers with a value?
#       A: no
#       - What does a missing value here mean?
#       A: steerage passengers
#       
#    You have a hunch that the fact that the cabin number is missing might be a 
#    useful indicator of survival. Create a new column has_cabin_number which 
#    has 1 if there is a cabin number, and 0 otherwise.
#--------------------------------------------------------------------------------
dataset$has_cabin_number <- rep(1, nrow(dataset))           # new column initialize to 1.
dataset$has_cabin_number[which(is.na(dataset$cabin))] <- 0  # reset obs to 0 for missing cabin numbers.


#-----------------------------------------------
# 5: Submit the project on Github.
#-----------------------------------------------
path_out <- file.path("Data", "titanic_clean.csv")
write.csv(dataset, path_out, na = "NA")
