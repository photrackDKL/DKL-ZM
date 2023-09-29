#!/bin/bash

# Sudo run_DKL_pj.sh and write to LOG file

# Variables
DKL_NAME=$(hostname)
LOG_PATH="/home/pt/Desktop/"$DKL_NAME"_LOG.log"


# Run script as root and write all output (also stdout and stderr)to log file
sudo /home/pt/DKL/run_DKL_pj.sh >> $LOG_PATH 2>&1

