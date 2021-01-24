#!/usr/bin/env bash

if [ $# -eq 3 ]; then
  echo "Plotting from $1 to $2"
  start="$1" end="$2" outFile="$3" <do-plot.gnuplot envsubst | gnuplot
else
  echo "Wrong number of arguments, usage:"
  echo "graph.sh <start time> <end time> <filename>"
fi
