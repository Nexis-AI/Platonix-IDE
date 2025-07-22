#!/bin/bash

# Build script for creating Platonix IDE releases locally

VERSION=${1:-"1.0.0"}
PLATFORM=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

echo "🚀 Building Platonix IDE v$VERSION for $PLATFORM-$ARCH"

# Map architecture names
if [ "$ARCH" = "x86_64" ]; then
    ARCH="x64"
elif [ "$ARCH" = "aarch64" ]; then
    ARCH="arm64"
fi

# Map platform names
if [ "$PLATFORM" = "darwin" ]; then
    PLATFORM="darwin"
elif [ "$PLATFORM" = "linux" ]; then
    PLATFORM="linux"
else
    PLATFORM="win32"
fi

# Create dist directory
mkdir -p dist

# Update version
echo "📝 Updating version to $VERSION..."
npm version $VERSION --no-git-tag-version
node -e "const p = require('./product.json'); p.platonixVersion = '$VERSION'; require('fs').writeFileSync('./product.json', JSON.stringify(p, null, 2));"

# Install dependencies
echo "📦 Installing dependencies..."
yarn install --frozen-lockfile

# Build
echo "🔨 Building..."
NODE_ENV=production yarn compile

# Package based on platform
echo "📦 Packaging for $PLATFORM-$ARCH..."

case "$PLATFORM" in
    "linux")
        # Create tarball
        cd ..
        tar -czf platonix-ide-$VERSION-linux-$ARCH.tar.gz platonix-ide \
            --exclude='platonix-ide/.git' \
            --exclude='platonix-ide/node_modules' \
            --exclude='platonix-ide/out-build' \
            --exclude='platonix-ide/out-vscode' \
            --exclude='platonix-ide/.DS_Store'
        mv platonix-ide-$VERSION-linux-$ARCH.tar.gz platonix-ide/dist/
        cd platonix-ide
        echo "✅ Created dist/platonix-ide-$VERSION-linux-$ARCH.tar.gz"
        ;;
        
    "darwin")
        # Create zip for macOS
        zip -r dist/platonix-ide-$VERSION-darwin-$ARCH.zip . \
            -x "*.git*" \
            -x "*node_modules*" \
            -x "*out-build*" \
            -x "*out-vscode*" \
            -x "*.DS_Store"
        echo "✅ Created dist/platonix-ide-$VERSION-darwin-$ARCH.zip"
        ;;
        
    "win32")
        # Create zip for Windows
        powershell -Command "Compress-Archive -Path . -DestinationPath dist/platonix-ide-$VERSION-win32-$ARCH.zip -CompressionLevel Optimal"
        echo "✅ Created dist/platonix-ide-$VERSION-win32-$ARCH.zip"
        ;;
esac

echo ""
echo "🎉 Build complete! Release package is in the dist/ directory."
echo ""
echo "To upload to GitHub Release:"
echo "1. Go to https://github.com/Nexis-AI/Platonix-IDE/releases"
echo "2. Edit the v$VERSION release"
echo "3. Upload the file from dist/"
echo ""