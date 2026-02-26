#!/bin/bash

# Script local de build pour tester la documentation en local
# Usage: ./build-docs.sh

set -e

echo "🔨 Building documentation locally..."

# Créer le répertoire assets
mkdir -p docs/assets/diagrams

# Vérifier si plantuml est installé
if ! command -v plantuml &> /dev/null; then
    echo "⚠️  PlantUML not found. Install with: brew install plantuml"
    exit 1
fi

# Vérifier si drawio est installé
if ! command -v drawio &> /dev/null; then
    echo "⚠️  DrawIO CLI not found. Install with: npm install -g @drawio/cli"
fi

# Convertir PlantUML
echo "📊 Converting PlantUML diagrams..."
find docs -name "*.puml" -type f | while read file; do
    output_dir="docs/assets/diagrams"
    filename=$(basename "$file" .puml)
    echo "  → $filename"
    plantuml -Tsvg -o "$output_dir" "$file"
done

# Convertir DrawIO (optionnel)
echo "📐 Converting DrawIO diagrams..."
if command -v drawio &> /dev/null; then
    find docs -name "*.drawio" -type f | while read file; do
        output_dir="docs/assets/diagrams"
        filename=$(basename "$file" .drawio)
        echo "  → $filename"
        drawio -x -f svg -o "$output_dir/$filename.svg" "$file"
    done
else
    echo "  ⚠️  drawio-desktop-launcher not installed"
fi

# Générer le site MkDocs
echo "🔨 Building MkDocs site..."
mkdocs build

echo "✅ Build complete! Documentation available at: ./site/index.html"
echo ""
echo "To serve locally:"
echo "  mkdocs serve"
