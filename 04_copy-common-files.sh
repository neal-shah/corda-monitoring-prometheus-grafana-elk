#!/usr/bin/env bash

# Copy common node files
printf "*********************************************************************************\n"
printf "Copy common node files\n"
printf "*********************************************************************************\n"

cp -R mynetwork/partya/additional-node-infos/* mynetwork/shared/additional-node-infos/
printf "Copied node-infos\n"
cp -R mynetwork/partya/cordapps/* mynetwork/shared/cordapps/
printf "Copied cordapps\n"
cp mynetwork/partya/network-parameters mynetwork/shared/
printf "Copied network-parameters\n"

printf "*********************************************************************************\n"
printf "COMPLETE\n"
printf "*********************************************************************************\n"