#!/bin/bash

# Array of concurrency levels
CONCURRENCIES=(10 25 50 100)

# Duration of each test
DURATION="1M"

# Docker image for Siege
SIEGE_IMAGE="jstarcher/siege"

# Output file for Siege logs
OUTPUT_FILE="siege_output.txt"

# Check if urls.txt exists
if [ ! -f "urls.txt" ]; then
    echo "The file urls.txt was not found. Please create the file with the necessary URLs."
    exit 1
fi

# Clear or create the output file
echo "Siege Test Logs" > "$OUTPUT_FILE"
echo "================" >> "$OUTPUT_FILE"

# Run Siege
run_siege() {
    local concurrency=$1
    echo "Running Siege with concurrency: $concurrency"
    echo "Concurrency: $concurrency" >> "$OUTPUT_FILE"
    echo "--------------------------" >> "$OUTPUT_FILE"

    # Run Siege and append logs to the file (stdout and stderr)
    docker run --rm --platform linux/amd64 -v "$(pwd)":/usr/src/siege $SIEGE_IMAGE -f /usr/src/siege/urls.txt -c$concurrency -t$DURATION >> "$OUTPUT_FILE" 2>&1

    echo "" >> "$OUTPUT_FILE"
    echo "Test with concurrency $concurrency completed."
    echo "---------------------------------------------"
}

# Run tests for each concurrency level
for C in "${CONCURRENCIES[@]}"; do
    run_siege $C
done

# Remove some log lines from the output file
sed -i '' '/HTTP\/1\.1 201/d' "$OUTPUT_FILE"
sed -i '' '/host\.docker\.internal/d' "$OUTPUT_FILE"
sed -i '' '/New configuration template added/d' "$OUTPUT_FILE"
sed -i '' '/view the current settings/d' "$OUTPUT_FILE"
sed -i '' '/server/d' "$OUTPUT_FILE"

echo "All tests completed. Logs saved to $OUTPUT_FILE."