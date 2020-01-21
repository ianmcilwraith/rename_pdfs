#!/bin/bash
FILES=~/directory/*.pdf
for f in $FILES
do
 echo "Processing $f file..."
 pdftotext $f file.txt
 filename="$(grep 'TEXT BEFORE DESIRED FILENAME' file.txt | sed 's/^.*: //')"
 # can also use a variable to grab specific columns
 # line2column2="$(awk 'NR==2 { print $2 }' file.txt)"
 # line2column1="$(awk 'NR==2 { print $1 }' file.txt)"
 echo "File Name: $filename"
  if [[ ! -e ~/renamed_directory/"$filename".pdf ]]; then
    # file does not exist in the destination directory
    mv $f ~/renamed_directory/"$filename".pdf
  else
    num=2
    # if duplicate file name is found, a number starting at "2" will be added before the extension
    while [[ -e ~/renamed_directory/"$filename$num".pdf ]]; do
        (( num++ ))
    done
    mv $f ~/renamed_directory/"$filename$num".pdf
  fi
done
