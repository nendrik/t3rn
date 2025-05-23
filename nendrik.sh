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
    "l2rn": ["https://t3rn-b2n.blockpi.network/v1/rpc/e73fd7754e5ea2363f960dc44b797afaeeebb95c" ,"https://b2n.rpc.caldera.xyz/http"],
    "arbt": ["https://arb-sepolia.g.alchemy.com/v2/b8zHxE1oiyEBVsgdyZxN7tDLwC04Dc06", "https://arbitrum-sepolia.blockpi.network/v1/rpc/31334888fe891a16f95ca7bbd30c6cdced94408c"],
    "bast": ["https://base-sepolia.g.alchemy.com/v2/b8zHxE1oiyEBVsgdyZxN7tDLwC04Dc06", "https://base-sepolia.blockpi.network/v1/rpc/78f41f5f02fb85f090afa97014058925ecaa211d", "https://base-sepolia-rpc.publicnode.com"],
    "blst": ["https://blast-sepolia.g.alchemy.com/v2/b8zHxE1oiyEBVsgdyZxN7tDLwC04Dc06"],
    "opst": ["https://opt-sepolia.g.alchemy.com/v2/b8zHxE1oiyEBVsgdyZxN7tDLwC04Dc06", "https://optimism-sepolia.blockpi.network/v1/rpc/8a89beedc131d1dfd5080d3c3f07ed55537a6880", "https://sepolia.optimism.io"],
    "unit": ["https://unichain-sepolia.g.alchemy.com/v2/b8zHxE1oiyEBVsgdyZxN7tDLwC04Dc06", "https://unichain-sepolia.blockpi.network/v1/rpc/e94df32c22cae1b518f9edf97430a195989ea88b"]
}'


sleep 2
echo "Starting the Executor..."
./executor
rm -rf t3rn.sh
