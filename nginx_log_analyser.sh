#!/bin/bash

# Function to display top N entries for different categories
top_5() {
            echo "$1"
                echo "$2" | sort | uniq -c | sort -nr | head -5
                    echo ""
            }

            # Check if the log file argument is provided
            if [ -z "$1" ]; then
                        echo "Usage: $0 <log-file>"
                            exit 1
            fi

            # Assign the log file from the argument
            LOG_FILE="$1"

            # Check if the log file exists
            if [ ! -f "$LOG_FILE" ]; then
                        echo "Error: Log file '$LOG_FILE' does not exist."
                            exit 1
            fi

            # 1. Top 5 IP addresses with the most requests
            top_5 "Top 5 IP addresses with the most requests:" "$(grep -o '^[^ ]*' "$LOG_FILE")"

            # 2. Top 5 most requested paths
            top_5 "Top 5 most requested paths:" "$(grep -oP '(?<=GET )\/[^\s]*' "$LOG_FILE")"

            # 3. Top 5 response status codes
            top_5 "Top 5 response status codes:" "$(grep -oP 'HTTP\/[0-9\.]+" \K[0-9]{3}' "$LOG_FILE")"

            # 4. Top 5 user agents
            top_5 "Top 5 user agents:" "$(grep -oP '"([^"]*)"$' "$LOG_FILE" | sed 's/"//g')"
