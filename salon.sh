#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only  -c"

echo -e "\n~~~~~ MY SALON ~~~~~"

MAIN_MENU() {

  if [[ $1 ]]
  then
    echo -e "\n$1\n"
  fi
 
  echo -e "1) cut\n2) color\n3) perm\n4) style\n5) trim"
  read SERVICE_ID_SELECTED

SERVICE_ID_NAME="$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")"
SERVICE_ID_NAME="$(echo "$SERVICE_ID_NAME" | sed -E 's/^ *| *$//')"
export SERVICE_ID_NAME

if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+ ]]
then
  # incorrect input-not a number
  MAIN_MENU "Incorrect input. Please enter a number associated with a service you'd like!"
else 
  # Got a number from input. Is there such a service available?
  ALL_SERVICES_IDS="$($PSQL "SELECT service_id FROM services;")"
  SERVICE_FOUND="$( echo "$ALL_SERVICES_IDS" | while read SERVICE_AVAILABLE
  do 
    if [[ $SERVICE_ID_SELECTED == $SERVICE_AVAILABLE ]] 
    then
      # The service is available for scheduling
      echo "true"
      break
    fi
  done )"  
  if [[ $SERVICE_FOUND == "true" ]] 
  then
    # there is such a service... Checking Client 
    CHECKING_CLIENT
  else
    # no such service
    echo -e "\nI could not find that service. What would you like today?"
    MAIN_MENU 
  fi
fi
}

CHECKING_CLIENT() {
      # Checking if the customer is already in the salon's database
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE
      export CUSTOMER_PHONE
      IS_CUSTOMER_ID_IN_DATABASE=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")
      if [[ -z $IS_CUSTOMER_ID_IN_DATABASE ]]
      then
        ADDING_NEW_CLIENT "I don't have a record for that phone number, what's your name?"
      else
        IS_CUSTOMER_ID_IN_DATABASE="$(echo "$IS_CUSTOMER_ID_IN_DATABASE" | sed  's/ //g')"
        export IS_CUSTOMER_ID_IN_DATABASE
        SETTING_AN_APPOINTMENT
      fi
}


ADDING_NEW_CLIENT() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  read CUSTOMER_NAME
  ADDING_NEW_CLIENT_RESULT="$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")"
  IS_CUSTOMER_ID_IN_DATABASE=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")
  IS_CUSTOMER_ID_IN_DATABASE="$(echo "$IS_CUSTOMER_ID_IN_DATABASE" | sed  's/ //g')"
  export IS_CUSTOMER_ID_IN_DATABASE
  SETTING_AN_APPOINTMENT
}

SETTING_AN_APPOINTMENT() { 
  #echo "$IS_CUSTOMER_ID_IN_DATABASE"
  CLIENTS_NAME="$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")"
  CLIENTS_NAME="$(echo "$CLIENTS_NAME" | sed -E 's/^ *| *$//')"
  echo -e "\nWhat time would you like your $SERVICE_ID_NAME, $CLIENTS_NAME?"
  read SERVICE_TIME
  SETTING_NEW_APPOINTMENT_RESULT="$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($IS_CUSTOMER_ID_IN_DATABASE, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")"
  echo -e "\nI have put you down for a $SERVICE_ID_NAME at $SERVICE_TIME, $CLIENTS_NAME."
}

MAIN_MENU "Welcome to My Salon, how can I help you?"
