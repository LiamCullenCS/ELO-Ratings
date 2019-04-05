library(nflscrapR)
library(tidyverse)
library(ggplot2)

TeamDistributions <- read.csv(file = "TeamDistributions.csv", header = TRUE, sep = ",")
rankings <- read.csv(file = "ELO Rankings.csv", header = TRUE, sep = ",")

View(TeamDistributions)

TeamDist <- as_tibble(TeamDistributions)
Sacks <- TeamDist %>% pull(SackPCT)
Pass <- TeamDist %>% pull(PassPCT)
Run <- TeamDist %>% pull(RunPCT)

ratings <- rankings %>% pull(rating)

cor(Sacks, ratings)
cor(Pass, ratings)
cor(Run, ratings)