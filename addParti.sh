#!/bin/bash

cp AllCandidates.complete.csv AllCandidates.complete.annotated.csv

while read p; do
    parti=`echo "$p" | cut -d, -f 1`
    person=`echo "$p" | cut -d, -f 2 | xargs`

    str="s/${person}/${parti}, ${person}/g"
    cat AllCandidates.complete.annotated.csv | sed "$str" > tmpfile
    mv tmpfile AllCandidates.complete.annotated.csv
done <map.csv
