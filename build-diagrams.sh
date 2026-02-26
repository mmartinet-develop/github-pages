#!/bin/bash

# Build script for PlantUML and DrawIO diagrams
# Converts .puml and .drawio files to SVG

set -e

echo "🔨 Building diagrams..."

# Create output directory
mkdir -p src/assets/diagrams

# Check if diagram source directory exists
if [ ! -d "diagrams" ]; then
    echo "⚠️  No diagrams/ directory found. Creating one..."
    mkdir -p diagrams
fi

# Convert PlantUML files
echo "📊 Converting PlantUML diagrams..."
if command -v plantuml &> /dev/null; then
    find diagrams -name "*.puml" -type f | while read file; do
        filename=$(basename "$file" .puml)
        echo "  → $filename"
        plantuml -Tsvg -o src/assets/diagrams "$file" 2>/dev/null || echo "    ⚠️  Could not process $file"
    done
else
    echo "  ⚠️  plantuml not found. Install with: brew install plantuml"
fi

# Convert DrawIO files
echo "📐 Converting DrawIO diagrams..."
if command -v drawio &> /dev/null; then
    find diagrams -name "*.drawio" -type f | while read file; do
        filename=$(basename "$file" .drawio)
        echo "  → $filename"
        drawio -x -f svg -o "src/assets/diagrams/$filename.svg" "$file" 2>/dev/null || echo "    ⚠️  Could not process $file"
    done
else
    echo "  ⚠️  drawio-desktop-launcher not found"
fi

echo "✅ Diagrams built!"
