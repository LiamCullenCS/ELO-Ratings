library(nflscrapR)
library(tidyverse)

EPA <- 0
team <- nflteams$abbr[nflteams$abbr != 'SD' 
			& nflteams$abbr != 'STL' 
			& nflteams$abbr != 'JAC']

EPAperPlay <- data.frame(team, EPA)

pbpDat <- read.csv(file = "2018 Play by Play.csv", header = TRUE, sep = ",")

for (i in 1:32){
		
	
}