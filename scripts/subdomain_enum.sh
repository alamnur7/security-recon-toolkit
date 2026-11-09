#!/bin/bash


# Target domain input
TARGET=$1
OUTPUT_DIR=$2


if [ -z "$TARGET" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Usage: ./subdomain_enum.sh <target-domain> <output-directory>"
    exit 1
fi


mkdir -p "$OUTPUT_DIR"


echo "[+] Starting subdomain enumeration for: $TARGET"


# Run subfinder for passive discovery
subfinder -d "$TARGET" -silent -o "$OUTPUT_DIR/subdomains.txt"


echo "[+] Subdomains found. Running HTTP status verification..."


# Verify active hosts using httpx
cat "$OUTPUT_DIR/subdomains.txt" | httpx -silent -status-code -title -o "$OUTPUT_DIR/active_hosts.txt"


echo "[+] Recon completed. Results saved in $OUTPUT_DIR/"