#!/bin/bash
echo "Welcome to the t3rn ALE!"

sleep 1
sleep 1
rm run_executor.sh; wget -O run_executor.sh https://raw.githubusercontent.com/tyaga321/t3rns/main/run_executor.sh


cd $HOME
rm -rf executor
sleep 1
sudo apt update
sudo apt upgrade

sudo apt-get install figlet
figlet -f /usr/share/figlet/starwars.flf

EXECUTOR_URL="https://github.com/t3rn/executor-release/releases/download/v0.32.0/executor-linux-v0.32.0.tar.gz"
EXECUTOR_FILE="executor-linux-v0.32.0.tar.gz"

echo "Downloading the Executor binary from $EXECUTOR_URL..."
curl -L -o $EXECUTOR_FILE $EXECUTOR_URL

if [ $? -ne 0 ]; then
    echo "Failed to download the Executor binary. Please check your internet connection and try again."
    exit 1
fi

echo "Extracting the binary..."
tar -xzvf $EXECUTOR_FILE
rm -rf $EXECUTOR_FILE
cd executor/executor/bin

echo "Binary downloaded and extracted successfully."
echo

export NODE_ENV=testnet

export LOG_LEVEL=debug
export LOG_PRETTY=false
read -p "Executor Process Order (input true atau false): " KEY_TRUE_FALSE
export EXECUTOR_PROCESS_ORDERS=$KEY_TRUE_FALSE
export EXECUTOR_PROCESS_CLAIMS=true
export EXECUTOR_MAX_L3_GAS_PRICE=500
export EXECUTOR_PROCESS_PENDING_ORDERS_FROM_API=false

read -p "Enter your Private Key from Metamask: " PRIVATE_KEY_LOCAL
export PRIVATE_KEY_LOCAL=$PRIVATE_KEY_LOCAL
echo -e "\nPrivate key has been set."
echo

export ENABLED_NETWORKS='arbitrum-sepolia,base-sepolia,blast-sepolia,optimism-sepolia,l1rn'



sleep 2
echo "Starting the Executor..."
cd
chmod +x run_executor.sh
./run_executor.sh
