# ELO-Ratings

Testing the analytical applications of a chess-based ELO ranking system on NFL teams. 

Below is the ELO rankings of all NFL teams after the 2018 nfl season.

![ELO](https://user-images.githubusercontent.com/29874915/54938135-b7ee3b80-4f1d-11e9-84dd-c5b6b62983e2.PNG)

I then graphed the results of the ELO rankings in a dotchart. 
![SortedELOdotchart](https://user-images.githubusercontent.com/29874915/55000950-803dcd00-4fcb-11e9-9055-6bc081ee98d6.PNG)

Next I'm going to compare the play distributions of every team and examine correlations between certain distributions and ELO ratings.

Here's an example of play distribution using the Seahawks
![HawksPlayDist](https://user-images.githubusercontent.com/29874915/55415848-b2b86e80-5565-11e9-912b-d41d4171d8d0.PNG)

Using the nflscrapR season_play_by_play function, we can get a breakdown of every play of the season.

I'm most interested in observing how the split of pass and run plays affects ELO ratings, if at all.
First, I removed all the extra play types which doesn't provide extra insight into coaching playcalling tendencies, such as QB kneel, Spike, etc. 

I included Sacks in the breakdown as it paints a more accurate picture of total pass plays called per season. 
![HawksVsLeagueAverage](https://user-images.githubusercontent.com/29874915/55491341-3b4e1200-562d-11e9-964c-2b4a9ed92c20.PNG)

As you can see above, the Seahawks passed at a rate significantly below league average, yet still gave up an above average number of sacks. 
