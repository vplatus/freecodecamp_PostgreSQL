#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#cleaning the database 
echo $($PSQL "TRUNCATE teams, games;")
#function for adding teams names into database(winner and opponnents)
is_team_in_database () {
  TEAM_IN_DATABASE=$($PSQL "SELECT team_id FROM teams WHERE name = '$1';")
  if [[ -z $TEAM_IN_DATABASE ]]
  then
    TEAM_ADDED=$($PSQL "INSERT INTO teams(name) VALUES('$1');")
    if [[ $TEAM_ADDED == "INSERT 0 1" ]]
    then
      echo -e "\nInserted into teams, '$1'"
    fi
  fi
}

#reading a line at a time from file
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
#passing a title line
  if [[ $YEAR == year ]]; then continue
  fi
#adding teams names into the teams table 
  is_team_in_database "$WINNER" 
  is_team_in_database "$OPPONENT"
#getting new winner_id
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
#getting new opponent_id
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
#adding data into the games table 
  ROW_ADDED=$($PSQL "INSERT INTO games(year, winner_id, opponent_id, winner_goals, opponent_goals, round) VALUES($YEAR, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS, '$ROUND');")
  if [[ $ROW_ADDED == "INSERT 0 1" ]]
  then
    echo -e "\nInserted into games: $YEAR $WINNER_ID $OPPONENT_ID $WINNER_GOALS $OPPONENT_GOALS $ROUND"
  fi
done