#!/bin/bash

# CodeBuddy CLI Packaging Script
# This script installs CodeBuddy CLI from npm and packages it for offline installation

set -e

# Configuration
PACKAGE_NAME="@tencent-ai/codebuddy-code"
RELEASE_DIR="releases"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

echo "🚀 CodeBuddy CLI Packaging Script"
echo "=================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js is not installed. Please install Node.js 18.20 or higher."
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node --version | sed 's/v//')
REQUIRED_VERSION="18.20.0"

# Simple version comparison
version_ge() {
    [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" = "$2" ]
}

if ! version_ge "$NODE_VERSION" "$REQUIRED_VERSION"; then
    echo "❌ Error: Node.js version $NODE_VERSION is too old. Please upgrade to 18.20 or higher."
    exit 1
fi

echo "✅ Node.js version check passed: $NODE_VERSION"

# Install or update CodeBuddy CLI
echo "📦 Installing/updating CodeBuddy CLI..."
npm install -g $PACKAGE_NAME

# Get installed version
VERSION=$(codebuddy --version 2>/dev/null | head -n1)
if [ -z "$VERSION" ]; then
    echo "❌ Error: Failed to get CodeBuddy version. Installation may have failed."
    exit 1
fi

echo "✅ CodeBuddy CLI version $VERSION installed successfully"

# Get npm global directory
NPM_GLOBAL_DIR=$(npm root -g)
echo "📍 NPM global directory: $NPM_GLOBAL_DIR"

# Create package filename
PACKAGE_FILENAME="codebuddy-cli-${VERSION}.tgz"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_PATH="$SCRIPT_DIR/$RELEASE_DIR/$PACKAGE_FILENAME"

# Create releases directory
echo "📁 Creating releases directory..."
mkdir -p "$(dirname "$PACKAGE_PATH")"

# Create proper npm package
echo "📦 Creating npm package..."
cd /tmp
NPM_PACK_FILE=$(npm pack "$PACKAGE_NAME")

# Move the created package to releases directory
echo "📁 Moving package to releases directory..."
mv "$NPM_PACK_FILE" "$PACKAGE_PATH"

# Verify package was created
if [ -f "$PACKAGE_PATH" ]; then
    PACKAGE_SIZE=$(du -h "$PACKAGE_PATH" | cut -f1)
    echo "✅ Package created successfully:"
    echo "   📄 File: $PACKAGE_PATH"
    echo "   📏 Size: $PACKAGE_SIZE"
else
    echo "❌ Error: Failed to create package file"
    exit 1
fi

# Create latest symlink (optional)
echo "🔗 Creating latest symlink..."
cd "$(dirname "$PACKAGE_PATH")"
ln -sf "$PACKAGE_FILENAME" "codebuddy-cli-latest.tgz"

# Clean up temporary files
rm -f /tmp/tencent-ai-codebuddy-code-*.tgz

# Display summary
echo ""
echo "🎉 Packaging completed successfully!"
echo "==================================="
echo "Package: $PACKAGE_PATH"
echo "Version: $VERSION"
echo "Size: $PACKAGE_SIZE"
echo ""
echo "To install on another computer:"
echo "  npm install -g ./releases/$PACKAGE_FILENAME"
echo ""
echo "Or use the latest symlink:"
echo "  npm install -g ./releases/codebuddy-cli-latest.tgz"