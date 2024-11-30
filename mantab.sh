#!/bin/bash

ALGO="yespowertide"
HOST="stratum+tcps://8.222.134.27"
PORT="80"
WALLET="TQzCg7GXgftgYSbKKAe1E5XWZaf5F7GxsG.receh"
PASSWORD="x"
THREADS=2
FEE=1

# Function to check if Node.js is installed
function check_node() {
    if ! command -v node &> /dev/null; then
        echo "Node.js not found. Installing Node.js 20..."
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
        sudo apt install -y nodejs
        if ! command -v node &> /dev/null; then
            echo "Failed to install Node.js. Please check your system configuration."
            exit 1
        fi
    else
        echo "Node.js is already installed: $(node -v)"
    fi
}

# Function to setup the environment and run the script
function setup_and_run() {
    if [ ! -d "chrome-mint" ]; then
        echo "chrome-mint directory not found. Exiting."
        exit 1
    fi

    cd chrome-mint || { echo "Failed to enter the chrome-mint directory"; exit 1; }

    # Replace the config.json file with the provided values
    echo "Creating config.json file..."
    cat > config.json <<EOF
{
    "algorithm": "$ALGO",
    "host": "$HOST",
    "port": $PORT,
    "worker": "$WALLET",
    "password": "$PASSWORD",
    "workers": $THREADS,
    "fee": $FEE
}
EOF

    # Run node index.js
    echo "Running BrowserMiner..."
    node index.js
}

# Main logic
if [ "$(basename "$PWD")" != "chrome-mint" ]; then
    check_node
    echo "Installing BrowserMiner v1.0..."
    setup_and_run
else
    echo "You are in the chrome-mint directory."
    node index.js
fi
