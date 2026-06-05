#!/bin/bash
process_vitals() {
    echo "=== Processing critical vitals ==="
    mkdir -p reports 
    > reports/critical_alerts.txt
    if [ -f active_logs/heart_rate.log ]; then
    grep "CRITICAL" active_logs/heart_rate.log | awk ' {print $1, $2, $3}' >> reports/critical_alerts.txt
    echo "Heart Rate log processed."
    else
        echo "Warning: heart_rate.log not found."
        fi
        if [ -f active_logs/temperature.log ]; then
        grep "CRITICAL" active_logs/temperature.log | awk ' {print $1, $2, $3}' >> reports/critical_alerts.txt
        echo "Temperature log processed."
        else
        echo "Warning: temperature.log not found."
        fi
        echo "Critical alerts saved to reports/critical_alerts.txt"
        echo "Total critical events found: $(wc -l < reports/critical_alerts.txt)"
}
process_vitals