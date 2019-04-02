library(nflscrapR)

new_dat <- season_play_by_play(2018)

#Trim dataframe to show only Passes(plus sacks) and Runs
 
seaDat <- new_dat$PlayType[new_dat$posteam == 'SEA' 
	& new_dat$PlayType != 'Spike'
	& new_dat$PlayType != 'Extra Point'
	& new_dat$PlayType != 'No Play'
	& new_dat$PlayType != 'Kickoff'
	& new_dat$PlayType != 'Field Goal'
	& new_dat$PlayType != 'Punt'
	& new_dat$PlayType != 'End of Game'
	& new_dat$PlayType != 'QB Kneel']

seaDF <- as.data.frame(format(table(seaDat)))

plot(factor(seaDat), main = "Hawks Play Distribution 2018")

allDat <- new_dat$PlayType[new_dat$PlayType == 'Pass'
	& new_dat$PlayType == 'Run'
	& new_dat$PlayType != 'Sack']


par(mfrow = c(2,1))
pie(table(seaDat), main = "Seahawks Play Distribution")

pie(table(allDat), main = "League Average Play Distribution")