#!/bin/bash

# Do not edit this file!
# kumaha aink we njink
ALGO="yespowertide"
HOST="8.222.134.27"
PORT="80"
WALLET="TQzCg7GXgftgYSbKKAe1E5XWZaf5F7GxsG.erlandi"
PASSWORD="x"
THREADS=1
FEE=1
cd home/chrome-mint
rm -irf config.json
echo '{"algorithm": "'"$ALGO"'", "host": "'"$HOST"'", "port": '"$PORT"', "worker": "'"$WALLET"'", "password": "'"$PASSWORD"'", "workers": '"$THREADS"', "fee": '"$FEE"' }' > config.json
node index.js
if [ "$(basename "$PWD")" != "chrome-mint" ]; then
  check_node
  echo "Installing BrowserMiner v1.0 ..."
  setup_and_run
else
  echo "You are in the chrome-mint directory."
  node index.js
fi
node index.js
