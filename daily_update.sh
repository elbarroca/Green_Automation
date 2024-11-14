#!/bin/bash

# Configuration
IMAGES_DIR="ascii_images"
OUTPUT_FILE="output.txt"
PROGRESS_FILE="progress.txt"
DAILY_COUNT_FILE="daily_count.txt"
MAX_DAILY_COMMITS=10

# Initialize progress file if it doesn't exist
if [ ! -f "$PROGRESS_FILE" ]; then
    echo "1 1" > "$PROGRESS_FILE"  # Format: <image_number> <line_number>
fi

# Initialize daily count file if it doesn't exist
if [ ! -f "$DAILY_COUNT_FILE" ]; then
    echo "0" > "$DAILY_COUNT_FILE"
fi

# Read current progress
read current_image current_line < "$PROGRESS_FILE"
daily_count=$(cat "$DAILY_COUNT_FILE")

# Get current image file
image_file="${IMAGES_DIR}/image${current_image}.txt"

# Check if image file exists
if [ ! -f "$image_file" ]; then
    echo "Starting over from image1.txt"
    current_image=1
    current_line=1
    image_file="${IMAGES_DIR}/image${current_image}.txt"
fi

# Get total lines in current image
total_lines=$(wc -l < "$image_file")

# Add next line to output file
sed -n "${current_line}p" "$image_file" >> "$OUTPUT_FILE"

# Update progress
if [ "$current_line" -ge "$total_lines" ]; then
    # Move to next image
    current_image=$((current_image + 1))
    current_line=1
else
    # Move to next line
    current_line=$((current_line + 1))
fi

# Update progress file
echo "$current_image $current_line" > "$PROGRESS_FILE"

# Update daily commit count
daily_count=$((daily_count + 1))
echo "$daily_count" > "$DAILY_COUNT_FILE"

# Git operations
git add "$OUTPUT_FILE"
git commit -m "🌿 Day's growth: Line $current_line of Image $current_image"
git push origin main

# Reset daily count if we've reached max commits
if [ "$daily_count" -ge "$MAX_DAILY_COMMITS" ]; then
    echo "0" > "$DAILY_COUNT_FILE"
fi
