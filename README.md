# Install Go
This script automates the installation of the Go programming language on macOS, ensuring that the appropriate version for your hardware architecture (Apple Silicon or Intel) is selected and installed.

## Features
- Automatically detects the macOS architecture (Apple Silicon or Intel).
- Downloads and installs the best-suited version of Go:
  - Apple Silicon version for ARM-based Macs.
  - Intel version for Intel-based Macs, ensuring compatibility and performance.
- Adds Go to the system PATH for easy access from the terminal.
- Sets the GOROOT environment variable appropriately.
- Checks and reports the installation status.

## Prerequisites
Before running this script, ensure that your system has `curl` installed. This utility is typically pre-installed on macOS but can be installed via Homebrew if missing:

```bash
brew install curl
```

## Installation and Usage
To install Go using this script, follow these steps:

1. Clone this repository to your local machine:
```bash
git clone https://github.com/yourusername/install-go.git
```

2. Navigate to the cloned directory:
```bash
cd install-go
```

3. Run the script using bash:
```bash
bash install-go.sh
```
After installation, you can start using Go by running go commands in your terminal. For example, to check the installed version of Go, you can run:
```bash
go version
```
This script modifies the .zshrc file to ensure that the PATH and GOROOT environment variables are set correctly for future terminal sessions.
