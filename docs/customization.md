# Platonix IDE - Customization Guide

This guide covers how to customize Platonix IDE's appearance, behavior, and functionality.

## Theme Customization

### Using the Built-in Platonix Dark Theme

Platonix IDE comes with a custom dark theme optimized for long coding sessions:

1. Open Command Palette: `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
2. Type "Color Theme"
3. Select "Preferences: Color Theme"
4. Choose "Platonix Dark"

### Custom Theme Colors

The Platonix Dark theme features:
- **Primary Color**: #00b8db (Cyan accent)
- **Background**: #121212 (True dark)
- **Editor Background**: #171717
- **Sidebar**: #121212
- **Accent Colors**: Various shades of cyan/teal

### Creating Your Own Theme

1. Create a new folder in `~/.platonix-ide/extensions/my-theme/`
2. Add a `package.json`:

```json
{
  "name": "my-custom-theme",
  "displayName": "My Custom Theme",
  "description": "Personal theme for Platonix IDE",
  "version": "1.0.0",
  "engines": {
    "vscode": "^1.0.0"
  },
  "categories": ["Themes"],
  "contributes": {
    "themes": [
      {
        "label": "My Custom Dark",
        "uiTheme": "vs-dark",
        "path": "./themes/my-dark-theme.json"
      }
    ]
  }
}
```

3. Create `themes/my-dark-theme.json` with your color definitions

## Font Customization

### Default Fonts

Platonix IDE uses optimized fonts for coding:
- **Editor**: JetBrains Mono, Fira Code (with ligatures)
- **UI**: Outfit (custom sans-serif)

### Changing Fonts

Edit your settings.json:

```json
{
  "editor.fontFamily": "'JetBrains Mono', 'Fira Code', monospace",
  "editor.fontSize": 14,
  "editor.fontLigatures": true,
  "editor.letterSpacing": 0.5,
  "terminal.integrated.fontFamily": "'JetBrains Mono'",
  "terminal.integrated.fontSize": 13
}
```

### Installing Custom Fonts

1. Download your preferred font (e.g., from [Nerd Fonts](https://www.nerdfonts.com/))
2. Install on your system
3. Update settings.json with the font name

## UI Customization

### Layout Options

```json
{
  // Sidebar position
  "workbench.sideBar.location": "left", // or "right"
  
  // Activity bar visibility
  "workbench.activityBar.visible": true,
  
  // Status bar visibility
  "workbench.statusBar.visible": true,
  
  // Minimap
  "editor.minimap.enabled": true,
  "editor.minimap.side": "right",
  
  // Breadcrumbs
  "breadcrumbs.enabled": true
}
```

### Window Customization

```json
{
  // Title bar style
  "window.titleBarStyle": "custom",
  
  // Menu bar visibility
  "window.menuBarVisibility": "toggle", // "visible", "hidden", "toggle"
  
  // Zoom level
  "window.zoomLevel": 0
}
```

## Editor Behavior

### Code Formatting

```json
{
  // Auto-format on save
  "editor.formatOnSave": true,
  
  // Tab settings
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  
  // Line numbers
  "editor.lineNumbers": "relative", // "on", "off", "relative"
  
  // Word wrap
  "editor.wordWrap": "on",
  
  // Cursor style
  "editor.cursorStyle": "line", // "block", "underline", "line-thin"
  "editor.cursorBlinking": "smooth"
}
```

### IntelliSense and Suggestions

```json
{
  // Quick suggestions
  "editor.quickSuggestions": {
    "other": true,
    "comments": false,
    "strings": true
  },
  
  // Suggestion delay
  "editor.quickSuggestionsDelay": 10,
  
  // Accept suggestions on Enter
  "editor.acceptSuggestionOnEnter": "on",
  
  // Show parameter hints
  "editor.parameterHints.enabled": true
}
```

## AI Feature Customization

### Autocomplete Settings

```json
{
  // Enable/disable AI autocomplete
  "platonix.ai.autocomplete.enabled": true,
  
  // Autocomplete trigger delay (ms)
  "platonix.ai.autocomplete.delay": 150,
  
  // Maximum suggestions
  "platonix.ai.autocomplete.maxSuggestions": 3,
  
  // Autocomplete model
  "platonix.ai.autocomplete.model": "qwen2.5-coder:1.5b"
}
```

### AI Chat Settings

```json
{
  // Default chat model
  "platonix.ai.chat.model": "llama3.1",
  
  // Chat temperature (0.0-1.0)
  "platonix.ai.chat.temperature": 0.7,
  
  // Maximum response length
  "platonix.ai.chat.maxTokens": 2048,
  
  // Include file context automatically
  "platonix.ai.chat.includeContext": true
}
```

## Keyboard Shortcuts

### Customizing Shortcuts

1. Open Keyboard Shortcuts: `Ctrl+K Ctrl+S` (Windows/Linux) or `Cmd+K Cmd+S` (macOS)
2. Search for the command
3. Click the pencil icon to edit
4. Press your desired key combination

### Common Custom Shortcuts

Add to keybindings.json:

```json
[
  {
    "key": "ctrl+shift+d",
    "command": "editor.action.duplicateLine"
  },
  {
    "key": "ctrl+alt+up",
    "command": "editor.action.moveLinesUpAction"
  },
  {
    "key": "ctrl+alt+down",
    "command": "editor.action.moveLinesDownAction"
  },
  {
    "key": "ctrl+j",
    "command": "workbench.action.togglePanel"
  }
]
```

## Extensions

### Installing Extensions

1. Open Extensions view: `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (macOS)
2. Search for extensions
3. Click Install

