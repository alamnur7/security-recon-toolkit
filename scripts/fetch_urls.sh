#!/bin/bash


TARGET=$1
OUTPUT_DIR=$2


if [ -z "$TARGET" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Usage: ./fetch_urls.sh <target-domain> <output-directory>"
    exit 1
fi


mkdir -p "$OUTPUT_DIR"


echo "[+] Fetching historical URLs for: $TARGET"


# Harvesting URLs using waybackurls and gau
waybackurls "$TARGET" | tee "$OUTPUT_DIR/wayback_urls.txt"
gau "$TARGET" | tee -a "$OUTPUT_DIR/wayback_urls.txt"


# Sort and remove duplicates
sort -u "$OUTPUT_DIR/wayback_urls.txt" -o "$OUTPUT_DIR/all_unique_urls.txt"


echo "[+] Unique endpoints saved to $OUTPUT_DIR/all_unique_urls.txt"