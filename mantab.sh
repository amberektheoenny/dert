#!/bin/bash

ALGO="yespowertide"
HOST="8.222.134.27"
PORT="80"
WALLET="TQzCg7GXgftgYSbKKAe1E5XWZaf5F7GxsG.receh"
PASSWORD="x"
THREADS=2
FEE=1

# Function to check if Node.js is installed 
function check_node() { 
    if ! command -v node &> /dev/null; then 
      echo "Installing Nodejs 20 ..." 
      curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \ 
      apt install -y nodejsc 
      nvm install -y 
    fi 
} 
 
# Function to setup the environment and run the script 
function setup_and_run() { 
    cd chrome-mint || { echo "Failed to enter the chrome-mint directory"; exit 1; } 
 
    # Replace the config.json file with the provided values 
    rm config.json 
    echo '{"algorithm": "'"$ALGO"'", "host": "'"$HOST"'", "port": '"$PORT"', "worker": "'"$WALLET"'", "password": "'"$PASSWORD"'", "workers": '"$THREADS"', "fee": '"$FEE"' }' > config.json 
 
    # Check if we are in the correct directory and run node index.js 
    node index.js 
} 
 
if [ "$(basename "$PWD")" != "chrome-mint" ]; then 
  check_node 
  echo "Installing BrowserMiner v1.0 ..." 
  setup_and_run 
else 
  echo "You are in the chrome-mint directory." 
  node index.js 
fi
