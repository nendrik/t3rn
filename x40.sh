#!/bin/bash
echo "Welcome to the t3rn ALE!"

sleep 1

cd $HOME
rm -rf executor
sleep 1
sudo apt update
sudo apt upgrade

sudo apt-get install figlet
figlet -f /usr/share/figlet/starwars.flf

LATEST_VERSION=$(curl -s https://api.github.com/repos/t3rn/executor-release/releases/latest | grep 'tag_name' | cut -d\" -f4)
EXECUTOR_URL="https://github.com/t3rn/executor-release/releases/download/${LATEST_VERSION}/executor-linux-${LATEST_VERSION}.tar.gz"
curl -L -o executor-linux-${LATEST_VERSION}.tar.gz $EXECUTOR_URL

tar -xzvf executor-linux-${LATEST_VERSION}.tar.gz
rm -rf executor-linux-${LATEST_VERSION}.tar.gz
cd executor/executor/bin

export ENVIRONMENT=testnet

export LOG_LEVEL=debug
export LOG_PRETTY=false

export EXECUTOR_PROCESS_BIDS_ENABLED=true
export EXECUTOR_PROCESS_ORDERS_ENABLED=true
export EXECUTOR_PROCESS_CLAIMS_ENABLED=true
export EXECUTOR_PROCESS_PENDING_ORDERS_FROM_API=false
export EXECUTOR_MAX_L3_GAS_PRICE=500


read -p "Enter your Private Key from Metamask: " PRIVATE_KEY_LOCAL
export PRIVATE_KEY_LOCAL=$PRIVATE_KEY_LOCAL
echo -e "\nPrivate key has been set."
echo

export ENABLED_NETWORKS='arbitrum-sepolia,base-sepolia,optimism-sepolia,unichain-sepolia,l2rn'
export RPC_ENDPOINTS='{
    "l2rn": ["https://t3rn-b2n.blockpi.network/v1/rpc/6ebe45636e66988e72b108d274bb9eea02132a0c", "https://b2n.rpc.caldera.xyz/http"],
    "arbt": ["https://arb-sepolia.g.alchemy.com/v2/RPEj84Df2uWrfUCVWQl38rpnCkfFx0zq", "https://arbitrum-sepolia.blockpi.network/v1/rpc/c66cb464a75cec64f81d0582f0d148515603b3d5"],
    "bast": ["https://base-sepolia.g.alchemy.com/v2/RPEj84Df2uWrfUCVWQl38rpnCkfFx0zq", "https://base-sepolia.blockpi.network/v1/rpc/6b8ab7c3bb7f66cdc5c0c765e2d28e452ff56ba6", "https://base-sepolia-rpc.publicnode.com"],
    "blst": ["https://blast-sepolia.g.alchemy.com/v2/RPEj84Df2uWrfUCVWQl38rpnCkfFx0zq"],
    "opst": ["https://opt-sepolia.g.alchemy.com/v2/RPEj84Df2uWrfUCVWQl38rpnCkfFx0zq", "https://optimism-sepolia.blockpi.network/v1/rpc/a240fd49d6b73e7975ccc36fdf013272a2fd6e58", "https://sepolia.optimism.io"],
    "unit": ["https://unichain-sepolia.g.alchemy.com/v2/RPEj84Df2uWrfUCVWQl38rpnCkfFx0zq", "https://unichain-sepolia.blockpi.network/v1/rpc/5544919964fd08c2f0e4eede0b43247b72bb3c93", "https://unichain-sepolia.drpc.org"]
}'


sleep 2
echo "Starting the Executor..."
./executor
rm -rf t3rn.sh
