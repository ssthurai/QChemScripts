for f in *.out; do grep "Total energy" $f | tail -n1 | awk '{print $1, $4}'; done > 
