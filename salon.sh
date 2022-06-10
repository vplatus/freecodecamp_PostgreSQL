#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -c"
echo -e "\n ~~~~~~~~ Welcome to the FLASHBACK Barber Shop ~~~~~~\n"

MAIN_MENU {
  if [[ $1 ]]
  then
    echo $1
  fi

echo -e "$($PSQL "SELECT * FROM services;")" | sed 's/ | /,/g' | while IFS="," read SERVICE_ID SERVICE_NAME SERVICE_PRICE
#<< 'MULTILINE-COMMENT'
#MULTILINE-COMMENT
do
  SERVICE_ID=$( echo $SERVICE_ID | sed -E 's/ //g' )
  SERVICE_NAME=$( echo $SERVICE_NAME | sed -E 's/^ * | *$//' )
  if [[ $SERVICE_ID =~ ^[0-9] ]]
  then
    echo "$SERVICE_ID) $SERVICE_NAME"
 fi
done
}

MAIN_MENU "Welcome to My Salon, how can I help you?"
