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
par(mfrow = c(2,1))

sea_cols <- c(nflteams$primary[nflteams$abbr == 'SEA'], 
	nflteams$secondary[nflteams$abbr == 'SEA'], 
	nflteams$tertiary[nflteams$abbr == 'SEA'])

A <- table(seaDat)
B <- table(allDat)

Apercentlabels <- round(100*A/sum(A), 2)
Bpercentlabels <- round(100*B/sum(B), 2)

apielabel <- paste(Apercentlabels, "%", sep = "")
bpielabel <- paste(Bpercentlabels, "%", sep = "")

pie(table(seaDat), labels = c(apielabel, table(seaDat)), main = "Seahawks Play Distribution", col = sea_cols)
legend("topright", names(table(seaDat)), cex = 0.8, fill = sea_cols)
pie(table(allDat), labels = c(bpielabel, table(allDat)), main = "League Average Play Distribution", col = wes_palette("Zissou1"))
legend("topright", names(table(allDat)), cex = 0.8, fill = wes_palette("Zissou1"))


