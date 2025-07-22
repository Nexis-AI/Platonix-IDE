# Platonix IDE - AI Integration Setup

Platonix IDE includes built-in support for local AI models through Ollama integration, ensuring your code never leaves your machine.

## Quick Start

### 1. Install Ollama

**macOS/Linux:**
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

**Windows:**
Download the installer from [ollama.com](https://ollama.com)

### 2. Pull a Model

We recommend starting with CodeLlama for code completion:

```bash
# For code completion and assistance
ollama pull codellama

# For more advanced reasoning (larger model)
ollama pull qwq

# For a lightweight option
ollama pull qwen2.5-coder:1.5b
```

### 3. Configure Platonix IDE

Ollama is pre-configured to work with Platonix IDE. The default endpoint is:
- `http://127.0.0.1:11434`

To verify Ollama is running:
```bash
ollama list
```

## Supported Models

Platonix IDE has been optimized for the following models:

### Recommended Models

| Model | Size | Best For | Command |
|-------|------|----------|---------|
| **qwen2.5-coder:1.5b** | 0.98 GB | Fast code completion | `ollama pull qwen2.5-coder:1.5b` |
| **llama3.1** | 4.9 GB | General coding assistance | `ollama pull llama3.1` |
| **codellama** | 3.8 GB | Code-specific tasks | `ollama pull codellama` |
| **deepseek-r1** | 4.7 GB | Complex reasoning | `ollama pull deepseek-r1` |
| **qwq** | 20 GB | Advanced reasoning | `ollama pull qwq` |

### Model Capabilities

- **Code Completion (FIM)**: qwen2.5-coder supports Fill-in-Middle for accurate completions
- **Reasoning Models**: deepseek-r1 and qwq provide step-by-step reasoning
- **General Purpose**: llama3.1 offers balanced performance

## AI Features

### 1. Tab Autocomplete
- **Trigger**: Press Tab when coding
- **Model**: Uses FIM-capable models (qwen2.5-coder)
- **Behavior**: Context-aware code suggestions

### 2. Inline Editing (Ctrl+K / Cmd+K)
- **Trigger**: Select code and press Ctrl+K (Windows/Linux) or Cmd+K (macOS)
- **Usage**: Describe the changes you want
- **Example**: "Convert this function to async/await"

### 3. Contextual AI Chat (Ctrl+L / Cmd+L)
- **Trigger**: Press Ctrl+L (Windows/Linux) or Cmd+L (macOS)
- **Usage**: Ask questions about your code or request help
- **Context**: Automatically includes relevant code context

### 4. AI-Powered Search
- **Access**: Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
- **Usage**: Natural language search across your codebase

## Configuration

### Change AI Model

1. Open Settings: `File → Preferences → Settings` (or `Cmd+,` on macOS)
2. Search for "Platonix AI"
3. Select your preferred model from the dropdown

### Advanced Configuration

Edit your settings.json:

```json
{
  "platonix.ai.model": "codellama",
  "platonix.ai.endpoint": "http://localhost:11434",
  "platonix.ai.autocomplete.enabled": true,
  "platonix.ai.autocomplete.model": "qwen2.5-coder:1.5b",
  "platonix.ai.chat.model": "llama3.1"
}
```

### Custom Endpoints

If running Ollama on a different machine:

```json
{
  "platonix.ai.endpoint": "http://192.168.1.100:11434"
}
```

## Performance Tips

1. **Model Selection**: 
   - Use smaller models (1-3GB) for faster responses
   - Use larger models (10GB+) for complex tasks

2. **GPU Acceleration**:
   - Ollama automatically uses GPU if available
   - Check GPU usage: `ollama ps`

3. **Memory Management**:
   - Unload models when not in use: `ollama stop <model>`
   - List running models: `ollama ps`

## Troubleshooting

### Ollama Not Responding

1. Check if Ollama is running:
   ```bash
   curl http://localhost:11434/api/version
   ```

2. Restart Ollama:
   ```bash
   # macOS/Linux
   systemctl restart ollama
   
   # Or manually
   ollama serve
   ```

### Model Download Issues

- Check disk space (models can be 1-20GB)
- Verify internet connection
- Try alternative model: `ollama pull mistral`

### Slow Performance

- Use smaller models for faster response
- Check system resources (RAM/GPU)
- Close unnecessary applications

## Privacy & Security

- **100% Local**: All AI processing happens on your machine
- **No Data Collection**: Your code never leaves your computer
- **Offline Capable**: Works without internet after model download
- **Open Source**: Both Platonix IDE and Ollama are open source

## Additional Resources

- [Ollama Documentation](https://github.com/ollama/ollama)
- [Model Library](https://ollama.com/library)
- [Platonix IDE GitHub](https://github.com/nexisnetwork/platonix-ide)

## Support

For issues or questions:
- GitHub Issues: [Report a bug](https://github.com/nexisnetwork/platonix-ide/issues)
- Email: support@platonix-ide.com