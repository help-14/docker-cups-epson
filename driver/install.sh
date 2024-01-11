#!/usr/bin/bash

# Detect the architecture of the current system
ARCH=$(dpkg --print-architecture)

# Define the generic package pattern
PKG_PATTERN_AMD64="*amd64.deb"
PKG_PATTERN_I386="*i386.deb"

# Find the package file names
PKG_AMD64=$(find . -name "$PKG_PATTERN_AMD64" -print -quit)
PKG_I386=$(find . -name "$PKG_PATTERN_I386" -print -quit)

# Function to install package
install_package() {
    if [ -f "$1" ]; then
        echo "Installing $1..."
        sudo dpkg -i "$1"
    else
        echo "Package file not found: $1"
    fi
}

# Install the appropriate package based on the architecture
if [ "$ARCH" = "amd64" ]; then
    install_package "$PKG_AMD64"
elif [ "$ARCH" = "i386" ]; then
    install_package "$PKG_I386"
else
    echo "Unsupported architecture: $ARCH"
fi