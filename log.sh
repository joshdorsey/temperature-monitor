#!/usr/bin/env bash

pushd ~htpc/temperature > /dev/null

. time.sh

# Log Data
declare -r LOGFILE=temperature.log

temp=$(sensors -u | grep -A 1 'Package id 0:' | grep _input | cut -s -d\  -f 4)
time=$(getTime)

if [ ! -r $LOGFILE ]; then
  echo "Couldn't find temperature log, creating it..."
  echo "Time,	Temperature" > $LOGFILE
fi

echo "${time},	${temp}" >> $LOGFILE

# Build Graphs
declare -r GRAPH_UPDATE_RATE=4

needToUpdate=''

if [ ! -r graphs/updated ]; then
  needToUpdate='Yes'
fi

lastModified=$(date +%s -r graphs/updated)
age=$(("$(date +%s)" - "$lastModified"))

if [ "$age" -gt "$GRAPH_UPDATE_RATE" ]; then
  needToUpdate='Yes'
fi

if [ ! -z "$needToUpdate" ]; then
  now=$(getTime)
  fiveMinutes=$(getTime -d '5 minutes ago')
  thirtyMinutes=$(getTime -d '30 minutes ago')
  oneHour=$(getTime -d '1 hour ago')
  threeHours=$(getTime -d '3 hours ago')

  touch graphs/updated
  ./graph.sh "$fiveMinutes" "$now" graphs/last-five-minutes.png
  ./graph.sh "$thirtyMinutes" "$now" graphs/last-thirty-minutes.png
  ./graph.sh "$oneHour" "$now" graphs/last-hour.png
  ./graph.sh "$threeHours" "$now" graphs/last-three-hours.png
fi

popd > /dev/null
