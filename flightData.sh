#!/bin/bash

inputfile="flightData.txt"
clearfiles=0

#Script made for school assignment
#It reads a file in CSV format and divide the rules in seperate file depending on the prefix of the row

#check for given arguments
#If parameter remove has been passed, clear all the files
if [ $1 == "remove" ]
then
    clearfiles=1
fi

#The inputfile can also be passed as argument
if [[ -z "$2" ]]
then
    inputfile=$2
fi

#Remove existing files in data-dir
if [ $clearfiles -eq 1 ]
then
    echo "Removing existing files.."
    for i in `ls data`
    do
        rm -f "data/$i"
    done
fi

#Read the CSV and create files
echo "Start reading $(wc -l $inputfile | cut -f1 -d' ') lines..."
#| head -n900
cat $inputfile | while read line
do
    fn="data/$(echo $line | cut -d\" -f2 | cut -d\- -f1)"
    echo $line >> $fn
done

#Show how many flights for each file and sort the files
for i in `ls data`
do
    fn="data/$i"
    sort $fn -o $fn
    echo "For airport $i there are $(wc -l $fn | cut -f1 -d' ') flights"
done