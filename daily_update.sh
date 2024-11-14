#!/bin/bash

# Function to get today's date in YYYY-MM-DD format
get_today() {
    date +%Y-%m-%d
}

# Function to read the last commit date and count
get_last_commit_info() {
    if [ -f "progress.txt" ]; then
        last_date=$(head -n 1 progress.txt)
        current_count=$(tail -n 1 progress.txt)
    else
        last_date="1970-01-01"
        current_count=0
    fi
    echo "$last_date $current_count"
}

# Function to make a single commit
make_commit() {
    local commit_number=$1
    echo "Making commit $commit_number of 28"
    
    # Generate random ASCII art (preserving original functionality)
    IMAGES_DIR="ascii_images"
    if [ -d "$IMAGES_DIR" ]; then
        # Get a random image file from the directory
        IMAGE_FILE=$(ls $IMAGES_DIR/*.txt | shuf -n 1)
        if [ -f "$IMAGE_FILE" ]; then
            cat "$IMAGE_FILE" > output.txt
        fi
    fi
    
    # Update the daily count and progress
    echo $commit_number > daily_count.txt
    echo "$(get_today)" > progress.txt
    echo "$commit_number" >> progress.txt
    
    # Add and commit all tracked files
    git add .
    git commit -m "Daily commit $commit_number/28"
    git push origin main
}

# Main logic
today=$(get_today)
read last_date current_count <<< $(get_last_commit_info)

# If it's a new day, reset the count
if [ "$today" != "$last_date" ]; then
    current_count=0
fi

# Only make a commit if we haven't reached 28 for today
if [ $current_count -lt 28 ]; then
    next_commit=$((current_count + 1))
    make_commit $next_commit
    echo "Successfully made commit $next_commit for $today"
else
    echo "Already reached 28 commits for today ($today)"
fi
