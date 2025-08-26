#!/bin/bash
echo "📦 Vergleich der Image-Größen:"
echo "-------------------------------"

for variant in openjdk-slim eclipse-temurin eclipse-temurin-alpine distroless bestpractices secure-final; do
  if docker image inspect "myimage:$variant" > /dev/null 2>&1; then
    size=$(docker image inspect "myimage:$variant" --format='{{.Size}}')
    mb=$(echo "scale=2; $size / 1024 / 1024" | bc)
    echo "🔹 myimage:$variant → ${mb} MB"
  else
    echo "🔸 myimage:$variant → [Image nicht gefunden]"
  fi
done

echo "-------------------------------"
