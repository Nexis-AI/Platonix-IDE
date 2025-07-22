# Contributing to Platonix IDE

Thank you for your interest in contributing to Platonix IDE! We welcome contributions from the community and are grateful for your support.

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct. Please be respectful and considerate in all interactions.

## How to Contribute

### Reporting Issues

1. **Search existing issues** to avoid duplicates
2. **Use issue templates** when available
3. **Provide detailed information**:
   - OS and version
   - Platonix IDE version
   - Steps to reproduce
   - Expected vs actual behavior
   - Error messages or logs

### Suggesting Features

1. Check the [Project Board](https://github.com/nexisnetwork/platonix-ide/projects/1) for planned features
2. Open a feature request with:
   - Clear use case
   - Proposed solution
   - Alternative approaches considered

### Contributing Code

#### Prerequisites

- Node.js v18+ and Yarn
- Git
- Platform-specific build tools:
  - **macOS**: Xcode Command Line Tools
  - **Windows**: Visual Studio 2022 with C++ workload
  - **Linux**: build-essential, python3

#### Development Setup

1. **Fork and Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/platonix-ide.git
   cd platonix-ide
   ```

2. **Install Dependencies**
   ```bash
   yarn install
   ```

3. **Build and Run**
   ```bash
   yarn run watch
   ./scripts/code.sh    # macOS/Linux
   ./scripts/code.bat   # Windows
   ```

#### Development Workflow

1. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes**
   - Follow existing code style
   - Add tests for new features
   - Update documentation

3. **Test your changes**
   ```bash
   yarn test
   yarn run lint
   ```

4. **Commit with meaningful messages**
   ```bash
   git commit -m "feat: add new AI autocomplete feature"
   ```

   Follow [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat:` New features
   - `fix:` Bug fixes
   - `docs:` Documentation changes
   - `style:` Code style changes
   - `refactor:` Code refactoring
   - `test:` Test additions/changes
   - `chore:` Build/tool changes

5. **Push and create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

### Code Style Guidelines

#### TypeScript/JavaScript

- Use TypeScript for new code
- Follow existing patterns in the codebase
- Use meaningful variable and function names
- Add JSDoc comments for public APIs

```typescript
/**
 * Sends a message to the AI model
 * @param message The user's message
 * @param context Optional code context
 * @returns Promise with AI response
 */
export async function sendAIMessage(
  message: string, 
  context?: CodeContext
): Promise<AIResponse> {
  // Implementation
}
```

#### CSS

- Use CSS variables for theming
- Follow BEM naming convention where applicable
- Keep styles modular and reusable

```css
.platonix-sidebar {
  background: var(--platonix-sidebar-background);
  color: var(--platonix-sidebar-foreground);
}

.platonix-sidebar__header {
  padding: var(--platonix-spacing-md);
}
```

### Testing

#### Unit Tests

```bash
yarn test
```

#### Integration Tests

```bash
yarn test-integration
```

#### Manual Testing

Test on all supported platforms:
- macOS (latest - 2 versions)
- Windows 10/11
- Ubuntu LTS

### Documentation

- Update README.md for user-facing changes
- Add/update docs/ for new features
- Include code examples
- Keep language clear and concise

### AI Integration Guidelines

When working on AI features:

1. **Privacy First**: Ensure no data leaves the local machine
2. **Model Compatibility**: Test with multiple Ollama models
3. **Performance**: Monitor token usage and response times
4. **Error Handling**: Gracefully handle model unavailability

### Pull Request Process

1. **PR Title**: Use conventional commit format
2. **Description**: 
   - Explain what changes and why
   - Link related issues
   - Include screenshots for UI changes
3. **Reviews**: Address feedback promptly
4. **CI**: Ensure all checks pass

### Project Structure

```
platonix-ide/
├── src/
│   └── vs/
│       └── workbench/
│           └── contrib/
│               └── platonix/     # AI integration code
├── extensions/                   # Built-in extensions
├── resources/                    # Icons and assets
├── scripts/                      # Build scripts
└── docs/                        # Documentation
```

Key directories:
- `src/vs/workbench/contrib/platonix/`: Core AI functionality
- `extensions/theme-defaults/`: Theme definitions
- `product.json`: Product configuration

### Release Process

1. Version follows semantic versioning
2. Releases are tagged and include:
   - Binary builds for all platforms
   - Release notes
   - Migration guide (if needed)

## Getting Help

- **Discord**: Join our community server
- **GitHub Discussions**: Ask questions
- **Issues**: Report bugs
- **Email**: dev@platonix-ide.com

## Recognition

Contributors are recognized in:
- Release notes
- Contributors file
- GitHub insights

Thank you for helping make Platonix IDE better!