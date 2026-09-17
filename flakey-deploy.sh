#!/bin/sh
echo "Attempting deploy..."
sleep 10

RESULT=$(awk 'BEGIN{srand(); print (rand() < 0.05) ? "success" : "fail"}')

if [ "$RESULT" = "success" ]; then
    echo "Deploy succeeded"
    exit 0
else
    echo "Deploy failed"
    exit 1
fi
