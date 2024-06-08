#!/bin/bash

overhead="0 0.005 0.02"
elements=(25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55)

for oh in $overhead; do
  for element in "${elements[@]}"; do
    ns basic2.tcl $element $oh \
      | tail -n 1 \
      | awk '{$2=""; print $0}' \
      | awk '{for (i=1; i<=NF-2; i++) printf $i " "; print ""}' \
      | tr ' ' ',' >> "output$oh.csv"
  done
done
