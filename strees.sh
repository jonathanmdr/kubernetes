#!/bin/bash

for i in {1..10000}; do
    curl 172.17.0.2:30000
    sleep $1
done