#!/bin/bash

ES_URL="http://localhost:9200/_bulk"

for file in bulk_data_*.json; do
  echo "🚀 Sending $file..."
  curl -s -X POST "$ES_URL" \
    -H "Content-Type: application/x-ndjson" \
    --data-binary @"$file"

  echo "✅ Done: $file"
done
