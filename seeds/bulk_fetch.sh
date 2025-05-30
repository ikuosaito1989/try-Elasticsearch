#!/bin/bash

FROM=1
LIMIT=10000
INDEX=1
TO=10000

while true; do
  FILENAME="bulk_data_${INDEX}.json"
  echo "📦 Fetching from=${FROM} to=${TO} → $FILENAME"

  RESPONSE=$(curl -s -H "Accept: application/json" "http://localhost:5001/v1/cars/elasticsearch?from=${FROM}&to=${TO}")

  # 空データ判定（空配列、空文字、空オブジェクトなど）
  if [ -z "$RESPONSE" ] || [ "$RESPONSE" = "[]" ] || [ "$RESPONSE" = "{}" ]; then
    echo "✅ Empty response detected. Done."
    break
  fi

  echo "$RESPONSE" | jq -c . > "$FILENAME"
  echo "✅ Saved $FILENAME"

  FROM=$((FROM + LIMIT))
  INDEX=$((INDEX + 1))
  TO=$((LIMIT * INDEX))

  # 必要なら少し待つ（サーバー負荷対策）
  # sleep 1
done
