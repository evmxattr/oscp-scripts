#!/bin/zsh

LOG_FOLDER="./logs"

if [ "$SCRIPT" ]; then
    echo "Already in a script session"
    exit
fi

if [ -d "$LOG_FOLDER" ]; then
    echo "Using logs folder in the current working directory"
else
    LOG_FOLDER="/data/logs"
    echo "Using default logs folder: $LOG_FOLDER"
fi

DATE=$(date '+%Y-%m-%d-%H_%M');

export SCRIPT="$LOG_FOLDER/$DATE-$1.log"

shift
exec /usr/bin/script -a -f "$@" $SCRIPT
