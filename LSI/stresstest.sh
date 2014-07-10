#!/bin/bash

# Check for root to run
if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root"
        echo "Ex. "sudo "$0"
        exit 1
fi

# Full path to the MegaRaid CLI binary
# System detects if it is in path or else in common locations.
# Can be overridden by setting MegaCli manually

if hash MegaCli 2>/dev/null; then
        MegaCli="MegaCli64"
        elif hash MegaCli64 2>/dev/null; then
                MegaCli="MegaCli"
        elif hash /opt/MegaRAID/MegaCli/MegaCli64 2>/dev/null; then
                MegaCli="/opt/MegaRAID/MegaCli/MegaCli64"
        elif hash /opt/MegaRAID/MegaCli/MegaCli 2>/dev/null; then
                MegaCli="/opt/MegaRAID/MegaCli/MegaCli"
        else
                echo "MegaCli not found in path or standard locations"
    fi
#MegaCli="/usr/local/sbin/MegaCli64"


# Starts a patrol read on all drives attached to arrays
$MegaCli -AdpPR -Start -aALL


# Starts a check for badblocks using read and DESTRUCTIVE write
badblocks -p 100 -v -w /dev/sdb
