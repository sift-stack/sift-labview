#!/bin/bash

# Update to the latest release.
TAG=v0.4.0-dev.1

# Exit immediately if a command exits with a non-zero status.
set -e

# Define variables
REPO_OWNER="sift-stack"
REPO_NAME="sift-labview"
BINARY_NAME="sift_proxy"
INSTALL_DIR="/home/lvuser/Sift"

# Extract the URL of the binary for Linux (adjust asset name pattern as needed)
DOWNLOAD_URL="https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/refs/tags/$TAG/src/Sift/Support/sift_proxy"

# Check if the download URL exists (try curl or wget)
if command -v curl >/dev/null 2>&1; then
  if ! curl -s --head "$DOWNLOAD_URL" | grep "200 OK" >/dev/null; then
    echo "Error: The download URL does not exist or is not reachable." >&2
    exit 1
  fi
elif command -v wget >/dev/null 2>&1; then
  if ! wget --spider -q "$DOWNLOAD_URL"; then
    echo "Error: The download URL does not exist or is not reachable." >&2
    exit 1
  fi
else
  echo "Error: Neither curl nor wget is available on this system." >&2
  exit 1
fi

# Download the binary
TEMP_FILE="/tmp/$BINARY_NAME"
echo "Downloading $BINARY_NAME from $DOWNLOAD_URL..."
if command -v curl >/dev/null 2>&1; then
  curl -sL "$DOWNLOAD_URL" -o "$TEMP_FILE"
elif command -v wget >/dev/null 2>&1; then
  wget -q "$DOWNLOAD_URL" -O "$TEMP_FILE"\else
  echo "Error: Neither curl nor wget is available to download the binary." >&2
  exit 1
fi

# Make the binary executable
chmod +x "$TEMP_FILE"

# Move the binary to the install directory
echo "Installing $BINARY_NAME to $INSTALL_DIR..."
mkdir -p $INSTALL_DIR
sudo mv "$TEMP_FILE" "$INSTALL_DIR/$BINARY_NAME"

# Confirm installation
if command -v $BINARY_NAME >/dev/null 2>&1; then
  echo "$BINARY_NAME installed successfully!"
else
  echo "Error: $BINARY_NAME could not be installed." >&2
  exit 1
fi
