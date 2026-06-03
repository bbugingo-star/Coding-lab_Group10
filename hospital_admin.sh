#!/bin/bash

# ============================================================
# hospital_admin.sh
# KNH Hospital Administration Script
# ------------------------------------------------------------
# Member 1 (The Architect):     initialize_system()
# Member 2 (The Security Lead): secure_data()
# Member 3 (The Orchestrator):  Execution logic
# ============================================================


# ------------------------------------------------------------
# MEMBER 1 — The Architect
# Function: initialize_system()
#
# What this function does:
#   It checks if the 3 required folders exist.
#   If a folder is missing, it creates it.
#   It prints a message for every step so you can see what is happening.
# ------------------------------------------------------------
initialize_system() {

    echo "============================================"
    echo "   KNH System Initialization"
    echo "============================================"

    # --- Check folder 1: active_logs ---
    # The -d flag means "is this a directory?"
    if [ -d "active_logs" ]; then
        echo "[OK] active_logs folder already exists."
    else
        echo "active_logs folder not found. Creating it now..."
        mkdir active_logs
        echo "[CREATED] active_logs folder has been created."
    fi

    # --- Check folder 2: archived_logs ---
    if [ -d "archived_logs" ]; then
        echo "[OK] archived_logs folder already exists."
    else
        echo "archived_logs folder not found. Creating it now..."
        mkdir archived_logs
        echo "[CREATED] archived_logs folder has been created."
    fi

    # --- Check folder 3: reports ---
    if [ -d "reports" ]; then
        echo "[OK] reports folder already exists."
    else
        echo "reports folder not found. Creating it now..."
        mkdir reports
        echo "[CREATED] reports folder has been created."
    fi

    echo "--------------------------------------------"
    echo "   All folders are ready."
    echo "============================================"
    echo ""

}


# ------------------------------------------------------------
# MEMBER 2 — The Security Lead
# Function: secure_data()
# Placeholder — to be implemented by Member 2
# ------------------------------------------------------------
secure_data() { 


    echo "Securing active_logs directory..."
    # Restrict access to owner only
    chmod 600 active_logs

    echo "Current permissions:"
    # Display updated permissions
    ls -ld active_logs

}


# ------------------------------------------------------------
# MEMBER 3 — The Orchestrator
# Execution logic — to be implemented by Member 3
# ------------------------------------------------------------
# Placeholder call for now
initialize_system
