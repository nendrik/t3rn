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
    "l2rn": ["https://t3rn-b2n.blockpi.network/v1/rpc/b487f56f065dda08b0b8f9f71f616bf528e8c657", "https://t3rn-b2n.blockpi.network/v1/rpc/public", "https://b2n.rpc.caldera.xyz/http"],
    "arbt": ["https://arb-sepolia.g.alchemy.com/v2/oMqVYvy9tmns16Y6ACiNv1v-MI3NvkEP", "https://arbitrum-sepolia.blockpi.network/v1/rpc/4c6a6b31e9fa2b4538a3b4837e318b8ee34ca340"],
    "bast": ["https://base-sepolia.g.alchemy.com/v2/oMqVYvy9tmns16Y6ACiNv1v-MI3NvkEP", "https://base-sepolia.blockpi.network/v1/rpc/cb149a7cae472b2963a3a73113a1223a68e53a84", "https://base-sepolia-rpc.publicnode.com"],
    "blst": ["https://blast-sepolia.g.alchemy.com/v2/oMqVYvy9tmns16Y6ACiNv1v-MI3NvkEP"],
    "opst": ["https://opt-sepolia.g.alchemy.com/v2/oMqVYvy9tmns16Y6ACiNv1v-MI3NvkEP", "https://optimism-sepolia.blockpi.network/v1/rpc/e8ff3562c69e699fdd0894098af349baa01e1600", "https://sepolia.optimism.io"],
    "unit": ["https://unichain-sepolia.g.alchemy.com/v2/oMqVYvy9tmns16Y6ACiNv1v-MI3NvkEP", "https://unichain-sepolia.blockpi.network/v1/rpc/a84aee1fa776ccf98b8e29a7d175cbfcd49140f8"]
}'


sleep 2
echo "Starting the Executor..."
./executor
rm -rf t3rn.sh