### Recommended Extensions

- **GitLens**: Enhanced Git capabilities
- **Prettier**: Code formatting
- **ESLint**: JavaScript linting
- **Live Server**: Local development server
- **Material Icon Theme**: File icons

### Disabling Extensions

```json
{
  // Disable specific extensions
  "extensions.disabled": [
    "ms-vscode.extension-id"
  ]
}
```

## Workspace Settings

### Project-Specific Settings

Create `.vscode/settings.json` in your project:

```json
{
  // Project-specific settings
  "editor.tabSize": 4,
  "files.exclude": {
    "**/.git": true,
    "**/.DS_Store": true,
    "**/node_modules": true
  },
  "search.exclude": {
    "**/dist": true,
    "**/build": true
  }
}
```

### Multi-Root Workspaces

Create a `.code-workspace` file:

```json
{
  "folders": [
    {
      "path": "frontend",
      "name": "Frontend"
    },
    {
      "path": "backend",
      "name": "Backend"
    }
  ],
  "settings": {
    // Workspace-wide settings
  }
}
```

## Advanced Customization

### Custom CSS

1. Install "Custom CSS and JS Loader" extension
2. Create a CSS file with your styles
3. Add to settings.json:

```json
{
  "vscode_custom_css.imports": [
    "file:///path/to/your/custom.css"
  ]
}
```

### User Snippets

Create custom snippets:

1. `File → Preferences → Configure User Snippets`
2. Select language or create global snippets
3. Add your snippets:

```json
{
  "Console Log": {
    "prefix": "cl",
    "body": [
      "console.log('$1');",
      "$2"
    ],
    "description": "Log to console"
  }
}
```

## Backup and Sync

### Settings Sync

Enable Settings Sync to backup your customizations:

1. Click the Accounts icon in the Activity Bar
2. Turn on Settings Sync
3. Choose what to sync (settings, keybindings, extensions, etc.)

### Manual Backup

Your settings are stored in:
- **Windows**: `%APPDATA%\Platonix IDE\User`
- **macOS**: `~/Library/Application Support/Platonix IDE/User`
- **Linux**: `~/.config/Platonix IDE/User`

## Reset to Defaults

To reset all customizations:

1. Open Command Palette
2. Run "Preferences: Open User Settings (JSON)"
3. Delete all content or specific settings
4. Restart Platonix IDE

## Support

For more customization help:
- [Platonix IDE Documentation](https://github.com/nexisnetwork/platonix-ide)
- [Report Issues](https://github.com/nexisnetwork/platonix-ide/issues)
- Email: support@platonix-ide.com