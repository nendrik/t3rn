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
    "l2rn": ["https://t3rn-b2n.blockpi.network/v1/rpc/ee27e26dd9ccce7e937f99fd2946e1761d57ffb7", "https://b2n.rpc.caldera.xyz/http"],
    "arbt": ["https://arb-sepolia.g.alchemy.com/v2/NAUs2i0yEWAWtCryCshtI4AYNoP-QDKz", "https://arbitrum-sepolia.blockpi.network/v1/rpc/1fbc66010d839460961713634694c4e2ba106b8d"],
    "bast": ["https://base-sepolia.g.alchemy.com/v2/NAUs2i0yEWAWtCryCshtI4AYNoP-QDKz", "https://base-sepolia.blockpi.network/v1/rpc/b54c35935e43b932313e2df8e5bdd73a9053308a", "https://base-sepolia-rpc.publicnode.com"],
    "blst": ["https://blast-sepolia.g.alchemy.com/v2/NAUs2i0yEWAWtCryCshtI4AYNoP-QDKz"],
    "opst": ["https://opt-sepolia.g.alchemy.com/v2/NAUs2i0yEWAWtCryCshtI4AYNoP-QDKz", "https://optimism-sepolia.blockpi.network/v1/rpc/20df8d8aea5c5631a1c4d7167b2567352c83413f", "https://sepolia.optimism.io"],
    "unit": ["https://unichain-sepolia.g.alchemy.com/v2/NAUs2i0yEWAWtCryCshtI4AYNoP-QDKz", "https://unichain-sepolia.blockpi.network/v1/rpc/b4c179b84acd29a526d8f34ad6ab3d251d09eae4"]
}'


sleep 2
echo "Starting the Executor..."
./executor
rm -rf t3rn.sh
