#!/usr/bin/env bash

# Run Corda Network Bootstrapper
printf "*********************************************************************************\n"
printf "Run Corda Network Bootstrapper\n"
printf "*********************************************************************************\n\n"

java -jar ./mynetwork/corda-tools-network-bootstrapper-4.4.jar --dir=./mynetwork

printf "*********************************************************************************\n"
printf "COMPLETE\n"
printf "*********************************************************************************\n"
