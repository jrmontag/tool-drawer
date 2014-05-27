#!/usr/bin/env bash
# Josh Montague
# MIT License

echo $(date)
echo

#TODO: generalize "what to look for" & "what to do now"

# file type
FILE=".git"

start_dir=$(pwd)
cd $HOME                                    # assumes your repos are in ~

for d in $(find -maxdepth 1 -type d); do    # find dirs in home 
    if [ $(find $d -name $FILE) ]; then     # look for sign of git repo 
        cd $d                               
        RESP=$(git status)                  # find current status 
        if [[ $RESP != *"working directory clean"* ]]; then
            echo
            echo "******************************************************"
            echo "repo: $d has changes!"
            echo "response: ${RESP}"
            echo
        fi
        cd ~    # jump back to ~
    fi
done

cd $start_dir                               # politely retur to starting location

echo $(date)
