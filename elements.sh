#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

GET_ELEMENTS_INFO() {
  case $2 in
    1) GET_ELEMENT_INFO_RESULT="$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) WHERE atomic_number = $1;")"
       if [[ -z $GET_ELEMENT_INFO_RESULT ]]
       then
         echo "I could not find that element in the database."
       fi
       ;;
    2) GET_ELEMENT_INFO_RESULT="$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) WHERE symbol = '$1';")"
       if [[ -z $GET_ELEMENT_INFO_RESULT ]]
       then
         echo "I could not find that element in the database."
       fi
       ;;
    3) GET_ELEMENT_INFO_RESULT="$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) WHERE name = '$1';")"
       if [[ -z $GET_ELEMENT_INFO_RESULT ]]
       then
         echo  "I could not find that element in the database."
       fi
       ;;
    4) echo "I could not find that element in the database."
    esac
  GET_ELEMENT_INFO_RESULT="$(echo "$GET_ELEMENT_INFO_RESULT" | sed 's/ | /,/g; s/ //g;  s/,/ /g ')"
  echo "$GET_ELEMENT_INFO_RESULT" | while read ATOMIC_NUMBER ELEMENTS_SYMBOL ELEMENTS_NAME ELEMENTS_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
  do
    if [[ -n $GET_ELEMENT_INFO_RESULT ]]
    then
      echo  "The element with atomic number $ATOMIC_NUMBER is $ELEMENTS_NAME ($ELEMENTS_SYMBOL). It's a $ELEMENTS_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENTS_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  done
}

if [[ $1 ]]
then
  # Request for an element received.
  # validating the input and getting the corresponding data from database
  LENGTH_PARAM_FIRST="$( expr length $1 )"
  if [[ $1 =~ ^[0-9]+ ]]
  then
  # passing the argument as atomic_number
    GET_ELEMENTS_INFO $1 1
  elif [[ $1 =~ ^[A-Z] && LENGTH_PARAM_FIRST -le 3 ]]    
  then
    # passing the argument as the element's symbol
    GET_ELEMENTS_INFO $1 2
  elif [[ LENGTH_PARAM_FIRST -ge 4 ]]
  then
    # passing the argument as the element's name
    GET_ELEMENTS_INFO $1 3
  else
    GET_ELEMENTS_INFO $1 4
  fi  
else
  # argument for the script had not been provided. 
  echo -e "Please provide an element as an argument."  
fi
