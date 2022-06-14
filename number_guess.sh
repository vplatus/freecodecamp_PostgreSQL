#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
#echo -e "\n ~~~~~~~~ SECRET NUMBER GUESSING GAME ~~~~~~~~ \n"

# getting variable for secret number to guess
SECRET_NUMBER=$( expr $RANDOM % 1000 + 1 )
# echo "SECRET NUMBER IS: $SECRET_NUMBER" # for testing

# counting user guesses
NUMBER_OF_GUESSES=0

# guess the secret number function
GUESS_THE_SECRET_NUMBER() {

if [[ $1 ]]
then
  echo "$1"
fi

  #validating input for a guess and checking a guess
  while [[ $USER_GUESS != $SECRET_NUMBER  ]]; do       
    
    # getting input for a guess to check
    read USER_GUESS
    NUMBER_OF_GUESSES=$( expr $NUMBER_OF_GUESSES + 1 )

  if [[ ! $USER_GUESS =~ ^[0-9]*$ || -z $USER_GUESS ]]
  then
    echo "That is not an integer, guess again:"     
  else
    if [[ $USER_GUESS -lt $SECRET_NUMBER ]]
    then
      echo "It's higher than that, guess again:"      
    elif [[ $USER_GUESS -gt $SECRET_NUMBER ]]
    then
      echo "It's lower than that, guess again:"
    fi    
  fi  
  done
  GETTING_USER_ID_RESULT=$($PSQL "SELECT user_id FROM users WHERE name = '$USER_NAME';")
  INSERT_PLAYERS_GAME_RESULT="$($PSQL "INSERT INTO games(user_id, best_game) VALUES($GETTING_USER_ID_RESULT, $NUMBER_OF_GUESSES);")"
  echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
}


#------------ BODY
# getting input for username
echo "Enter your username:"
read USER_NAME

# getting input for username and validating
#GOT_USER_NAME="false"
#while [[ $GOT_USER_NAME == "false" ]]
#do
#echo "Enter your username:"
#read USER_NAME
#if [[ -n $USER_NAME ]]
#then
#  GOT_USER_NAME="true"
#fi
#export USER_NAME
#done

# Checking if the user has played before
IS_A_CLIENT_RESULT="$($PSQL "SELECT user_id FROM users WHERE name = '$USER_NAME';")"
if [[ -n $IS_A_CLIENT_RESULT ]]
then
  # the player has a record in the players database
  GAMES_PLAYED=$($PSQL "SELECT COUNT(best_game) FROM games INNER JOIN users USING(user_id) GROUP BY user_id HAVING user_id = '$IS_A_CLIENT_RESULT';")
  BEST_GAME=$($PSQL "SELECT MIN(best_game) FROM games INNER JOIN users USING(user_id) GROUP BY user_id HAVING user_id = '$IS_A_CLIENT_RESULT';")
  echo "Welcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  GUESS_THE_SECRET_NUMBER "Guess the secret number between 1 and 1000:"
else
  # new player detected
  INSERT_NEW_PLAYER_RESULT="$($PSQL "INSERT INTO users(name) VALUES('$USER_NAME');")"
  echo "Welcome, $USER_NAME! It looks like this is your first time here."
  GUESS_THE_SECRET_NUMBER "Guess the secret number between 1 and 1000:"
fi
