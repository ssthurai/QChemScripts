#!/usr/bin/env bash
rm csv_oon*.csv
for g in *.out
do
    n=$(grep "alpha and" $g | awk 'FNR == 1 {print $3}')
    #"$(paste -s "$(grep -C10 " $n f = " $g | tail -n21 | awk '{print $1, $4}')")" > file.txt
    #do paste <(echo $file) <(grep "Total energy" $file | tail -n1 | awk '{print $9}') >> energy.csv; done
    #paste < ((grep -C10 " $n f = " $g | tail -n21 | awk '{print $1}')) <(grep -C10 " $n f = " $g | tail -n21 | awk '{print $4}') >> csv_oon.csv
    grep -C15 " $n f = " $g | tail -n31 | awk '{print $1}' >  part_1
    grep -C15 " $n f = " $g | tail -n31 | awk '{print $4}' >  part_2
    name=$(echo "$g" | sed 's/\.out//g')
    paste "part_1" "part_2" | column -t > csv_oon_of_"$name".csv

done

rm part_1
rm part_2

for f in csv_oon_of_acene_*.csv; do echo "   "; echo $f; echo "   "; cat $f; done >> all.csv
