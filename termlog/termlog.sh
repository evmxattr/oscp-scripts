#!/bin/zsh

# /usr/bin/script --timing=timingfile -a -f commands.log
# scriptreplay timingfile commands.log
# scriptreplay_ng -a 3 2024-09-15-21_45-privesc_windows.log

# cat commands.log | sed 's/\x1b\[[0-9;]*m//g'
# cat commands.log | col -b

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
