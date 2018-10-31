Data Visualization Exercise 1 - Datacamp Titanic Exercise

Project: Submit your code for the Titanic exercise
1 - 3 Hours

Submission

Copy and paste the R code from the Titanic exercise in the ggplot2 tutorial into a file Titanic.R
Check in Titanic.R into your github repository
Submit the link to the appropriate file or folder in your github repository

--------------------------------------------------------------------------
Datacamp Exercise Instructions
--------------------------------------------------------------------------
Titanic
You've watched the movie Titanic by James Cameron (1997) again and after a good portion of sobbing you decide to investigate whether you'd have a chance of surviving this disaster.

To start your investigation, you decide to do some exploratory visualization with ggplot(). You have information on who survived the sinking given their age, sex and passenger class.

INSTRUCTIONS
100 XP
1 - Have a look at the str() of the titanic dataset, which has been loaded into your workspace. Looks like the data is pretty tidy!
2 - Plot the distribution of sexes within the classes of the ship.
Use ggplot() with the data layer set to titanic.
Map Pclass onto the x axis, Sex onto fill and draw a dodged bar plot using geom_bar(), i.e. set the geom position to "dodge".
3 - These bar plots won't help you estimate your chances of survival. Copy the previous bar plot, but this time add a facet_grid() layer: . ~ Survived.
4 - We've defined a position object for you.
5 - Include Age, the final variable.
Take plot 3 and add a mapping of Age onto the y aesthetic.
Change geom_bar() to geom_point() and set its attributes size = 3, alpha = 0.5 and position = posn.jd.
Make sure that Sex is mapped onto color instead of fill to correctly color the scatter plots. (This was discussed in detail here and here).