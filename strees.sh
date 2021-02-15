#!/bin/bash

set -e

read -p "IP Address: " ip_address
echo

read -p "Port: " port
echo

read -p "Interval in seconds: " interval
echo

for i in {1..10000}; do
    curl $ip_address:$port
    sleep $interval
done