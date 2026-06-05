#!/bin/bash

# ============================================================
# hospital_analysis.sh
# KNH Hospital Analysis Script
# ------------------------------------------------------------
# Member 5 (Clinical Analyst):  process_vitals()
# Member 6 (Facility Auditor):  water_audit()
# ============================================================


# ------------------------------------------------------------
# MEMBER 5 — Clinical Analyst
# ------------------------------------------------------------
process_vitals() {
    echo "=== Processing critical vitals ==="
    mkdir -p reports
    > reports/critical_alerts.txt
    if [ -f active_logs/heart_rate.log ]; then
        grep "CRITICAL" active_logs/heart_rate.log | awk -F ' | ' '{print $1, $2, $3}' >> reports/critical_alerts.txt
        echo "Heart Rate log processed."
    else
        echo "Warning: heart_rate.log not found."
    fi
    if [ -f active_logs/temperature.log ]; then
        grep "CRITICAL" active_logs/temperature.log | awk -F ' | ' '{print $1, $2, $3}' >> reports/critical_alerts.txt
        echo "Temperature log processed."
    else
        echo "Warning: temperature.log not found."
    fi
    echo "Critical alerts saved to reports/critical_alerts.txt"
    echo "Total critical events found: $(wc -l < reports/critical_alerts.txt)"
}


# ------------------------------------------------------------
# MEMBER 6 — Facility Auditor
# ------------------------------------------------------------
water_audit() {
    log_file="active_logs/water_usage.log"
    device="ICU_WATER_RESERVE"
    if [ ! -f "$log_file" ]; then
        echo "ERROR: Water log not found."
        return 1
    fi
    avg=$(awk -F ' \| ' '$2 == "ICU_WATER_RESERVE" { sum += $3; count++ } END { if (count > 0) printf "%.2f", sum/count }' active_logs/water_usage.log)
    echo "=============================="
    echo "   KNH WATER AUDIT REPORT"
    echo "=============================="
    echo "Device    : $device"
    echo "Avg Usage : $avg Liters/min"
    echo "Time      : $(date)"
    echo "=============================="
}


# ------------------------------------------------------------
# Execution
# ------------------------------------------------------------
process_vitals
water_audit
