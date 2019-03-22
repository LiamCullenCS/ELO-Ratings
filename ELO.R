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

#get first 16 games (week 1)
week_1 <-dat[1:16,]
View(week_1)
	
#increment function
inc <- function(x) {eval.parent(substitute(x <- x + 1))}

points_diff <- week_1$homescore - week_1$awayscore

	for (i in 1:16){

		if (points_diff[i] > 0){
			cat(week_1$home[i], "beat", week_1$away[i], "\n")
			inc(rankings$wins[rankings$team == week_1$home[i]])
			inc(rankings$losses[rankings$team == week_1$away[i]])
		}

		else if(points_diff[i] < 0){
			cat(week_1$away[i], "beat", week_1$home[i], "\n")
			inc(rankings$wins[rankings$team == week_1$away[i]])
			inc(rankings$losses[rankings$team == week_1$home[i]])
	
		}
		else if(points_diff[i] == 0){
			cat(week_1$home[i], "and", week_1$away[i], "drew.", "\n")
			inc(rankings$ties[rankings$team == week_1$home[i]])
			inc(rankings$ties[rankings$team == week_1$away[i]])

		}
	}

View(rankings)




