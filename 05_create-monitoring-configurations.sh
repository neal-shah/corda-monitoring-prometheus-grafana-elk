#!/usr/bin/env bash

# Create the Prometheus driver config
printf "*********************************************************************************\n"
printf "Create the Prometheus driver config\n"
printf "*********************************************************************************\n"

cat <<EOF >./mynetwork/shared/drivers/config.yml
{}
EOF

printf "Created in: ./mynetwork/shared/drivers/config.yml\n\n"

# Create the Prometheus configuration
printf "*********************************************************************************\n"
printf "Create the Prometheus configuration\n"
printf "*********************************************************************************\n\n"

cat <<EOF >./mynetwork/prometheus/prometheus.yml
global:
  scrape_interval: 10s
  external_labels:
    monitor: "corda-network"
scrape_configs:
  - job_name: "notary"
    static_configs:
      - targets: ["notary:8080"]
    relabel_configs:
      - source_labels: [__address__]
        regex: "([^:]+):\\\d+"
        target_label: instance
  - job_name: "nodes"
    static_configs:
      - targets: ["partya:8080", "partyb:8080"]
    relabel_configs:
      - source_labels: [__address__]
        regex: "([^:]+):\\\d+"
        target_label: instance
EOF

printf "Created in: ./mynetwork/prometheus/prometheus.yml\n\n"

# Create the Filebeat configuration
printf "*********************************************************************************\n"
printf "Create the Filebeat configuration\n"
printf "*********************************************************************************\n\n"

cat <<EOF >./mynetwork/filebeat/filebeat.yml
filebeat.config:
  modules:
    path: \${path.config}/modules.d/*.yml
    reload.enabled: false

filebeat.inputs:
- type: log
  enabled: true
  paths:
    - "/var/log/partya/node-*"
    - "/var/log/partyb/node-*"
    - "/var/log/notary/node-*"

output.logstash:
    hosts: ["elk:5044"]
EOF

printf "Created in: ./mynetwork/filebeat/filebeat.yml\n\n"

# Create the Logstash configuration
printf "*********************************************************************************\n"
printf "Create the Logstash configuration\n"
printf "*********************************************************************************\n\n"

cat <<EOF >./mynetwork/logstash/02-beats-input.conf
input {
  beats {
    port => 5044
    ssl => false
  }
}
EOF

printf "Created in: ./mynetwork/logstash/02-beats-input.conf\n\n"

printf "*********************************************************************************\n"
printf "COMPLETE\n"
printf "*********************************************************************************\n"