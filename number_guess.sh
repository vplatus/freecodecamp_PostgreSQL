#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# getting variable for secret number to guess
SECRET_NUMBER=$( expr $RANDOM % 1000 )
#echo "SECRET NUMBER IS: $SECRET_NUMBER" # for testing

# getting input for username
read -p "Enter your username:" USER_NAME

# counting user guesses
NUMBER_OF_GUESSES=1

# guess the secret number function
GUESS_THE_SECRET_NUMBER() {
  # printing the message passed as an argument
  if [[ $1 ]]
  then
    echo "$1"
  fi

  # getting input for a guess to check
  read USER_GUESS

  #validating input for a guess
  if [[ ! $USER_GUESS =~ ^[0-9]+ ]]
  then
    echo "That is not an integer, guess again:"
    GUESS_THE_SECRET_NUMBER
  else
    if [[ $USER_GUESS -lt $SECRET_NUMBER ]]
    then
      echo "It's higher than that, guess again:"
      NUMBER_OF_GUESSES=$( expr $NUMBER_OF_GUESSES + 1 )
      GUESS_THE_SECRET_NUMBER
    elif [[ $USER_GUESS -gt $SECRET_NUMBER ]]
    then
      echo "It's lower than that, guess again:"
      NUMBER_OF_GUESSES=$( expr $NUMBER_OF_GUESSES + 1 ) 
      GUESS_THE_SECRET_NUMBER
    else
      echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      if [[ $CLIENT_STATUS == "old" ]]
      then
        # updating database for the player
        echo "OLD RECORD: $($PSQL "SELECT * FROM players WHERE username = '$USER_NAME';")"
        UPDATE_PLAYERS_RECORD_RESULT="$($PSQL "UPDATE players SET games_played = games_played + 1 WHERE username = '$USER_NAME';")"
        if [[ $NUMBER_OF_GUESSES -lt $($PSQL "SELECT best_game FROM players WHERE username = '$USER_NAME';") ]]
        then
          UPDATE_PLAYERS_RECORD_RESULT="$($PSQL "UPDATE players SET best_game = '$NUMBER_OF_GUESSES' WHERE username = '$USER_NAME';")"
        fi
        echo "NEW RECORD: $($PSQL "SELECT * FROM players WHERE username = '$USER_NAME';")"
      else
        INSERT_PLAYERS_RECORD_RESULT="$($PSQL "INSERT INTO players(username, games_played, best_game) VALUES('$USER_NAME', 1, $NUMBER_OF_GUESSES);")"
        echo "NEW RECORD: $($PSQL "SELECT * FROM players WHERE username = '$USER_NAME';")"
      fi
    fi
  fi
}

# Checking if the user has played before
IS_A_CLIENT_RESULT="$($PSQL "SELECT username, games_played, best_game FROM players WHERE username = '$USER_NAME';")"
if [[ -n $IS_A_CLIENT_RESULT ]]
then
  # the player has a record in the players database
  CLIENT_STATUS="old"
  echo "$IS_A_CLIENT_RESULT" | while IFS="|" read USER_NAME GAMES_PLAYED BEST_GAME
  do
    echo "Welcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
  GUESS_THE_SECRET_NUMBER "Guess the secret number between 1 and 1000:"
else
  # new player detected
  CLIENT_STATUS="new"
  echo "Welcome, $USER_NAME! It looks like this is your first time here."
  GUESS_THE_SECRET_NUMBER "Guess the secret number between 1 and 1000:"
fi
