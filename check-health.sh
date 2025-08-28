#!/bin/bash

CONTAINER="$1"

if [ -z "$CONTAINER" ]; then
  echo "❌ Bitte Container-Namen angeben!"
  echo "Usage: ./check-health.sh <container-name>"
  exit 1
fi

HEALTH=$(docker inspect --format='{{json .State.Health}}' "$CONTAINER" | jq)

STATUS=$(echo "$HEALTH" | jq -r '.Status')
FAILING=$(echo "$HEALTH" | jq -r '.FailingStreak')
LAST_CHECK=$(echo "$HEALTH" | jq -r '.Log[-1].End')
LAST_OUTPUT=$(echo "$HEALTH" | jq -r '.Log[-1].Output' | tail -n1)

echo "🩺 Health Status für '$CONTAINER'"
echo "----------------------------------"
echo "Status:         $STATUS"
echo "Failing Streak: $FAILING"
echo "Last Checked:   $LAST_CHECK"
echo "Output:         $LAST_OUTPUT"
