library(nflscrapR)
library(tidyverse)
library(ggplot2)



TeamDistributions <- read.csv(file = "TeamDistributions.csv", header = TRUE, sep = ",")

View(TeamDistributions)

TeamDist <- as_tibble(TeamDistributions)
y <- TeamDist %>% pull(SackPCT)
x <- TeamDist %>% pull(team)

plot(y, main = "All 32 Teams Sack Percentage", ylab = "Sack%", col = 'blue', pch = 19, xaxt='n')
abline(h=mean(y), col = "green")
axis(side=1, at=x, labels=x, cex.axis=0.5)
for(i in 1:32){lines(c(i,i), c(mean(y), y[i]), col="red")}

#Can use this or built in function 'var'
variance <- function(x) sum((x - mean(x)) ^2) / (length(x) -1)

