# Platonix IDE v1.0.1 Release

## 🎉 What's New in v1.0.1

This release provides working download packages for all platforms!

### ✨ Features (from v1.0.0)
- **AI-Powered Development**: Local AI integration with Ollama
- **Privacy-First**: 100% local processing, no telemetry
- **Custom Dark Theme**: Beautiful Platonix Dark theme with cyan accents
- **Multi-Platform**: Windows, macOS, and Linux support
- **VS Code Compatible**: Use your favorite extensions

### 🔧 Improvements in v1.0.1
- Fixed release workflow for proper downloads
- Added source archives for all platforms
- Simplified installation process
- Enhanced documentation

## 📥 Downloads

Download the source archive for your platform:

- **[Windows Source](https://github.com/Nexis-AI/Platonix-IDE/releases/download/v1.0.1/platonix-ide-1.0.1-windows-source.zip)** (36MB)
- **[macOS Source](https://github.com/Nexis-AI/Platonix-IDE/releases/download/v1.0.1/platonix-ide-1.0.1-macos-source.tar.gz)** (32MB)
- **[Linux Source](https://github.com/Nexis-AI/Platonix-IDE/releases/download/v1.0.1/platonix-ide-1.0.1-linux-source.tar.gz)** (32MB)

## 🚀 Installation Instructions

### Prerequisites
1. **Node.js 18.x or 20.x** - [Download](https://nodejs.org/)
2. **Yarn package manager** - Install with `npm install -g yarn`
3. **Git** - [Download](https://git-scm.com/)

### Platform-Specific Requirements

**Windows:**
- Visual Studio 2022 with "Desktop development with C++" workload

**macOS:**
- Xcode Command Line Tools: `xcode-select --install`

**Linux:**
```bash
sudo apt-get update
sudo apt-get install build-essential g++ libx11-dev libxkbfile-dev libsecret-1-dev
```

### Installation Steps

1. **Extract the archive** to your desired location

2. **Open terminal** in the extracted directory

3. **Install dependencies:**
   ```bash
   yarn install
   ```

4. **Compile the IDE:**
   ```bash
   yarn compile
   ```

5. **Run Platonix IDE:**
   - **Windows**: `.\scripts\code.bat`
   - **macOS/Linux**: `./scripts/code.sh`

## 🤖 Setting Up AI Features

1. **Install Ollama** from https://ollama.com

2. **Pull an AI model:**
   ```bash
   ollama pull codellama
   # or try other models:
   # ollama pull mistral
   # ollama pull phi3
   ```

3. **Start Ollama** (if not running):
   ```bash
   ollama serve
   ```

4. **Test AI features in Platonix IDE:**
   - **Tab completion**: Start typing code
   - **Inline editing**: Select code and press `Ctrl/Cmd + K`
   - **AI chat**: Press `Ctrl/Cmd + L`

## 📚 Documentation

- [Getting Started](https://github.com/Nexis-AI/Platonix-IDE/blob/main/README.md)
- [Development Guide](https://github.com/Nexis-AI/Platonix-IDE/blob/main/docs/DEVELOPMENT.md)
- [AI Integration Guide](https://github.com/Nexis-AI/Platonix-IDE/blob/main/docs/AI.md)
- [Customization Guide](https://github.com/Nexis-AI/Platonix-IDE/blob/main/docs/customization.md)

## 🐛 Troubleshooting

### Common Issues

**"Cannot find module" errors:**
```bash
rm -rf node_modules
yarn install
```

**Build fails on Windows:**
- Ensure Visual Studio 2022 is installed with C++ tools
- Run the command prompt as Administrator

**First launch is slow:**
- Initial compilation takes 2-5 minutes
- Keep `yarn watch` running for faster subsequent launches

## 💡 Pro Tips

1. **For faster development**, run in two terminals:
   ```bash
   # Terminal 1
   yarn watch
   
   # Terminal 2
   ./scripts/code.sh
   ```

2. **Enable hot reload**: Press `Ctrl/Cmd + R` to reload the window

3. **Access DevTools**: Press `Ctrl/Cmd + Alt + I`

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](https://github.com/Nexis-AI/Platonix-IDE/blob/main/CONTRIBUTING.md)

## 📝 License

MIT License - see [LICENSE](https://github.com/Nexis-AI/Platonix-IDE/blob/main/LICENSE.txt)

---

**Thank you for using Platonix IDE!** 🚀

If you encounter any issues, please [report them on GitHub](https://github.com/Nexis-AI/Platonix-IDE/issues).