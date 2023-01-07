#!/usr/bin/env bash

# Remove any existing files with names matching the pattern "csv_oon*.csv"
rm csv_oon*.csv

# Loop over all files with the .out extension in the current directory
for g in *.out; do
    # Extract the value of n from the first line containing "alpha and"
    n=$(grep -m1 "alpha and" "$g" | awk '{print $3}')

    # Extract the lines containing " $n f = " and the lines within 15 lines before and after these lines
    grep -A15 -B15 " $n f = " "$g" | tail -n31 | awk '{print $1, $4}' > "csv_oon_of_${g%.out}.csv"
done

# Append the contents of all the "csv_oon_of_*.csv" files to a file called "all.csv"
cat csv_oon_of_*.csv >> all.csv
