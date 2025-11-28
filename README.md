# CodeBuddy CLI Installation and Packaging Guide

This guide documents the process for installing CodeBuddy CLI from npm and packaging it for offline/local installation.

## ✅ Tested and Verified

The packaging process and resulting `.tgz` files have been thoroughly tested and verified to work correctly for offline installation.

## Prerequisites

- Node.js 18.20 or higher
- npm (comes with Node.js)
- Internet connection for initial installation

## Installation from npm (Online)

### 1. Install CodeBuddy CLI globally
```bash
npm install -g @tencent-ai/codebuddy-code
```

### 2. Verify installation
```bash
codebuddy --version
```

### 3. Troubleshooting
- **Command not found**: Check if npm global bin directory is in your PATH
- **Network issues**: Configure npm mirror:
  ```bash
  npm config set registry https://registry.npmmirror.com
  ```

## Automated Packaging (Recommended)

### Using the provided script
```bash
./package-codebuddy-cli.sh
```

This script will:
- ✅ Check Node.js version compatibility
- 📦 Install/update CodeBuddy CLI
- 🎯 Create proper npm package using `npm pack`
- 📁 Save package to `releases/` directory
- 🔗 Create `latest` symlink for convenience

## Manual Packaging (Alternative)

### 1. Install CodeBuddy CLI
```bash
npm install -g @tencent-ai/codebuddy-code
```

### 2. Create proper npm package
```bash
cd /tmp
npm pack @tencent-ai/codebuddy-code
mv tencent-ai-codebuddy-code-*.tgz your-target-directory/
```

### 3. Rename for clarity (optional)
```bash
mv tencent-ai-codebuddy-code-2.9.0.tgz codebuddy-cli-2.9.0.tgz
```

## Offline Installation

### 1. Install from local package
```bash
npm install -g ./codebuddy-cli-2.9.0.tgz
```

### 2. Verify installation
```bash
codebuddy --version
```

## Uninstallation

```bash
npm uninstall -g @tencent-ai/codebuddy-code
```

## Package Information

- **Package name**: `@tencent-ai/codebuddy-code`
- **Current version**: 2.9.0
- **Package size**: ~25.5 MB (proper npm package format)
- **Contains**: Complete CLI with all dependencies
- **Format**: Standard npm package (installable with `npm install -g`)
- **Structure**: Uses `package/` prefix for npm compatibility

## Important Notes

- ✅ **Tested**: Packages created with this method have been verified to install correctly
- 🏗️ **Proper Format**: Uses `npm pack` to create standard npm packages
- 📦 **Complete**: Contains all dependencies needed for offline installation
- 🌐 **Offline Ready**: Perfect for air-gapped environments or computers without internet
- 🔧 **Cross-Platform**: Can be shared between computers running the same operating system
- ⚡ **Quick Install**: Simple `npm install -g ./package.tgz` command

## Files in This Repository

- `package-codebuddy-cli.sh` - Automated packaging script
- `releases/codebuddy-cli-2.9.0.tgz` - Ready-to-use npm package
- `releases/codebuddy-cli-latest.tgz` - Symlink to latest version

## Quick Reference

| Action | Command |
|--------|---------|
| **Online Install** | `npm install -g @tencent-ai/codebuddy-code` |
| **Automated Package** | `./package-codebuddy-cli.sh` |
| **Manual Package** | `npm pack @tencent-ai/codebuddy-code` |
| **Offline Install** | `npm install -g ./codebuddy-cli-$(version).tgz` |
| **Version Check** | `codebuddy --version` |
| **Uninstall** | `npm uninstall -g @tencent-ai/codebuddy-code` |

## Example Usage

```bash
# Create package using script
./package-codebuddy-cli.sh

# Install from package on another computer
npm install -g ./releases/codebuddy-cli-2.9.0.tgz

# Or use the latest symlink
npm install -g ./releases/codebuddy-cli-latest.tgz
```