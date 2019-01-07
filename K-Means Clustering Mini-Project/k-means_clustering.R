# This mini-project is based on the K-Means exercise from 'R in Action'
# Go here for the original blog post and solutions
# http://www.r-bloggers.com/k-means-clustering-from-r-in-action/

# Exercise 0: Install these packages if you don't have them already

# install.packages(c("cluster", "rattle.data","NbClust"))

# Now load the data and look at the first few rows
data(wine, package="rattle.data")
head(wine)

###########################################################################
# Exercise 1: Remove the first column from the data and scale
# it using the scale() function
###########################################################################
##########################
### Start John's Input ###
##########################

wineType <- wine$Type               # save wine type to variable
wine$Type <- NULL                   # remove 'Type' from df
df <- scale(wine)                   # normalize variables and save to new df

##########################
### End John's Input   ###
##########################

# Now we'd like to cluster the data using K-Means. 
# How do we decide how many clusters to use if you don't know that already?
# We'll try two methods.

# Method 1: A plot of the total within-groups sums of squares against the 
# number of clusters in a K-means solution can be helpful. A bend in the 
# graph can suggest the appropriate number of clusters. 

wssplot <- function(data, nc=15, seed=1234){
	             wss <- (nrow(data)-1)*sum(apply(data,2,var))
	             print(paste("apply(data,2,var) = ", apply(data,2,var)))
	             print(paste("sum(apply(data,2,var)) = ", sum(apply(data,2,var))))
	             print(paste("wss = ", wss))
               for (i in 2:nc){
		               set.seed(seed)
	                 wss[i] <- sum(kmeans(data, centers=i)$withinss)
	             }
		           plot(1:nc, wss, type="b", xlab="Number of Clusters",
	                  ylab="Within groups sum of squares")
	         }

wssplot(df)

###########################################################################
# Exercise 2:
#   * How many clusters does this method suggest?
#   * Why does this method work? What's the intuition behind it?
#   * Look at the code for wssplot() and figure out how it works
###########################################################################
##########################
### Start John's Input ###
##########################

# The last significant kink occurs at 3 so suggests to use 3 clusters.
#
# The total variance (SST) = within group variance (SSW) + between group variance (SSB).
# Since SST is fixed for a given data set, SSW and SSB are affected by how the data is
# grouped or clustered. This method works then by increasing the subdivision of data into  
# more and more clusters thereby reducing the variance within a given group, SSW, and increasing  
# the between group variance, SSB. Eventually further subdivision leads to marginal changes in 
# the within group variance. The last largest change in SSG signifies an adequate number of clusters.

##########################
### End John's Input   ###
##########################


# Method 2: Use the NbClust library, which runs many experiments
# and gives a distribution of potential number of clusters.

library(NbClust)
set.seed(1234)
par(mar = c(4, 4, 2, 2), mfrow = c(1, 2))    # reset for 2x1 plot
nc <- NbClust(df, min.nc=2, max.nc=15, method="kmeans")
par(mar = c(4, 4, 2, 2), mfrow = c(1, 1))    # reset for single plot
barplot(table(nc$Best.n[1,]),
	      xlab="Numer of Clusters", 
        ylab="Number of Criteria",
		    main="Number of Clusters Chosen by 26 Criteria")


###########################################################################
# Exercise 3: How many clusters does this method suggest?
###########################################################################
##########################
### Start John's Input ###
##########################

# The NbCLust method suggests using 3 clusters.

##########################
### End John's Input   ###
##########################


###########################################################################
# Exercise 4: Once you've picked the number of clusters, run k-means 
# using this number of clusters. Output the result of calling kmeans()
# into a variable fit.km
###########################################################################
##########################
### Start John's Input ###
##########################

fit.km <- kmeans(df, centers=3)

##########################
### End John's Input   ###
##########################

# Now we want to evaluate how well this clustering does.


###########################################################################
# Exercise 5: using the table() function, show how the clusters in fit.km$clusters
# compares to the actual wine types in wine$Type. Would you consider this a good
# clustering?
###########################################################################
##########################
### Start John's Input ###
##########################

table(fit.km$cluster, wineType)

# In order to be a 'good' clustering, the clusters should accurately group the wine types.
# This clustering choice is therefore very good with an accuracy of:
#     accuracy = (59+65+48)/(59+3+0+0+65+0+0+3+48) = 96.6%

##########################
### End John's Input   ###
##########################


###########################################################################
# Exercise 6:
# * Visualize these clusters using  function clusplot() from the cluster library
# * Would you consider this a good clustering?
###########################################################################
##########################
### Start John's Input ###
##########################

par(mar = c(6, 6, 4, 4), mfrow = c(1, 1))    # reset for single plot
cluster::clusplot(df, fit.km$cluster, main = 'Cusplot')

# The plot shows that nearly all the data is accounted for by 3 clusters 
# so this is a good choice.

##########################
### End John's Input   ###
##########################

