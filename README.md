# Final Project
Use this `REAMDE.md` file to describe your final project (as detailed on Canvas).

# Project Setup


# Domain of Interest

## Main topic
I'll try to do some data analysis on video games / eSports. I'll probably do League of Legends because of it having an established professional scene as well as it having an open API with a wide variety of data.

## Why?
I've played LoL in the past, and would also like to explore using APIs more, so this seems like a reasonable choice. Machine Learning might also be fun to investigate if I end up having enough time. I planned on doing this sort of project over this summer, so starting in R in this class would be fun.

## Existing Related Examples

<!-- TODO: Look at rubric -->

### [What is it like to be a Data Scientist with a passion for Gaming ...](https://towardsdatascience.com/what-is-like-to-be-a-data-scientist-with-a-passion-for-gaming-43c067ad6415)

This is an example of an article someone on Medium wrote about their personal project in analyzing some aspects of professional LoL. Their main aim appeared to be to see if one can use statistics from the past to predict if one team will win or not in a game.

Their final results appeared to have an accuracy of 98.43% in predicting if one team will win or lose, however they used statistics that would happen during the game itself, and admitted that only using prematch knowledge would be a very weak predictor of match outcome.

They made a Shiny app, though it appeared to not be linked in the article.

### [Understanding League of Legends Data Analytics](https://medium.com/snipe-gg/understanding-league-of-legends-data-analytics-c2e5d77b55e6)

This was a more meta-study on analytic websites that provide data and stats for players. It points out some advantages and pitfalls of such sites, and emphasizes the importance of stats in creating a particular 'metagame' for video games due to their availability for the average person.

### [OP.GG](https://na.op.gg/)

This is an example of one of the data sites mentioned in the second example. Here, a player can enter their username and receive statistics based on their recent past games, for example the stats for the [ex-professional Dyrus](https://na.op.gg/summoner/userName=Dyrus).

### [Machine Learning to analyze League of Legends](https://business.blogthinkbig.com/machine-learning-to-analyze-league-of/)

<!-- TODO: Finish section -->

### [Actions](https://actions.quarte-riposte.com/)

An example of using ML and webscraping of the FIE database for fencing referees to train or comment upon what certain actions are.

## What questions?

1. How impactful are pre-match decisions in affecting the outcome of the match itself compared to factors that occur during the game?
2. Are there overall trends that appear to be similar to other eSports? Are there trends that appear to be unique to LoL or this genre of competitive video games? What parallels are there to "real" sports such as baseball or fencing?
3. How do various factors such as variance in champion choice affect a player's improvement? Does improvement tend to follow some sort of piecewise-linear trend, or other model?

# Data Sets

## [Riot API's Player Data](https://developer.riotgames.com/apis#match-v4)

This is from the official Riot API, and is generated for each individual player. This is the most recent 100 games for any player. The data includes data such as champion played, lane/role, etc.

<!-- TODO: Columns and rows for data -->
<!-- TODO: What questions can be answered -->


## [Riot API's Match Data](https://developer.riotgames.com/apis#match-v4/GET_getMatch)

This is from the official Riot API, generated for each individual match. This gives detailed information about a specific match in detail. For example, number of towers killed, the people that played in this match, who won, etc.

<!-- TODO: Columns and rows for data -->
<!-- TODO: What questions can be answered -->

## [OpenDota API](https://docs.opendota.com/)

An unofficial API for DotA 2, a video game / eSport in the same genre as LoL. 

<!-- TODO: Columns and rows for data -->

May be interesting to compare overarching themes, perhaps in the professional level for any common or uncommon trends.

## [International Fencing Federation Results](https://fie.org/competitions)

This is a website with information on international fencing competitions. Could be scraped to produce a usable database.

<!-- https://www.reddit.com/r/Fencing/comments/bogvnb/machine_learningsports_analysis/ -->

<!-- TODO: Columns and rows for data -->

May be interesting to compare eSports to more traditional sports, of which I best understand fencing.