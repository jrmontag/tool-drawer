#!/usr/bin/env bash
# Josh Montague
# MIT License

# this script is intended to be run from anywhere and let you know if your git
#    repos are in any state other than "clean". this was originally intended 
#    to let me know - quickly - if i would regret deleting a bunch of
#    directories. note that this script assumes a few things (for now):
#    - the repos you want to check out are located in your home dir (~)
#    - the repo dirs do not contain other repos (ie we only go one layer down)

echo $(date)
echo

STARTDIR=$(pwd)     # keep track of where we started
REPODIR=$HOME       # location in which the repos are stored  
FILE=".git"         # file for which we're looking 

cd $REPODIR
for d in $(find . -maxdepth 1 -type d); do                # find dirs 
    if [ $(find $d -maxdepth 1 -name $FILE) ]; then     # look for sign of git repo 
        cd $d                               
        RESP=$(git status)                              # find current status 
        if [[ $RESP != *"working directory clean"* ]]; then
            echo
            echo "******************************************************"
            echo "repo: $d has changes! git status: "
            echo
            echo "${RESP}"
            echo
            echo "******************************************************"
            echo
        fi
        cd -                                            # jump back 
    fi
done

cd $STARTDIR                               # politely return to starting location

echo "done."

echo $(date)
