#!/bin/bash

# Liste deiner Images (lokal gebaut oder aus Registry)
IMAGES=(
  "myapp:latest"
    "myapp:slim-container"
    "myapp:alpine-slim"
    "myapp:distroless-image"
    "myapp:secure-slim-final"
)

echo "📦 Vergleich der Image-Größen:"
echo "-------------------------------"

for IMAGE in "${IMAGES[@]}"; do
  SIZE=$(docker image inspect "$IMAGE" --format='{{.Size}}' 2>/dev/null)

  if [ -z "$SIZE" ]; then
    echo "🔸 $IMAGE → [Image nicht gefunden]"
  else
    SIZE_MB=$(echo "scale=2; $SIZE / 1024 / 1024" | bc)
    echo "🔹 $IMAGE → ${SIZE_MB} MB"
  fi
done




# as json
##!/bin/bash
#
#IMAGES=(
#  "myapp:latest"
#  "myapp:slim-container"
#  "myapp:distroless-image"
#  "myapp:secure-slim-final"
#)
#
#echo "{" > image-sizes.json
#
#for IMAGE in "${IMAGES[@]}"; do
#  SIZE=$(docker image inspect "$IMAGE" --format='{{.Size}}' 2>/dev/null)
#
#  if [ -z "$SIZE" ]; then
#    echo "  \"$IMAGE\": null," >> image-sizes.json
#  else
#    SIZE_MB=$(echo "scale=2; $SIZE / 1024 / 1024" | bc)
#    echo "  \"$IMAGE\": $SIZE_MB," >> image-sizes.json
#  fi
#done
#
## Letztes Komma entfernen & JSON schließen
#sed -i '$ s/,$//' image-sizes.json
#echo "}" >> image-sizes.json

