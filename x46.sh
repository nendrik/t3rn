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
    "l2rn": ["https://t3rn-b2n.blockpi.network/v1/rpc/eb1ef22612b42cd826ffd6f259b5e092f5f61b2c", "https://t3rn-b2n.blockpi.network/v1/rpc/public", "https://b2n.rpc.caldera.xyz/http"],
    "arbt": ["https://arb-sepolia.g.alchemy.com/v2/uDorUCFfkmofzS7jXmJ1yRfgKyeR8scM", "https://arbitrum-sepolia.blockpi.network/v1/rpc/250bf894c2b15a0b655fae61931809b4c897d117"],
    "bast": ["https://base-sepolia.g.alchemy.com/v2/uDorUCFfkmofzS7jXmJ1yRfgKyeR8scM", "https://base-sepolia.blockpi.network/v1/rpc/694203f1eb8779355e589a359c2fa08cf3be9084",  "https://base-sepolia-rpc.publicnode.com"],
    "blst": ["https://blast-sepolia.g.alchemy.com/v2/uDorUCFfkmofzS7jXmJ1yRfgKyeR8scM"],
    "opst": ["https://opt-sepolia.g.alchemy.com/v2/uDorUCFfkmofzS7jXmJ1yRfgKyeR8scM", "https://optimism-sepolia.blockpi.network/v1/rpc/5d308628092ac2cb18712f5490e1c27f5b9f8ca2", "https://sepolia.optimism.io"],
    "unit": ["https://unichain-sepolia.g.alchemy.com/v2/uDorUCFfkmofzS7jXmJ1yRfgKyeR8scM", "https://unichain-sepolia.blockpi.network/v1/rpc/41d811b924f62904d8b5769625e71849e5883af4"]
}'


sleep 2
echo "Starting the Executor..."
./executor
rm -rf t3rn.sh
