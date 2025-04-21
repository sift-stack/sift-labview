#!/bin/bash

# Update to the latest release.
TAG=v1.3.1-dev.0

# Exit immediately if a command exits with a non-zero status.
set -e

# Define variables
REPO_OWNER="sift-stack"
REPO_NAME="sift-labview"
BINARY_NAME="sift_proxy"
INSTALL_DIR="/home/lvuser/Sift"
DOWNLOAD_BINARY_NAME="sift_proxy-linux"

# Check if sift_proxy is running
if pgrep -x "$BINARY_NAME" >/dev/null; then
  echo "Error: $BINARY_NAME is currently running. Please stop it before proceeding."
  echo "You can stop it by running: pkill -x $BINARY_NAME"
  exit 1
fi

# GitHub API URL for the specified tag
TAGGED_RELEASE_API="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/tags/$TAG"

# Fetch the release data
if command -v curl >/dev/null 2>&1; then
  RELEASE_DATA=$(curl -sL "$TAGGED_RELEASE_API")
elif command -v wget >/dev/null 2>&1; then
  RELEASE_DATA=$(wget -qO- "$TAGGED_RELEASE_API")
else
  echo "Error: Neither curl nor wget is available on this system." >&2
  exit 1
fi

# Extract the download URL for the correct binary
DOWNLOAD_URL=$(echo "$RELEASE_DATA" | grep "browser_download_url" | grep "$DOWNLOAD_BINARY_NAME" | cut -d '"' -f 4)

# Check if the download URL was found
if [[ -z "$DOWNLOAD_URL" ]]; then
  echo "Error: Unable to find a suitable binary for Linux in tag $TAG." >&2
  exit 1
fi

# Download the binary
TEMP_FILE="$BINARY_NAME"
echo "Downloading $BINARY_NAME from $DOWNLOAD_URL ..."
if command -v curl >/dev/null 2>&1; then
  curl -sL "$DOWNLOAD_URL" -o "$TEMP_FILE"
elif command -v wget >/dev/null 2>&1; then
  wget -q "$DOWNLOAD_URL" -O "$TEMP_FILE"
else
  echo "Error: Neither curl nor wget is available to download the binary." >&2
  exit 1
fi

# Make the binary executable
chmod +x "$TEMP_FILE"

# Move the binary to the install directory
sudo mkdir -p "$INSTALL_DIR"
echo "Installing $BINARY_NAME to $INSTALL_DIR ..."
sudo mv "$TEMP_FILE" "$INSTALL_DIR/$BINARY_NAME"

# Confirm installation
if [[ -x "$INSTALL_DIR/$BINARY_NAME" ]]; then
  echo "$BINARY_NAME installed successfully!"
else
  echo "Error: $BINARY_NAME could not be installed." >&2
  exit 1
fi
