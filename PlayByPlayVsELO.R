library(nflscrapR)

new_dat <- season_play_by_play(2018)

#Trim dataframe to show only Passes(plus sacks) and Runs

seaDF <- as.data.frame(format(table(seaDat)))

plot(factor(seaDat), main = "Hawks Play Distribution 2018")

allDat <- new_dat$PlayType[new_dat$PlayType != 'Spike'
	& new_dat$PlayType != 'Extra Point'
	& new_dat$PlayType != 'No Play'
	& new_dat$PlayType != 'Kickoff'
	& new_dat$PlayType != 'Field Goal'
	& new_dat$PlayType != 'Punt'
	& new_dat$PlayType != 'End of Game'
	& new_dat$PlayType != 'QB Kneel'
	& new_dat$PlayType != 'Two Minute Warning'
	& new_dat$PlayType != 'Quarter End'
	& new_dat$PlayType != 'Timeout'
	& new_dat$PlayType != 'Half End'
	]

library(wesanderson)

B <- table(allDat)
Bpercentlabels <- round(100*B/sum(B), 2)

bpielabel <- paste(Bpercentlabels, "%", sep = "")
pie(table(allDat), labels = c(bpielabel, table(allDat)), main = "League Average Play Distribution", col = wes_palette("Zissou1"))
legend("topright", names(table(allDat)), cex = 0.8, fill = wes_palette("Zissou1"))



playDist <- new_dat$PlayType[new_dat$posteam == 'CHI' 
	& new_dat$PlayType != 'Spike'
	& new_dat$PlayType != 'Extra Point'
	& new_dat$PlayType != 'No Play'
	& new_dat$PlayType != 'Kickoff'
	& new_dat$PlayType != 'Field Goal'
	& new_dat$PlayType != 'Punt'
	& new_dat$PlayType != 'End of Game'
	& new_dat$PlayType != 'QB Kneel'
	& new_dat$PlayType != 'Timeout']

team_cols <- c(nflteams$primary[nflteams$abbr == 'CHI'], 
	nflteams$secondary[nflteams$abbr == 'CHI'], 
	nflteams$tertiary[nflteams$abbr == 'CHI'])

A <- table(playDist)
Apercentlabels <- round(100*A/sum(A), 2)
apielabel <- paste(Apercentlabels, "%", sep = "")

pie(table(playDist), labels = c(apielabel, table(playDist)), main = "Bears Play Distribution", col = team_cols)
legend("topright", names(table(playDist)), cex = 0.8, fill = team_cols)
