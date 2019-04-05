library(nflscrapR)

#ELO script

rating <- 1000
wins <- 0
losses <- 0
ties <- 0
team <- nflteams$abbr[nflteams$abbr != 'SD' 
			& nflteams$abbr != 'STL' 
			& nflteams$abbr != 'JAC']

rankings <- data.frame(team, rating, wins, losses, ties)

dat <- data.frame(season_games(2018, sleep.seconds = 0))
	
#increment function
inc <- function(x) {eval.parent(substitute(x <- x + 1))}

points_diff <- dat$homescore - dat$awayscore

	for (i in 1:256){
     
		if (points_diff[i] > 0){

			inc(rankings$wins[rankings$team == dat$home[i]])
			inc(rankings$losses[rankings$team == dat$away[i]])
			
			lossRating <- rankings$rating[rankings$team == dat$away[i]]
			WWins <- rankings$wins[rankings$team == dat$home[i]]
			WLosses <- rankings$losses[rankings$team == dat$home[i]]
			overallWinRat <- rankings$rating[rankings$team == dat$home[i]] 
			win_newRat <- ((lossRating + overallWinRat) + (400 * (WWins - WLosses)))/ (WWins + WLosses)

			winRating <- rankings$rating[rankings$team == dat$home[i]]
			LWins <- rankings$wins[rankings$team == dat$away[i]]
			LLosses <- rankings$losses[rankings$team == dat$away[i]]
			overallLossRat <- rankings$rating[rankings$team == dat$away[i]] 
			loss_newRat <- ((winRating + overallLossRat) + (400 * (LWins - LLosses))) / (LWins + LLosses)
		
			rankings$rating[rankings$team == dat$home[i]] <- win_newRat
			rankings$rating[rankings$team == dat$away[i]] <- loss_newRat
		}

		else if(points_diff[i] < 0){

			inc(rankings$wins[rankings$team == dat$away[i]])
			inc(rankings$losses[rankings$team == dat$home[i]])

			lossRating <- rankings$rating[rankings$team == dat$home[i]]
			WWins <- rankings$wins[rankings$team == dat$away[i]]
			WLosses <- rankings$losses[rankings$team == dat$away[i]]
			overallWinRat <- rankings$rating[rankings$team == dat$away[i]]
			win_newRat <- ((lossRating + overallWinRat) + (400 * (WWins - WLosses)))/ (WWins + WLosses)

			winRating <- rankings$rating[rankings$team == dat$away[i]]
			LWins <- rankings$wins[rankings$team == dat$home[i]]
			LLosses <- rankings$losses[rankings$team == dat$home[i]]
			overallLossRat <- rankings$rating[rankings$team == dat$home[i]]
			loss_newRat <- ((winRating + overallLossRat) + (400 * (LWins - LLosses))) / (LWins + LLosses)

			rankings$rating[rankings$team == dat$away[i]] <- win_newRat
			rankings$rating[rankings$team == dat$home[i]] <- loss_newRat
		}

		else if(points_diff[i] == 0){

			inc(rankings$ties[rankings$team == dat$home[i]])
			inc(rankings$ties[rankings$team == dat$away[i]])
		}
	}

View(rankings)

sortRankings <- rankings[order(rankings$rating),]

dotchart(sortRankings$rating, labels = sortRankings$team,
	main="End of Season ELO Rating", xlab = "Rating", cex=.7, pch = 19, col = viridis(32))

for (i in 1:256){

	if (points_diff[i] > 0){
			cat(dat$home[i], "beat", dat$away[i], "\n")
	}
	else if(points_diff[i] < 0){
			cat(dat$away[i], "beat", dat$home[i], "\n")
	}
	else if(points_diff[i] == 0){
			cat(dat$home[i], "and", dat$away[i], "drew.", "\n")
	}
}

write.csv(rankings, "ELO Rankings.csv")