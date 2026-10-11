#!/bin/bash

# Variable to track the timestamp of the last sent notification
LAST_SENT=0

# Stream journalctl for system errors (priority 3 and worse)
# Using process substitution (< <(...)) to avoid losing variable updates in a pipe subshell
while read -r line
do
    CURRENT_TIME=$(date +%s)

    # Check if 1 second has passed since the last notification
    if (( CURRENT_TIME - LAST_SENT >= 1 ))
    then
        # Find the username of the active graphical session
        ACTIVE_USER=$(who | awk '$2 ~ /seat|:/ {print $1; exit}')

        # Extract the core message to keep the popup clean
        MESSAGE=$(echo "$line" | cut -d' ' -f5-)

        # If a graphical user is logged in, send a desktop notification
        if [ -n "$ACTIVE_USER" ]
        then
            # Get the User ID (UID) to talk to their desktop bus
            USER_ID=$(id -u "$ACTIVE_USER")

            # Trigger notify-send inside the user's graphical environment
            sudo -u "$ACTIVE_USER" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus" \
            notify-send "⚠️ System Error" "$MESSAGE" --urgency=critical -i dialog-error
        else
            # FALLBACK: No graphical session found. Broadcast to all open TTY/Console terminals instead.
            echo -e "\a\n⚠️ SYSTEM ERROR DETECTED ⚠️\n$MESSAGE\n" | wall
        fi

        # Update the timestamp (now works correctly thanks to process substitution)
        LAST_SENT=$CURRENT_TIME
    fi
done < <(journalctl -f --priority=err)  # err or worse (crit, alert, emerg)
