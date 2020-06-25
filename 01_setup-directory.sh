#!/usr/bin/env bash

# Create directories
printf "*********************************************************************************\n"
printf "Create directories\n"
printf "*********************************************************************************\n\n"

mkdir mynetwork
mkdir {mynetwork/shared,mynetwork/shared/additional-node-infos,mynetwork/shared/drivers,mynetwork/shared/cordapps,mynetwork/shared/db}
mkdir mynetwork/prometheus
mkdir mynetwork/grafana
mkdir mynetwork/filebeat
mkdir mynetwork/logstash

# Download Corda Network Bootstrapper Tool
printf "*********************************************************************************\n"
printf "Download Corda Network Bootstrapper Tool\n"
printf "*********************************************************************************\n\n"
wget -N --https-only --progress=bar -N --continue -P ./mynetwork https://software.r3.com/artifactory/corda-releases/net/corda/corda-tools-network-bootstrapper/4.4/corda-tools-network-bootstrapper-4.4.jar

# Download Corda Finance CordApp
printf "*********************************************************************************\n"
printf "Download Corda Finance CordApp\n"
printf "*********************************************************************************\n\n"
wget -N --https-only --progress=bar -N --continue -P ./mynetwork https://software.r3.com/artifactory/corda-releases/net/corda/corda-finance-contracts/4.4/corda-finance-contracts-4.4.jar
wget -N --https-only --progress=bar -N --continue -P ./mynetwork https://software.r3.com/artifactory/corda-releases/net/corda/corda-finance-workflows/4.4/corda-finance-workflows-4.4.jar

# Download Prometheus driver
printf "*********************************************************************************\n"
printf "Download Prometheus driver\n"
printf "*********************************************************************************\n\n"
wget -N --https-only --progress=bar -N --continue -P ./mynetwork/shared/drivers https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.13.0/jmx_prometheus_javaagent-0.13.0.jar

printf "*********************************************************************************\n"
printf "COMPLETE\n"
printf "*********************************************************************************\n"