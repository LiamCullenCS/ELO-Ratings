library(nflscrapR)
library(wesanderson)

new_dat <- season_play_by_play(2018)

#Trim dataframe to show only Passes(plus sacks) and Runs
#Get League Wide Averages:
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
	& new_dat$PlayType != 'Half End']

leagueAvgs <- table(allDat)
leaguePercents <- round(100*leagueAvgs/sum(leagueAvgs), 2)
leagueBreakdown <- paste(leaguePercents, "%", sep = "")
pie(table(allDat), labels = c(leagueBreakdown, table(allDat)), main = "League Average Play Distribution", col = wes_palette("Zissou1"))
legend("topright", names(table(allDat)), cex = 0.8, fill = wes_palette("Zissou1"))


#Get Team Specific Play Distribution:
playDist <- new_dat$PlayType[new_dat$posteam == 'ATL'
	& new_dat$PlayType != 'Spike'
	& new_dat$PlayType != 'Extra Point'
	& new_dat$PlayType != 'No Play'
	& new_dat$PlayType != 'Kickoff'
	& new_dat$PlayType != 'Field Goal'
	& new_dat$PlayType != 'Punt'
	& new_dat$PlayType != 'End of Game'
	& new_dat$PlayType != 'QB Kneel'
	& new_dat$PlayType != 'Timeout']

team_cols <- c(nflteams$primary[nflteams$abbr == 'ATL'], 
		nflteams$secondary[nflteams$abbr == 'ATL'], 
		nflteams$tertiary[nflteams$abbr == 'ATL'])

A <- table(playDist)
Apercentlabels <- round(100*A/sum(A), 2)
apielabel <- paste(Apercentlabels, "%", sep = "")
pie(table(playDist), labels = c(apielabel, table(playDist)), main = "Falcons Play Distribution", col = team_cols)
legend("topright", names(table(playDist)), cex = 0.8, fill = team_cols) 


#########################################################################
# Build Table of Results
#########################################################################


Pass <- 0
Run <- 0
Sack <- 0
PassDiff <- 0
RunDiff <- 0
SackDiff <- 0 
team <- nflteams$abbr[nflteams$abbr != 'SD' 
			& nflteams$abbr != 'STL' 
			& nflteams$abbr != 'JAC']

TeamDistributions <- data.frame(team, Pass, Run, Sack, PassDiff, RunDiff, SackDiff)

for (i in 1:32){
	playDist <- new_dat$PlayType[new_dat$posteam == team[i]
	& new_dat$PlayType != 'Spike'
	& new_dat$PlayType != 'Extra Point'
	& new_dat$PlayType != 'No Play'
	& new_dat$PlayType != 'Kickoff'
	& new_dat$PlayType != 'Field Goal'
	& new_dat$PlayType != 'Punt'
	& new_dat$PlayType != 'End of Game'
	& new_dat$PlayType != 'QB Kneel'
	& new_dat$PlayType != 'Timeout']

	A <- table(playDist)
	percents <- round(100*A/sum(A), 2)
	playBreakdown <- paste(percents, "%", sep = "")
	
	TeamDistributions$Pass[TeamDistributions$team == team[i]] <- playBreakdown[1]
	TeamDistributions$Run[TeamDistributions$team == team[i]] <- playBreakdown[2]
	TeamDistributions$Sack[TeamDistributions$team == team[i]] <- playBreakdown[3]
	TeamDistributions$PassDiff[TeamDistributions$team == team[i]] <- (as.numeric(sub("%", "", playBreakdown[1])) - as.numeric(sub("%", "", leagueBreakdown[1])))
	TeamDistributions$RunDiff[TeamDistributions$team == team[i]] <- (as.numeric(sub("%", "", playBreakdown[2])) - as.numeric(sub("%", "", leagueBreakdown[2])))
	TeamDistributions$SackDiff[TeamDistributions$team == team[i]] <- (as.numeric(sub("%", "", playBreakdown[3])) - as.numeric(sub("%", "", leagueBreakdown[3])))
}

View(TeamDistributions)
	