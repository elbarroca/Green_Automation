#!/bin/bash

# Configurations
REPO_PATH="$(pwd)"
ASCII_FOLDER="$REPO_PATH/ascii_images"
OUTPUT_FILE="$REPO_PATH/output.txt"
PROGRESS_FILE="$REPO_PATH/progress.txt"
DAILY_COUNT_FILE="$REPO_PATH/daily_count.txt"
COMPLETED_FOLDER="$REPO_PATH/completed_images"
GIT_USERNAME="elbarroca"
GIT_EMAIL="btcto154k@gmail.com"
GIT_REPO_URL="https://github.com/elbarroca/Green_Automacion.git"

# Create completed_images folder if it doesn't exist
mkdir -p "$COMPLETED_FOLDER"

# Initialize Git if needed
if [ ! -d .git ]; then
    git init
    git config user.name "$GIT_USERNAME"
    git config user.email "$GIT_EMAIL"
fi

# Initialize or read daily count
if [[ ! -f $DAILY_COUNT_FILE ]]; then
    echo "0" > $DAILY_COUNT_FILE
fi
DAILY_COUNT=$(cat $DAILY_COUNT_FILE)

# Check if we've hit the daily limit (10 commits)
if [[ $DAILY_COUNT -ge 10 ]]; then
    current_date=$(date +%Y-%m-%d)
    last_update_date=$(git log -1 --format=%cd --date=short)
    
    # If it's a new day, reset the counter
    if [[ "$current_date" != "$last_update_date" ]]; then
        echo "0" > $DAILY_COUNT_FILE
        DAILY_COUNT=0
    else
        echo "Daily limit reached. Exiting."
        exit 0
    fi
fi

# Check if progress file exists, if not, start from image 11, line 1
if [[ ! -f $PROGRESS_FILE ]]; then
    echo "11 1" > $PROGRESS_FILE
fi

# Read the current image and line number
read CURRENT_IMAGE CURRENT_LINE < $PROGRESS_FILE

# Path to the current image file
IMAGE_FILE="$ASCII_FOLDER/image${CURRENT_IMAGE}.txt"

# Check if the image file exists
if [[ -f $IMAGE_FILE ]]; then
    # Get the specific line from the current image
    LINE_CONTENT=$(sed -n "${CURRENT_LINE}p" "$IMAGE_FILE")

    # Append the line to the output file
    echo "$LINE_CONTENT" >> "$OUTPUT_FILE"

    # Stage changes
    git add "$OUTPUT_FILE"
    git add "$PROGRESS_FILE"
    git add "$DAILY_COUNT_FILE"

    # Increment and save daily count
    DAILY_COUNT=$((DAILY_COUNT + 1))
    echo $DAILY_COUNT > $DAILY_COUNT_FILE

    # Commit and push changes
    git commit -m "Day $(date +%j)/365: Appending line $CURRENT_LINE of image $CURRENT_IMAGE (Commit $DAILY_COUNT/10)"
    git push origin main || git push origin master

    # Prepare for the next line or next image
    TOTAL_LINES=$(wc -l < "$IMAGE_FILE")
    if [[ $CURRENT_LINE -lt $TOTAL_LINES ]]; then
        # Move to the next line
        NEXT_LINE=$((CURRENT_LINE + 1))
        echo "$CURRENT_IMAGE $NEXT_LINE" > $PROGRESS_FILE
    else
        # Image is complete, move it to completed folder
        TIMESTAMP=$(date +%Y%m%d_%H%M%S)
        cp "$OUTPUT_FILE" "$COMPLETED_FOLDER/completed_image${CURRENT_IMAGE}_${TIMESTAMP}.txt"
        
        # Move to the next image
        NEXT_IMAGE=$((CURRENT_IMAGE + 1))
        echo "$NEXT_IMAGE 1" > $PROGRESS_FILE
        
        # Clear output.txt for the next image
        echo "" > "$OUTPUT_FILE"
        
        # Create completion marker
        echo "Image $CURRENT_IMAGE completed on $(date)" >> "$COMPLETED_FOLDER/completion_log.txt"
        
        # Stage and commit completion
        git add "$COMPLETED_FOLDER"
        git commit -m "Completed image $CURRENT_IMAGE and starting image $NEXT_IMAGE"
        git push origin main || git push origin master
    fi
else
    echo "Image file $IMAGE_FILE not found. Please check the file and try again."
    exit 1
fi
