#!/bin/bash

delaysB = (0 5 23 24 25 26 35 36 40 41 45 60 61 85 110)
for delayB in "${delaysB [@]}"; do
  echo "delayB size: delayB"
  ns basic2.tcl $delayB
  python3 main.py
done
