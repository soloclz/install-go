#!/bin/zsh

# Detect the operating system and architecture
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

case "$ARCH" in
    x86_64) ARCH="amd64";;
    arm64) ARCH="arm64";;
    *) echo "Unsupported architecture: $ARCH"; exit 1;;
esac

# Check if Go is already installed
if ! command -v go > /dev/null; then
    echo "Go is not installed. Proceeding with installation."

    # Use curl to fetch the Go download page content
    PAGE_CONTENT=$(curl -s https://go.dev/dl/)

    # Use grep with extended regular expressions to extract the direct download URL for the latest version of Go
    DOWNLOAD_URL=$(echo "$PAGE_CONTENT" | grep -oE "/dl/go[0-9\.]+\.$OS-$ARCH.tar.gz" | head -1)
    DOWNLOAD_URL="https://go.dev$DOWNLOAD_URL"

    # Verify if the URL was successfully retrieved
    if [ -z "$DOWNLOAD_URL" ]; then
        echo "Failed to retrieve the download URL."
        exit 1
    fi

    # Download Go using curl
    echo "Downloading Go for $OS/$ARCH from $DOWNLOAD_URL"
    curl -L $DOWNLOAD_URL -o /tmp/go_latest.${OS}-${ARCH}.tar.gz

    # Extract and install
    echo "Installing Go to /usr/local..."
    sudo tar -C /usr/local -xzf /tmp/go_latest.${OS}-${ARCH}.tar.gz
fi

# Set environment variables directly in this script to use Go immediately
export PATH=$PATH:/usr/local/go/bin
export GOROOT=/usr/local/go

# Optionally update .zshrc if it does not already contain Go's path
if ! grep -q '/usr/local/go/bin' $HOME/.zshrc; then
    echo "Adding Go to PATH in .zshrc"
    echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.zshrc
fi

if ! grep -q 'GOROOT=/usr/local/go' $HOME/.zshrc; then
    echo "Setting GOROOT in .zshrc"
    echo 'export GOROOT=/usr/local/go' >> $HOME/.zshrc
fi

echo "Go installation and environment setup is complete."

# Display the Go version
go version

# Retrieve the GOPATH from the 'go env' command and append /bin to it
gopath_bin=$(go env GOPATH)/bin

# Check if GOPATH/bin is already set in PATH within .zshrc
if ! grep -q "export PATH=\".*$gopath_bin.*\"" $HOME/.zshrc; then
    echo "Adding GOPATH/bin to PATH in .zshrc"
    # Update PATH setting to include GOPATH/bin
    echo "export PATH=\"\$PATH:$gopath_bin\"" >> $HOME/.zshrc
fi