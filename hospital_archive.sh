#!/bin/bash

# Member 4 - The Archivist
# Rotates logs from active_logs to archived_logs with a timestamp

rotate_logs() {
    # Generate timestamp (e.g., 20260124_1200)
    TIMESTAMP=$(date +"%Y%m%d_%H%M")

    echo "Starting log rotation at $TIMESTAMP..."

    # List of log files to rotate
    LOG_FILES=("heart_rate.log" "temperature.log" "water_usage.log")

    for LOG in "${LOG_FILES[@]}"; do
        SOURCE="active_logs/$LOG"
        FILENAME="${LOG%.log}_${TIMESTAMP}.log"
        DEST="archived_logs/$FILENAME"

        if [ -f "$SOURCE" ]; then
            mv "$SOURCE" "$DEST"
            echo "Archived: $LOG → $FILENAME"
            touch "$SOURCE"
            echo "Recreated empty: $SOURCE"
        else
            echo "Warning: $SOURCE not found, skipping."
        fi
    done

    echo "Log rotation complete."
}

# Run the function
rotate_logs
