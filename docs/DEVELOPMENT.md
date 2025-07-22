# Platonix IDE Development Guide

This guide explains how to run Platonix IDE locally in developer mode for testing and development.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Node.js** (v18.x or v20.x)
   ```bash
   # Check your version
   node --version
   ```

2. **Yarn** (latest version)
   ```bash
   # Install yarn globally
   npm install -g yarn
   ```

3. **Git**
   ```bash
   git --version
   ```

4. **Platform-specific requirements**:
   - **macOS**: Xcode Command Line Tools
     ```bash
     xcode-select --install
     ```
   - **Windows**: Visual Studio 2022 with "Desktop development with C++" workload
   - **Linux**: Build essentials
     ```bash
     sudo apt-get update
     sudo apt-get install build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev
     ```

## Running in Developer Mode

### 1. Clone the Repository

```bash
git clone https://github.com/Nexis-AI/Platonix-IDE.git
cd Platonix-IDE
```

### 2. Install Dependencies

```bash
# This will install all required packages
yarn install
```

### 3. Compile the Code

```bash
# Initial compilation
yarn run compile

# Or for faster development (watches for changes)
yarn run watch
```

### 4. Run in Developer Mode

There are several ways to run Platonix IDE in developer mode:

#### Option A: Run from Terminal (Recommended)

```bash
# Run Platonix IDE
./scripts/code.sh

# On Windows
./scripts/code.bat

# Or using yarn
yarn run electron
```

#### Option B: Run with Debugging

```bash
# Run with Chrome DevTools enabled
./scripts/code.sh --inspect=9222

# Run with verbose logging
./scripts/code.sh --verbose
```

#### Option C: Run Specific Folder/File

```bash
# Open a specific folder
./scripts/code.sh /path/to/your/project

# Open a specific file
./scripts/code.sh /path/to/file.js
```

## Development Workflow

### 1. Watch Mode (Auto-compile)

Keep this running in a terminal:
```bash
yarn run watch
```

This automatically recompiles when you make changes.

### 2. Run Tests

```bash
# Run unit tests
yarn test

# Run integration tests
yarn test-browser

# Run specific test suite
yarn test --grep "YourTestName"
```

### 3. Debugging the Main Process

1. Start with debugging enabled:
   ```bash
   ./scripts/code.sh --inspect-brk=9222
   ```

2. Open Chrome and navigate to `chrome://inspect`

3. Click "inspect" under the Electron process

### 4. Debugging the Renderer Process

1. Open Developer Tools in Platonix IDE:
   - **macOS/Linux**: `Cmd/Ctrl + Alt + I`
   - **Windows**: `Ctrl + Shift + I`
   - Or: Help → Toggle Developer Tools

## Common Development Commands

```bash
# Clean and rebuild everything
yarn run clean
yarn install
yarn run compile

# Run linting
yarn run eslint

# Format code
yarn run prettier

# Type checking
yarn run monaco-compile-check

# Bundle extensions
yarn run bundle-extensions

# Run specific gulp task
yarn run gulp <task-name>
```

## Environment Variables

Create a `.env` file in the root directory for local settings:

```bash
# Enable verbose logging
PLATONIX_DEV=1
VSCODE_VERBOSE=true

# Set specific Node options
NODE_OPTIONS="--max-old-space-size=4096"

# Enable experimental features
PLATONIX_ENABLE_EXPERIMENTAL=1
```

## Hot Reload Setup

For faster development with hot reload:

1. Install the development extension:
   ```bash
   cd extensions/dev-tools
   yarn install
   ```

2. Run with hot reload:
   ```bash
   yarn run watch-client
   ```

3. In another terminal:
   ```bash
   ./scripts/code.sh --enable-hot-reload
   ```

## AI Features Development

To work on AI features with Ollama:

1. **Install Ollama**:
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ```

2. **Pull a model**:
   ```bash
   ollama pull codellama
   ```

3. **Start Ollama** (if not running):
   ```bash
   ollama serve
   ```

4. **Verify Ollama is accessible**:
   ```bash
   curl http://127.0.0.1:11434/api/tags
   ```

5. **Test AI features** in Platonix IDE:
   - Tab completion: Start typing code
   - Inline edit: Select code and press `Ctrl/Cmd + K`
   - AI chat: Press `Ctrl/Cmd + L`

## Troubleshooting Development Issues

### Issue: "Cannot find module" errors
```bash
# Clear node_modules and reinstall
rm -rf node_modules
yarn install
```

### Issue: Build fails with native module errors
```bash
# Rebuild native modules
yarn electron-rebuild

# Or manually
cd node_modules/<module-name>
node-gyp rebuild --target=<electron-version> --arch=x64 --dist-url=https://electronjs.org/headers
```

### Issue: Changes not reflecting
```bash
# Make sure watch is running
yarn run watch

# For extension changes, reload window
Ctrl/Cmd + R in Platonix IDE
```

### Issue: Port already in use
```bash
# Find and kill the process
lsof -i :9222  # or whatever port
kill -9 <PID>
```

## Quick Development Setup Script

Save this as `dev-setup.sh`:

```bash
#!/bin/bash

echo "🚀 Setting up Platonix IDE development environment..."

# Install dependencies
echo "📦 Installing dependencies..."
yarn install

# Compile
echo "🔨 Compiling..."
yarn run compile

# Start watch in background
echo "👁️  Starting watch mode..."
yarn run watch &
WATCH_PID=$!

# Wait for initial compilation
sleep 5

# Run Platonix IDE
echo "🎯 Launching Platonix IDE..."
./scripts/code.sh

# Cleanup
kill $WATCH_PID
```

Make it executable:
```bash
chmod +x dev-setup.sh
./dev-setup.sh
```

## Development Tips

1. **Use the built-in terminal**: Press `` Ctrl+` `` to open integrated terminal
2. **Multi-root workspaces**: Open multiple folders for testing
3. **Extension development**: Use F5 to launch Extension Development Host
4. **Performance profiling**: Help → Developer → Startup Performance
5. **Process Explorer**: Help → Developer → Process Explorer

## Next Steps

- Read the [Architecture Overview](https://github.com/microsoft/vscode/wiki/Source-Code-Organization)
- Join development discussions on GitHub Issues
- Submit PRs following our [Contributing Guidelines](../CONTRIBUTING.md)

---

Happy coding with Platonix IDE! 🚀