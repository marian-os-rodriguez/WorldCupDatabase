#!/bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

count=0
while IFS="," read year round winner opponent winner_goals opponent_goals
do
  ((count++))	
  if [[ $count -gt 1 ]];
  then
      INSERT_WINNER=$($PSQL "insert into teams(name) values ('$winner')")
      INSERT_OPPONENT=$($PSQL "insert into teams(name) values ('$opponent')")
      WINNER_ID=$($PSQL "select team_id from teams where name='$winner'")
      OPPONENT_ID=$($PSQL "select team_id from teams where name='$opponent'")
      INSERT_GAMES=$($PSQL "insert into games (year,round,winner_id,opponent_id,winner_goals,opponent_goals) values ($year,'$round',$WINNER_ID,$OPPONENT_ID,$winner_goals,$opponent_goals)")
      echo "Inserted games, $INSERT_GAMES"
  fi	
done < games.csv