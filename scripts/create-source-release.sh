#!/bin/bash

# Create source release archives for Platonix IDE

VERSION=${1:-"1.0.1"}
echo "📦 Creating Platonix IDE v$VERSION source archives..."

# Create dist directory
mkdir -p dist

# Create a temporary directory for clean source
TEMP_DIR=$(mktemp -d)
echo "📂 Using temp directory: $TEMP_DIR"

# Copy source files (excluding unnecessary files)
echo "📋 Copying source files..."
rsync -av --progress . "$TEMP_DIR/platonix-ide/" \
  --exclude='.git' \
  --exclude='node_modules' \
  --exclude='out-*' \
  --exclude='dist' \
  --exclude='.DS_Store' \
  --exclude='*.log' \
  --exclude='.vscode-test'

# Create archives
cd "$TEMP_DIR"

echo "🗜️ Creating Windows ZIP..."
zip -r platonix-ide-${VERSION}-windows-source.zip platonix-ide/ -q

echo "🗜️ Creating macOS archive..."
tar -czf platonix-ide-${VERSION}-macos-source.tar.gz platonix-ide/

echo "🗜️ Creating Linux archive..."
tar -czf platonix-ide-${VERSION}-linux-source.tar.gz platonix-ide/

# Move archives back
cd - > /dev/null
mv "$TEMP_DIR"/*.zip "$TEMP_DIR"/*.tar.gz dist/

# Cleanup
rm -rf "$TEMP_DIR"

# Show results
echo ""
echo "✅ Release archives created in dist/:"
ls -lh dist/
echo ""
echo "📤 These files are ready to upload to GitHub Releases!"
echo ""
echo "To upload:"
echo "1. Go to https://github.com/Nexis-AI/Platonix-IDE/releases/new"
echo "2. Choose tag: v$VERSION"
echo "3. Upload these files from dist/"
echo "4. Publish the release"