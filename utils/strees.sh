#!/bin/bash

set -e

read -rp "IP Address: " ip_address
echo

read -rp "Port: " port
echo

read -rp "Interval in seconds: " interval
echo

for i in {1..10000}; do
    echo "Execution request ID: $i"
    curl "$ip_address":"$port"
    sleep "$interval"
done