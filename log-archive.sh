#!/bin/bash

# Function to display usage if no arguments are provided or if an invalid directory is given
usage() {
    echo "Usage: $0 <log-directory>"
    echo "Example: $0 /var/logs"
    exit 1
}

# Check if the user provided a directory argument
if [ -z "$1" ]; then
    usage
fi

LOG_DIR=$1

# Check if the provided directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: The directory '$LOG_DIR' does not exist."
    exit 1
fi

# Define the new directory to store the archive
ARCHIVE_DIR="log_archives"

# Create the archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Get the current date and time for timestamping the archive name
CURRENT_DATE=$(date +"%Y%m%d_%H%M%S")

# Define the name of the archive file
ARCHIVE_NAME="logs_archive_${CURRENT_DATE}.tar.gz"

# Create a tar.gz archive of the log directory
tar -czf "${ARCHIVE_DIR}/${ARCHIVE_NAME}" -C "$LOG_DIR" .

# Log the date and time of the archive creation into a log file
LOG_FILE="archive_creation_log.txt"
echo "Archive created: ${ARCHIVE_NAME} at $(date)" >> "$LOG_FILE"

# Confirm successful completion
echo "Log archive created: ${ARCHIVE_DIR}/${ARCHIVE_NAME}"
echo "Log entry recorded in: $LOG_FILE"
