#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -c"
echo -e "\n ~~~~~~~~ Welcome to the FLASHBACK Barber Shop ~~~~~~\n"

MAIN_MENU {
  if [[ $1 ]]
  then
    echo -e "\n$1"
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

read SERVICE_ID_SELECTED
if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+ ]]
then
  # incorrect input-not a number
  MAIN_MENU "Incorrect input. Please enter a number associated with a service you'd like!"
else 
  # Got a number from input. Is there such a service available?
  ALL_SERVICES_IDS="$($PSQL "SELECT service_id FROM services;")"
  echo "$ALL_SERVICES_IDS" | while read SERVICE_AVAILABLE
  do
    SERVICE_AVAILABLE=$(echo $SERVICE_AVAILABLE | sed 's/^ * | *$//')
    if [[ $SERVICE_ID_SELECTED == $SERVICE_AVAILABLE ]] 
    then
      # The service is available for scheduling
      # Checking if the customer is already in the salon's database
      echo -e "\nWhat is your phone number?"
      read PHONE_NUMBER
      IS_IN_DATABASE_RESULT=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$PHONE_NUMBER';")
      if [[ -z $IS_IN_DATABASE_RESULT ]]
      then
        ADDING_NEW_CLIENT "I don't have a record for that phone number, what's your name?"
      else
        SETTING_AN_APPOINTMENT
      fi
    fi
  done
  # there is no such a service available at Main menu
  MAIN_MENU "I could not find that service. What would you like today?"
fi
}

ADDING_NEW_CLIENT {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  read NEW_NAME
  ADDING_NEW_CLIENT_RESULT="$($PSQL "INSERT INTO customers(phone, name) VALUES('$PHONE_NUMBER', '$NEW_NAME');")"
  SETTING_AN_APPOINTMENT
}

SETTING_AN_APPOINTMENT {
  CUSTOMER_ID_RESULT=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$PHONE_NUMBER';")  
  SERVICE_NAME_SELECTED="$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")"
  CLIENTS_NAME="$($PSQL "SELECT name FROM customers WHERE phone = '$PHONE_NUMBER';")"
  echo -e "\nWhat time would you like your $SERVICE_NAME_SELECTED, $CLIENTS_NAME"
  read TIME_OF_APPOINTMENT
  SETTING_NEW_APPOINTMENT_RESULT="$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID_RESULT, $SERVICE_ID_SELECTED, '$TIME_OF_APPOINTMENT');")"
  echo -e "\nI have put you down for a cut at $TIME_OF_APPOINTMENT, $CLIENTS_NAME."
}


MAIN_MENU "Welcome to My Salon, how can I help you?"

