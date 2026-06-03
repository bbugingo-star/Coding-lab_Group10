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
# Function: process_vitals()
# Placeholder — to be implemented by Member 5
# ------------------------------------------------------------
process_vitals() {
    echo "[INFO] process_vitals() — awaiting Member 5 implementation."
}


# ------------------------------------------------------------
# MEMBER 6 — Facility Auditor
# Function: water_audit()
#
# What this function does:
#   It reads the water usage log file.
#   It finds all rows that belong to ICU_WATER_RESERVE.
#   It adds up all the usage values and counts how many rows there are.
#   It divides the total by the count to get the average.
#   It prints a neat summary to the screen.
# ------------------------------------------------------------
water_audit() {

    echo "============================================"
    echo "   KNH Facility Water Audit"
    echo "   Device: ICU_WATER_RESERVE"
    echo "============================================"

    # --- Step 1: Make sure the reports folder exists ---
    if [ ! -d "reports" ]; then
        echo "[ERROR] The reports folder does not exist."
        echo "        Please run hospital_admin.sh first."
        exit 1
    fi

    # --- Step 2: Make sure the water log file exists ---
    if [ ! -f "active_logs/water_usage.log" ]; then
        echo "[ERROR] Water usage log not found."
        echo "        Make sure the hospital engine is running."
        exit 1
    fi

    # --- Step 3: Check the file is not empty ---
    if [ ! -s "active_logs/water_usage.log" ]; then
        # -s means "does this file have content in it?"
        echo "[WARN] Water usage log is empty. No data to analyse."
        exit 0
    fi

    # --- Step 4: Use awk to calculate the average for ICU_WATER_RESERVE ---
    #
    # How this awk command works:
    #   -F','         : columns are separated by commas
    #   NR == 1       : NR is the row number. Row 1 is the header, so we skip it.
    #   $2 == "ICU_WATER_RESERVE" : only look at rows for this device
    #   total += $3   : add the value in column 3 to a running total
    #   count++       : count how many rows we have found
    #   END           : this block runs after all rows have been read
    #   total / count : divide to get the average

    AVERAGE=$(awk -F',' '
        NR == 1 { next }
        $2 == "ICU_WATER_RESERVE" {
            total = total + $3
            count = count + 1
        }
        END {
            if (count == 0) {
                print "NO_DATA"
            } else {
                printf "%.2f", total / count
            }
        }
    ' active_logs/water_usage.log)

    # --- Step 5: Check if any rows were found ---
    if [ "$AVERAGE" = "NO_DATA" ]; then
        echo "[WARN] No rows found for ICU_WATER_RESERVE in the log."
        exit 0
    fi

    # --- Step 6: Print the formatted summary ---
    # printf lets us line things up neatly
    # %-20s means: left-align text in a space 20 characters wide
    echo ""
    printf "  %-20s : %s\n"   "Device"        "ICU_WATER_RESERVE"
    printf "  %-20s : %s\n"   "Log File"       "active_logs/water_usage.log"
    printf "  %-20s : %s L\n" "Average Usage"  "$AVERAGE"
    echo ""
    echo "--------------------------------------------"
    echo "   Water Audit Complete: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "============================================"
    echo ""

}


# ------------------------------------------------------------
# Execution — run both functions one after the other
# ------------------------------------------------------------
process_vitals
water_audit
