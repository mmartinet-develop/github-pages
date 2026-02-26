#!/bin/bash

# Installation helper script
# Usage: ./setup.sh

echo "🚀 Setting up documentation environment..."

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 is required but not installed."
    exit 1
fi

echo "✓ Python found"

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip install -r requirements.txt

# Install PlantUML
echo "📊 Installing PlantUML..."
if command -v brew &> /dev/null; then
    brew install plantuml
else
    echo "⚠️  Please install PlantUML manually"
    echo "  Linux: sudo apt-get install plantuml"
    echo "  macOS: brew install plantuml"
    echo "  Or download from: https://plantuml.com/download"
fi

# Install DrawIO CLI
echo "📐 Installing DrawIO CLI..."
if command -v npm &> /dev/null; then
    npm install -g @jgraph/drawio-desktop-launcher
else
    echo "⚠️  Node.js/npm not found. Install from: https://nodejs.org/"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Add your documentation in docs/ folder"
echo "  2. Run './build-docs.sh' to build locally"
echo "  3. Run 'mkdocs serve' to preview in browser"
echo "  4. Push to main branch to auto-deploy"
