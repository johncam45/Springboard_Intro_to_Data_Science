# Data Visualization Exercise 1 - Datacamp Titanic Exercise
library(ggplot2)

#-----------------------------------------------
# Load the data in RStudio.
#-----------------------------------------------
path_in <- file.path("Data", "Titanic.csv")
titanic <- read.csv(path_in, stringsAsFactors=FALSE, na.strings = "")

#-----------------------------------------------
# Titanic is avaliable in your workspace.
# 1 - Check the structure of titanic.
#-----------------------------------------------
str(titanic)

#-----------------------------------------------
# 2 - Use ggplot() for the first instruction.
#-----------------------------------------------
ggplot(titanic, aes(x = Pclass, fill = Sex)) +
  geom_bar(position = "dodge")

#-----------------------------------------------
# 3 - Plot 2, add facet_grid() layer to variable "Survived".
#-----------------------------------------------
ggplot(titanic, aes(x = Pclass, fill = Sex)) +
  geom_bar(position = "dodge") +
  facet_grid(. ~Survived)

#-----------------------------------------------
# 4 - Define an object for position jitterdodge, to use below.
#-----------------------------------------------
posn.jd <- position_jitterdodge(jitter.width  = 0.5,
                                jitter.height = 0,
                                dodge.width   = 0.6)

#-----------------------------------------------
# 5 - Plot 3, but use the position object from instruction 4.
#-----------------------------------------------
ggplot(titanic, aes(x = Pclass, y = Age, color = Sex)) +
  geom_point(size = 3, alpha = 0.5, position = posn.jd) +
  facet_grid(. ~Survived)
