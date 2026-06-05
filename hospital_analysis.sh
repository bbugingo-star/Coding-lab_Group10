#!/bin/bash

water_audit() {
    log_file="active_logs/water_usage.log"
    device="ICU_WATER_RESERVE"

    if [ ! -f "$log_file" ]; then
        echo "ERROR: Water log not found."
        return 1
    fi

    avg=$(awk -F ' \\| ' '$2 == "ICU_WATER_RESERVE" { sum += $3; count++ } END { if (count > 0) printf "%.2f", sum/count }' active_logs/water_usage.log)

    echo "=============================="
    echo "   KNH WATER AUDIT REPORT"
    echo "=============================="
    echo "Device    : $device"
    echo "Avg Usage : $avg Liters/min"
    echo "Time      : $(date)"
    echo "=============================="
}

water_audit
