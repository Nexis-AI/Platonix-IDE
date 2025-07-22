#!/bin/bash

# Exit on error
set -e

# Check platform
platform=$(uname)

if [[ "$platform" == "Darwin" ]]; then
    echo "Running on macOS. Note that the AppImage created will only work on Linux systems."
    if ! command -v docker &> /dev/null; then
        echo "Docker Desktop for Mac is not installed. Please install it from https://www.docker.com/products/docker-desktop"
        exit 1
    fi
elif [[ "$platform" == "Linux" ]]; then
    echo "Running on Linux. Proceeding with AppImage creation..."
else
    echo "This script is intended to run on macOS or Linux. Current platform: $platform"
    exit 1
fi

# Enable BuildKit
export DOCKER_BUILDKIT=1

BUILD_IMAGE_NAME="platonix-appimage-builder"

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running. Please start Docker first."
    exit 1
fi

# Check and install Buildx if needed
if ! docker buildx version >/dev/null 2>&1; then
    echo "Installing Docker Buildx..."
    mkdir -p ~/.docker/cli-plugins/
    curl -SL https://github.com/docker/buildx/releases/download/v0.13.1/buildx-v0.13.1.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
    chmod +x ~/.docker/cli-plugins/docker-buildx
fi

# Download appimagetool if not present
if [ ! -f "appimagetool" ]; then
    echo "Downloading appimagetool..."
    wget -O appimagetool "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
    chmod +x appimagetool
fi

# Delete any existing AppImage to aplatonix bloating the build
rm -f Platonix-x86_64.AppImage

# Create build Dockerfile
echo "Creating build Dockerfile..."
cat > Dockerfile.build << 'EOF'
# syntax=docker/dockerfile:1
FROM ubuntu:20.04

# Install required dependencies
RUN apt-get update && apt-get install -y \
    libfuse2 \
    libglib2.0-0 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxss1 \
    libxtst6 \
    libnss3 \
    libasound2 \
    libdrm2 \
    libgbm1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
EOF

# Create .dockerignore file
echo "Creating .dockerignore file..."
cat > .dockerignore << EOF
Dockerfile.build
.dockerignore
.git
.gitignore
.DS_Store
*~
*.swp
*.swo
*.tmp
*.bak
*.log
*.err
node_modules/
venv/
*.egg-info/
*.tox/
dist/
EOF

# Build Docker image without cache
echo "Building Docker image (no cache)..."
docker build --no-cache -t "$BUILD_IMAGE_NAME" -f Dockerfile.build .

# Create AppImage using local appimagetool
echo "Creating AppImage..."
docker run --rm --privileged -v "$(pwd):/app" "$BUILD_IMAGE_NAME" bash -c '
cd /app && \
rm -rf PlatonixApp.AppDir && \
mkdir -p PlatonixApp.AppDir/usr/bin PlatonixApp.AppDir/usr/lib PlatonixApp.AppDir/usr/share/applications && \
find . -maxdepth 1 ! -name PlatonixApp.AppDir ! -name "." ! -name ".." -exec cp -r {} PlatonixApp.AppDir/usr/bin/ \; && \
cp platonix.png PlatonixApp.AppDir/ && \
echo "[Desktop Entry]" > PlatonixApp.AppDir/platonix.desktop && \
echo "Name=Platonix" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Comment=Open source AI code editor." >> PlatonixApp.AppDir/platonix.desktop && \
echo "GenericName=Text Editor" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Exec=platonix %F" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Icon=platonix" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Type=Application" >> PlatonixApp.AppDir/platonix.desktop && \
echo "StartupNotify=false" >> PlatonixApp.AppDir/platonix.desktop && \
echo "StartupWMClass=Platonix" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Categories=TextEditor;Development;IDE;" >> PlatonixApp.AppDir/platonix.desktop && \
echo "MimeType=application/x-platonix-workspace;" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Keywords=platonix;" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Actions=new-empty-window;" >> PlatonixApp.AppDir/platonix.desktop && \
echo "[Desktop Action new-empty-window]" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name=New Empty Window" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name[de]=Neues leeres Fenster" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name[es]=Nueva ventana vacía" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name[fr]=Nouvelle fenêtre vide" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name[it]=Nuova finestra vuota" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name[ja]=新しい空のウィンドウ" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name[ko]=새 빈 창" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name[ru]=Новое пустое окно" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name[zh_CN]=新建空窗口" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Name[zh_TW]=開新空視窗" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Exec=platonix --new-window %F" >> PlatonixApp.AppDir/platonix.desktop && \
echo "Icon=platonix" >> PlatonixApp.AppDir/platonix.desktop && \
chmod +x PlatonixApp.AppDir/platonix.desktop && \
cp PlatonixApp.AppDir/platonix.desktop PlatonixApp.AppDir/usr/share/applications/ && \
echo "[Desktop Entry]" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "Name=Platonix - URL Handler" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "Comment=Open source AI code editor." > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "GenericName=Text Editor" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "Exec=platonix --open-url %U" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "Icon=platonix" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "Type=Application" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "NoDisplay=true" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "StartupNotify=true" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "Categories=Utility;TextEditor;Development;IDE;" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "MimeType=x-scheme-handler/platonix;" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
echo "Keywords=platonix;" > PlatonixApp.AppDir/platonix-url-handler.desktop && \
chmod +x PlatonixApp.AppDir/platonix-url-handler.desktop && \
cp PlatonixApp.AppDir/platonix-url-handler.desktop PlatonixApp.AppDir/usr/share/applications/ && \
echo "#!/bin/bash" > PlatonixApp.AppDir/AppRun && \
echo "HERE=\$(dirname \"\$(readlink -f \"\${0}\")\")" >> PlatonixApp.AppDir/AppRun && \
echo "export PATH=\${HERE}/usr/bin:\${PATH}" >> PlatonixApp.AppDir/AppRun && \
echo "export LD_LIBRARY_PATH=\${HERE}/usr/lib:\${LD_LIBRARY_PATH}" >> PlatonixApp.AppDir/AppRun && \
echo "exec \${HERE}/usr/bin/platonix --no-sandbox \"\$@\"" >> PlatonixApp.AppDir/AppRun && \
chmod +x PlatonixApp.AppDir/AppRun && \
chmod -R 755 PlatonixApp.AppDir && \

# Strip unneeded symbols from the binary to reduce size
strip --strip-unneeded PlatonixApp.AppDir/usr/bin/platonix

ls -la PlatonixApp.AppDir/ && \
ARCH=x86_64 ./appimagetool -n PlatonixApp.AppDir Platonix-x86_64.AppImage
'

# Clean up
rm -rf PlatonixApp.AppDir .dockerignore appimagetool

echo "AppImage creation complete! Your AppImage is: Platonix-x86_64.AppImage"
