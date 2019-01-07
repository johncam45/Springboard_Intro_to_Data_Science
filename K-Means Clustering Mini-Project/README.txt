Files:
1. README: This file.
2. k-means_clustering.R:  Project submission.

###########################################################################
# Exercise 1: Remove the first column from the data and scale
# it using the scale() function
###########################################################################
wineType <- wine$Type               # save wine type to variable
wine$Type <- NULL                   # remove 'Type' from df
df <- scale(wine)                   # normalize variables and save to new df

###########################################################################
# Exercise 2:
#   * How many clusters does this method suggest?
#   * Why does this method work? What's the intuition behind it?
#   * Look at the code for wssplot() and figure out how it works
###########################################################################
# The last significant kink occurs at 3 so suggests to use 3 clusters.
#
# The total variance (SST) = within group variance (SSW) + between group variance (SSB).
# Since SST is fixed for a given data set, SSW and SSB are affected by how the data is
# grouped or clustered. This method works then by increasing the subdivision of data into  
# more and more clusters thereby reducing the variance within a given group, SSW, and increasing  
# the between group variance, SSB. Eventually further subdivision leads to marginal changes in 
# the within group variance. The last largest change in SSG signifies an adequate number of clusters.

###########################################################################
# Exercise 3: How many clusters does this method suggest?
###########################################################################
# The NbCLust method suggests using 3 clusters.

###########################################################################
# Exercise 4: Once you've picked the number of clusters, run k-means 
# using this number of clusters. Output the result of calling kmeans()
# into a variable fit.km
###########################################################################
fit.km <- kmeans(df, centers=3)

###########################################################################
# Exercise 5: using the table() function, show how the clusters in fit.km$clusters
# compares to the actual wine types in wine$Type. Would you consider this a good
# clustering?
###########################################################################
table(fit.km$cluster, wineType)

# In order to be a 'good' clustering, the clusters should accurately group the wine types.
# This clustering choice is therefore very good with an accuracy of:
#     accuracy = (59+65+48)/(59+3+0+0+65+0+0+3+48) = 96.6%

###########################################################################
# Exercise 6:
# * Visualize these clusters using  function clusplot() from the cluster library
# * Would you consider this a good clustering?
###########################################################################
par(mar = c(6, 6, 4, 4), mfrow = c(1, 1))    # reset for single plot
cluster::clusplot(df, fit.km$cluster, main = 'Cusplot')

# The plot shows that nearly all the data is accounted for by 3 clusters 
# so this is a good choice.
