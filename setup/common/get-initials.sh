#!/bin/bash -f

export SETTINGS=$HOME/hk8sLabsSettings

echo "Please can you enter your initials - use lower case a-z only and no spaces, for example if your name is John Smith your initials would be js. This will be used to do things like name the database"

read USER_INITIALS

if [ -z "$USER_INITIALS" ]
then
    echo "You actually need to enter your initials, exiting so you can re-run the script"
    exit 2
else
    echo "OK, using $USER_INITIALS as your initials"
fi

echo export USER_INITIALS=$USER_INITIALS >> $SETTINGS