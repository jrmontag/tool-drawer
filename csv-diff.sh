#!/usr/bin/env bash
# Josh Montague
# MIT License

# csv-diff.sh: a simple shell script to "diff" the contents of two csv-like files, row by row


### user params ###
# - imagine these as cmd-line opts someday

# diff display width
width=100

# "csv" delimiter
delim="|"   # doesn't work yet. specify manually, below, in sed

####################


usage(){
    echo "Usage: $0 file1 file2"
    exit 1
}

# if two args aren't given, display the usage func
if [[ $# -ne 2 ]] ; then
    usage 
fi

# read input files through custom pipes
while read line1 <&3 && read line2 <&4; do
    echo $line1 | sed 's/|/\n/g' > tmp1
    echo $line2 | sed 's/|/\n/g' > tmp2
    echo "$1 <== | ==> $2"
    diff -y -W${width} tmp1 tmp2
    echo "******************************************"
    echo "******************************************"
    echo "******************************************"
done 3< $1 4< $2 

# clean up
rm tmp1 tmp2

