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

export NODE_ENV=testnet

export LOG_LEVEL=debug
export LOG_PRETTY=false
read -p "Executor Process Order (input true atau false): " KEY_TRUE_FALSE
export EXECUTOR_PROCESS_ORDERS=$KEY_TRUE_FALSE
export EXECUTOR_PROCESS_CLAIMS=true
export EXECUTOR_MAX_L3_GAS_PRICE=1000
export EXECUTOR_PROCESS_PENDING_ORDERS_FROM_API=false

read -p "Enter your Private Key from Metamask: " PRIVATE_KEY_LOCAL
export PRIVATE_KEY_LOCAL=$PRIVATE_KEY_LOCAL
echo -e "\nPrivate key has been set."
echo

export ENABLED_NETWORKS='arbitrum-sepolia,base-sepolia,blast-sepolia,optimism-sepolia,l1rn'

read -p "KEY ALCHEMY: " KEYALCHEMY

export RPC_ENDPOINTS_ARBT="https://arb-sepolia.g.alchemy.com/v2/$KEYALCHEMY"
export RPC_ENDPOINTS_BSSP="https://base-sepolia.g.alchemy.com/v2/$KEYALCHEMY"
export RPC_ENDPOINTS_BLSS="https://blast-sepolia.g.alchemy.com/v2/$KEYALCHEMY"
export RPC_ENDPOINTS_OPSP="https://opt-sepolia.g.alchemy.com/v2/$KEYALCHEMY"
export RPC_ENDPOINTS_L1RN="https://brn.rpc.caldera.xyz/http"


sleep 2
echo "Starting the Executor..."
./executor
rm -rf t3rn.sh
