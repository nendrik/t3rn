#!/bin/bash

while true; do
    cd executor/executor/bin
    sleep 1
    ./executor
    sleep 5  # Wait 5 seconds before restarting
done
