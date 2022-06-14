#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"

read USERNAME

CHECK_USERNAME=$($PSQL "SELECT name FROM username WHERE name='$USERNAME'")

RANDOM_NUMBER=$(( $RANDOM % 6 + 1 ))

NUM=0

if [[ -z $CHECK_USERNAME   ]]

  then

    ADD_USERNAME_RESULT=$($PSQL "INSERT INTO username(name) VALUES ('$USERNAME')")

    echo "Welcome, $USERNAME! It looks like this is your first time here."

    

    USER_ID=$($PSQL "SELECT user_id FROM username WHERE name='$USERNAME'")

    GAMES_USER_ID=$($PSQL "INSERT INTO games(user_id) VALUES($USER_ID)")

    GAMES_PLAYED=$($PSQL "SELECT games_played FROM games WHERE user_id=$USER_ID")

    

    while [[ $RANDOM_NUMBER != $GUESS  ]]

      do

      NUM=$(( $NUM+1))

      echo "Guess the secret number between 1 and 1000:"

      read GUESS

      if [[ ! $GUESS =~ [0-9]   ]]

         then

           echo "That is not an integer, guess again:"

           continue

      else   

          if [[ $GUESS -lt $RANDOM_NUMBER  ]]

             then

               echo "It's higher than that, guess again:" 

          elif [[ $GUESS -gt $RANDOM_NUMBER    ]]

             then

               echo "It's lower than that, guess again:"

          fi

       fi   

      done

      GAMES_PLAYED_INSERT=$($PSQL "UPDATE games SET games_played=$GAMES_PLAYED + 1 WHERE user_id=$USER_ID")

      NUMBER_OF_GUESSES_INSERT=$($PSQL "UPDATE games SET number_of_guesses = $NUM WHERE user_id=$USER_ID")

      echo "You guessed it in $NUM tries. The secret number was $RANDOM_NUMBER. Nice job!"

      

else

    USER_ID=$($PSQL "SELECT user_id FROM username WHERE name='$USERNAME'")

    GAMES_PLAYED=$($PSQL "SELECT games_played FROM games WHERE user_id=$USER_ID AND games_played = (SELECT MAX(games_played) FROM games WHERE user_id=$USER_ID)")

    BEST_GUESS=$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE user_id=$USER_ID")

    echo "Welcome back, $CHECK_USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GUESS guesses."

   

    while [[ $RANDOM_NUMBER != $GUESS  ]]

      do

      NUM=$(( $NUM+1))

      echo "Guess the secret number between 1 and 1000:"

      read GUESS

      if [[ ! $GUESS =~ [0-9]   ]]

         then

           echo "That is not an integer, guess again:"

           continue

      else     

          if [[ $GUESS -lt $RANDOM_NUMBER  ]]

            then

               echo "It's higher than that, guess again:" 

          elif [[ $GUESS -gt $RANDOM_NUMBER    ]]

            then

               echo "It's lower than that, guess again:"

          fi

      fi    

      done

      GAMES_PLAYED=$(( $GAMES_PLAYED + 1 ))

      GAMES_PLAYED_INSERT=$($PSQL "INSERT INTO games(games_played, user_id, number_of_guesses) VALUES ($GAMES_PLAYED , $USER_ID, $NUM)")

      BEST_GAME_INSERT=$($PSQL "UPDATE games SET best_game = true WHERE user_id= $USER_ID AND number_of_guesses = (SELECT MIN(number_of_guesses) FROM games WHERE user_id = $USER_ID )")

      echo "You guessed it in $NUM tries. The secret number was $RANDOM_NUMBER. Nice job!"

fi
