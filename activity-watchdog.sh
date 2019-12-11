#!/bin/bash
export DISPLAY=:0

#####################################################################
# Created by: Nahúm Manuel Martín Vegas                             #
# URL: https://github.com/nadamas2000/activity-watchdog             #
# File: activity-watchdog.sh                                        #
# Version: V1                                                       #
# Date: 04-dec-2019                                                 #
# Developed in: Facultat d´informàtica de Barcelona (FIB)           #
#               Universitat Politécnica de Catalunya (UPC)          #
#                                                                   #
# Project name: Activity-watchdog for Raspberry Pi (Raspbian linux) #
# Project files:        activity-watchdog.sh                        #
#                       activity-watchdog.conf                      #
#                       software-watchdog.shlib                     #
#                       idle-watchdog.shlib                         #
#####################################################################


SOURCE=${BASH_SOURCE[0]}
EXEDIR=$(dirname $SOURCE)

# Default parameters. This parameters are changed by activity-watchdog.conf
USER="username"
LOGFILEDIR=$EXEDIR
LOGFILENAME="activity-watchdog.log"
LOGFILE_BY_EXECUTION=true
WAITING_FOR_PROC="Xorg"
FIRST_WAITING=20
OBS_INTERVAL=1
FORCE_LIST_WATCHDOG_ENABLED=true
BLACKLIST_WATCHDOG_ENABLED=true
IDLE_WATCHDOG_ENABLED=true
declare -a FORCE_LIST_PROC BLACKLIST_PROC EXCEPTION_LIST IDLE_KILL_LIST
GENERAL_VIOLATION_PROCEDURE=""
MINUTS_IN_IDLE_STATE=1
SECONDS_TO_CLOSE=5
TIMEFILE_ENABLED=false
TIMEFILENAME="idle-watchdog.time"

# Load config file
CONFIGFILE="$EXEDIR/activity-watchdog.conf"
if [ ! -f "$CONFIGFILE" ]; then
        echo "No es troba el fitxer de configuració"
        exit 1
else
        source $CONFIGFILE
fi

LOGFILE="$LOGFILEDIR/$LOGFILENAME"

# Force parameters to minimum value.
if [[ $FIRST_WAITING -lt 0 ]]; then
        FIRST_WATING=0
fi
if [[ $OBS_INTERVAL -le 0 ]]; then
        OBS_INTERVAL=1
fi
if [[ $MINUTS_IN_IDLE_STATE -lt 1 ]]; then
        $MINUTS_IN_IDLE_STATE=1
fi
if [[ $SECONDS_TO_CLOSE -lt 0 ]]; then
        $SECONDS_TO_CLOSE=0
fi


#################### FUNCTIONS AND SHLIBs ##########################

# Function to add info to logfile
msgToLog () {
        $(echo $(date)" "$1 >> $LOGFILE)
}

# Load software-watchdog.shlib
SOFTWAREWATCHDOG="$EXEDIR/software-watchdog.shlib"
if [ ! -f "$SOFTWAREWATCHDOG" ]; then
        echo "software-watchdog file not found"
        exit 1
else
        source $SOFTWAREWATCHDOG
fi

# Load idle-watchdog.shlib
IDLEWATCHDOG="$EXEDIR/idle-watchdog.shlib"
if [ ! -f "$IDLEWATCHDOG" ]; then
        echo "idle-watchdog file not found"
        exit 1
else
        source $IDLEWATCHDOG
fi



####################### MAIN ###########################
main() {
        if $LOG_FILE_BY_EXECUTION; then
                echo $(date)" Creating new logfile..." > $LOGFILE
        else
                echo $(date)" Starting activity-watchdog..." >> $LOGFILE
        fi

        msgToLog "Waiting for the first execution of $WAITING_FOR_PROC ..."
        declare -a PIDX                 # declare array PIDX
        PIDX=($(pgrep $WAITING_FOR_PROC))       # Obtain PIDs with $WAITING_FOR_PROC name to array
        # Waiting process
        while [ -z "${PIDX[0]}" ]; do
                sleep1
                PIDX=($(pgrep $WAITING_FOR_PROC))
        done
        msgToLog "$WAITING_FOR_PROC detected with PID: ${PIDX[0]}"
        msgToLog "Waiting $FIRST_WAITING"
        sleep $FIRST_WAITING            # Time to load the process

        #################### PERSISTENT ACTIVITY #####################
        msgToLog "Initializing watchdog (while-true)"
        while [ true ]; do
                sleep $OBS_INTERVAL
                softwareWatchdog
                if $IDLE_WATCHDOG_ENABLED; then
                        idleWatchdog
                fi
        done
}

main "$@"
