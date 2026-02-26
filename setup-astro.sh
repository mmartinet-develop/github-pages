#!/bin/bash

# Astro + Starlight setup script
# Interactive installation of all dependencies

set -e

echo "🚀 Setting up Astro + Starlight documentation environment..."
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is required but not installed."
    echo "👉 Install from: https://nodejs.org/ (v20+)"
    exit 1
fi

NODE_VERSION=$(node -v)
echo "✓ Node.js found: $NODE_VERSION"

# Install npm dependencies
echo ""
echo "📦 Installing npm dependencies..."
npm install

# Install PlantUML
echo ""
echo "📊 Installing PlantUML (optional but recommended)..."

if command -v brew &> /dev/null; then
    echo "  Using Homebrew..."
    brew install plantuml
    echo "  ✓ PlantUML installed"
elif command -v apt-get &> /dev/null; then
    echo "  Using apt-get..."
    sudo apt-get update
    sudo apt-get install -y plantuml
    echo "  ✓ PlantUML installed"
else
    echo "  ⚠️  Could not auto-install PlantUML"
    echo "  👉 Install from: https://plantuml.com/download"
fi

# Install DrawIO CLI
echo ""
echo "📐 Installing DrawIO CLI (optional but recommended)..."

if command -v npm &> /dev/null; then
    npm install -g @drawio/cli
    echo "  ✓ DrawIO CLI installed"
else
    echo "  ⚠️  npm not found. DrawIO CLI installation skipped."
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Add your .puml and .drawio diagrams to 'diagrams/' folder"
echo "  2. Edit pages in 'src/content/docs/' folder"
echo "  3. Run: npm run dev"
echo "  4. Visit: http://localhost:3000"
echo ""
echo "To build for production:"
echo "  npm run build:diagrams"
echo "  npm run build"
echo ""
