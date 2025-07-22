# Platonix IDE Deployment Guide

This guide covers how to build, package, and deploy Platonix IDE for distribution.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Building from Source](#building-from-source)
3. [Creating Releases](#creating-releases)
4. [Automated Deployment](#automated-deployment)
5. [Distribution Channels](#distribution-channels)

## Prerequisites

### Required Tools
- **Node.js**: v18.x or v20.x
- **Yarn**: Latest version
- **Git**: For version control
- **Platform-specific tools**:
  - **macOS**: Xcode Command Line Tools
  - **Windows**: Visual Studio 2022 with C++ Desktop Development
  - **Linux**: build-essential, g++, libx11-dev

### Installation Commands

```bash
# Install Node.js (using nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 18
nvm use 18

# Install Yarn
npm install -g yarn

# Platform-specific installations
# macOS
xcode-select --install

# Linux (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install -y build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev

# Windows (run as Administrator)
# Install Visual Studio 2022 with C++ Desktop Development workload
```

## Building from Source

### 1. Clone the Repository
```bash
git clone https://github.com/Nexis-AI/Platonix-IDE.git
cd Platonix-IDE
```

### 2. Install Dependencies
```bash
yarn install
```

### 3. Build the Application
```bash
# Development build
yarn run compile

# Production build
NODE_ENV=production yarn run compile
```

### 4. Package for Distribution

#### macOS
```bash
# Intel Macs
yarn run gulp vscode-darwin-x64

# Apple Silicon Macs
yarn run gulp vscode-darwin-arm64

# Create DMG installer
cd ../VSCode-darwin-x64  # or arm64
hdiutil create -volname "Platonix IDE" -srcfolder . -ov -format UDZO platonix-ide-darwin-x64.dmg
```

#### Windows
```bash
# 64-bit Windows
yarn run gulp vscode-win32-x64-inno-updater

# The installer will be created in ../VSCode-win32-x64-inno-updater/
```

#### Linux
```bash
# 64-bit Linux
yarn run gulp vscode-linux-x64

# Create tarball
cd ../VSCode-linux-x64
tar -czf platonix-ide-linux-x64.tar.gz *

# Create AppImage (optional)
# Install appimagetool first
./appimagetool-x86_64.AppImage . platonix-ide-x64.AppImage

# Create .deb package (optional)
yarn run gulp vscode-linux-x64-deb

# Create .rpm package (optional)
yarn run gulp vscode-linux-x64-rpm
```

## Creating Releases

### Using GitHub Actions (Recommended)

Our automated release workflow handles the entire process:

1. **Create a Git Tag**
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. **GitHub Actions will automatically**:
   - Create a GitHub Release
   - Build for all platforms (Windows, macOS Intel/ARM, Linux)
   - Upload installers as release assets
   - Generate release notes

3. **Monitor the release**:
   - Go to Actions tab in GitHub
   - Watch the "Release Platonix IDE" workflow
   - Downloads will be available in the Releases section when complete

### Manual Release Process

If you need to create a release manually:

1. **Update Version Numbers**
   ```bash
   # Update package.json
   npm version 1.0.0 --no-git-tag-version
   
   # Update product.json
   node -e "const p = require('./product.json'); p.platonixVersion = '1.0.0'; require('fs').writeFileSync('./product.json', JSON.stringify(p, null, 2));"
   ```

2. **Build for All Platforms**
   ```bash
   # Run builds for each platform (see Building from Source section)
   ```

3. **Create GitHub Release**
   - Go to https://github.com/Nexis-AI/Platonix-IDE/releases
   - Click "Draft a new release"
   - Tag version: v1.0.0
   - Release title: Platonix IDE v1.0.0
   - Upload all built installers
   - Publish release

## Automated Deployment

### GitHub Actions Workflows

We have three main workflows:

1. **CI Pipeline** (`.github/workflows/ci.yml`)
   - Runs on every push and PR
   - Tests on all platforms
   - Creates build artifacts

2. **Release Workflow** (`.github/workflows/release.yml`)
   - Triggered by version tags (v*.*.*)
   - Builds production releases
   - Uploads to GitHub Releases

3. **PR Validation** (`.github/workflows/pr-validation.yml`)
   - Validates PR quality
   - Runs security checks
   - Labels PRs automatically

### Triggering Automated Releases

```bash
# 1. Update version in files
yarn version --new-version 1.0.1

# 2. Commit changes
git add .
git commit -m "chore: bump version to 1.0.1"

# 3. Create and push tag
git tag v1.0.1
git push origin main --tags

# GitHub Actions will handle the rest!
```

## Distribution Channels

### 1. GitHub Releases (Primary)
- Direct downloads from https://github.com/Nexis-AI/Platonix-IDE/releases
- Always contains latest stable version
- Includes changelogs and release notes

### 2. Project Website (Future)
- Host installers on dedicated website
- Provide auto-update functionality
- Track download statistics

### 3. Package Managers (Future)
```bash
# Homebrew (macOS)
brew install platonix-ide

# Chocolatey (Windows)
choco install platonix-ide

# Snap (Linux)
snap install platonix-ide

# AUR (Arch Linux)
yay -S platonix-ide
```

### 4. Auto-Update System
Platonix IDE includes an auto-update system that:
- Checks for updates on startup
- Downloads updates in background
- Prompts user to restart when ready
- Can be disabled in settings

## Download Links

Once deployed, users can download Platonix IDE from:

### Direct Downloads (After Release)
- **Windows**: `https://github.com/Nexis-AI/Platonix-IDE/releases/download/v1.0.0/platonix-ide-1.0.0-setup-x64.exe`
- **macOS Intel**: `https://github.com/Nexis-AI/Platonix-IDE/releases/download/v1.0.0/platonix-ide-1.0.0-darwin-x64.dmg`
- **macOS ARM**: `https://github.com/Nexis-AI/Platonix-IDE/releases/download/v1.0.0/platonix-ide-1.0.0-darwin-arm64.dmg`
- **Linux**: `https://github.com/Nexis-AI/Platonix-IDE/releases/download/v1.0.0/platonix-ide-1.0.0-linux-x64.tar.gz`

### Installation Instructions for Users

#### Windows
1. Download the `.exe` installer
2. Run the installer
3. Follow the installation wizard
4. Launch Platonix IDE from Start Menu

#### macOS
1. Download the `.dmg` file
2. Open the DMG
3. Drag Platonix IDE to Applications
4. Launch from Applications folder

#### Linux
1. Download the `.tar.gz` file
2. Extract: `tar -xzf platonix-ide-*.tar.gz`
3. Move to desired location: `sudo mv platonix-ide /opt/`
4. Create desktop entry or run: `/opt/platonix-ide/platonix`

## Troubleshooting

### Build Issues
- **Node-gyp errors**: Ensure Python and build tools are installed
- **Permission errors**: Use appropriate permissions or run as administrator
- **Out of memory**: Increase Node heap size: `NODE_OPTIONS=--max-old-space-size=4096`

### Release Issues
- **GitHub Actions failing**: Check workflow logs in Actions tab
- **Missing artifacts**: Ensure all build steps completed successfully
- **Version conflicts**: Ensure version numbers are synchronized across all files

## Security Considerations

1. **Code Signing**
   - macOS: Requires Apple Developer Certificate
   - Windows: Requires Code Signing Certificate
   - Linux: Use GPG signatures for packages

2. **Checksums**
   - Generate SHA256 checksums for all releases
   - Include in release notes
   - Allow users to verify downloads

3. **Security Scanning**
   - All releases go through security scanning
   - Dependencies are audited
   - No telemetry or data collection

## Support

For deployment issues:
- Open an issue: https://github.com/Nexis-AI/Platonix-IDE/issues
- Check existing documentation: https://github.com/Nexis-AI/Platonix-IDE/tree/main/docs
- Community support: [Coming Soon]

---

*Last Updated: 2025-07-22*