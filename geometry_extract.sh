#!/bin/bash

display_usage() {
        echo "$0 <Q-Chem output file> <xyz file for script to output>"
        echo "Can omit the final argument if print to terminal."
}

case "$#" in
"1")
        output_file="$1"
        ;;
"2")
        output_file="$1"
        xyz_file="$2"
        exec >${xyz_file}
        ;;
*)
        display_usage
        exit -1
        ;;
esac


tac ${output_file} | \
        sed '/Standard Nuclear Orientation/q' | \
        head -n -3 | tac | \
        sed '/--------/q' | sed '$ d' | \
        awk -v OFS='\t' '{print $2,$3,$4,$5}'

#To attach charge, spin and input tages.

#sed -i '1 i\-1 2' $1
#sed -i '1 i\$molecule' $1
#sed -i -e '$a$end' $1
