#!/bin/sh

#CREATED THE VARS FOR THE DIRECTORIES
word_to_redact=$1
doc_to_redact=$2

#STORED THE REDACT WORDS IN AN ARRAY
my_arr=($(cat "$word_to_redact"))
substitutions=()

for var in "${my_arr[@]}"
do
    substitutions+=(-e 's/'"${var}"'/---/g')
done
sed "${substitutions[@]}" $doc_to_redact > file.txt

##############
# READING LINE BY LINE
while read line
do
    if [ `expr "$line" : ".*\(---\).*\1"` ]; 
    then
        value_line=$( echo $line | wc -c )
        seq  -f "-" -s '' $value_line 
        echo " "
    else
        echo $line
    fi
done < file.txt
###############