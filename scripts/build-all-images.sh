#!/bin/bash

for file in dockerfiles/Dockerfile.*; do
    variant=$(basename "$file" | cut -d. -f2)
    echo "-----------------------------"
    echo "🔧 Building variant: $variant"
    echo "-----------------------------"
    docker build -f "$file" -t "myimage:$variant" .
done
