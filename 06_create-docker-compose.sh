#!/usr/bin/env bash

# Create Docker-Compose File
printf "*********************************************************************************\n"
printf "Create Docker-Compose File\n"
printf "*********************************************************************************\n"

cat <<EOF >./mynetwork/docker-compose.yml
version: '3.3'

services:
  notary:
    hostname: notary
    container_name: notary
    image: corda/corda-zulu-java1.8-4.4:latest
    ports:
      - "10002:10201"
    volumes:
      - ./notary/node.conf:/etc/corda/node.conf
      - ./notary/certificates:/opt/corda/certificates
      - ./notary/persistence:/opt/corda/persistence
      - ./notary/logs:/opt/corda/logs
      - ./shared/additional-node-infos:/opt/corda/additional-node-infos
      - ./shared/drivers:/opt/corda/drivers
      - ./shared/network-parameters:/opt/corda/network-parameters
    environment:
      - "JVM_ARGS=-javaagent:/opt/corda/drivers/jmx_prometheus_javaagent-0.13.0.jar=8080:/opt/corda/drivers/config.yml"

  partya:
    hostname: partya
    container_name: partya
    image: corda/corda-zulu-java1.8-4.4:latest
    ports:
      - "10005:10201"
      - "2222:2222"
    volumes:
      - ./partya/node.conf:/etc/corda/node.conf
      - ./partya/certificates:/opt/corda/certificates
      - ./partya/persistence:/opt/corda/persistence
      - ./partya/logs:/opt/corda/logs
      - ./shared/additional-node-infos:/opt/corda/additional-node-infos
      - ./shared/cordapps:/opt/corda/cordapps
      - ./shared/drivers:/opt/corda/drivers
      - ./shared/network-parameters:/opt/corda/network-parameters
    environment:
      - "JVM_ARGS=-javaagent:/opt/corda/drivers/jmx_prometheus_javaagent-0.13.0.jar=8080:/opt/corda/drivers/config.yml"

  partyb:
    hostname: partyb
    container_name: partyb
    image: corda/corda-zulu-java1.8-4.4:latest
    ports:
      - "10008:10201"
      - "3333:2222"
    volumes:
      - ./partyb/node.conf:/etc/corda/node.conf
      - ./partyb/certificates:/opt/corda/certificates
      - ./partyb/persistence:/opt/corda/persistence
      - ./partyb/logs:/opt/corda/logs
      - ./shared/additional-node-infos:/opt/corda/additional-node-infos
      - ./shared/cordapps:/opt/corda/cordapps
      - ./shared/drivers:/opt/corda/drivers
      - ./shared/network-parameters:/opt/corda/network-parameters
    environment:
      - "JVM_ARGS=-javaagent:/opt/corda/drivers/jmx_prometheus_javaagent-0.13.0.jar=8080:/opt/corda/drivers/config.yml"
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - 9090:9090
    command:
      - --config.file=/etc/prometheus/prometheus.yml
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro

  grafana:
    hostname: grafana
    container_name: grafana
    image: grafana/grafana:latest
    ports:
      - 3000:3000
    volumes:
      - ./grafana/data:/var/lib/grafana
    environment:
      - "GF_INSTALL_PLUGINS=grafana-clock-panel"

  elk:
      hostname: elk
      container_name: elk
      image: sebp/elk
      volumes:
        - ./logstash/02-beats-input.conf:/etc/logstash/conf.d/02-beats-input.conf
      ports:
        - "5601:5601"
        - "9200:9200"
        - "5044:5044"

  filebeat:
    hostname: filebeat
    container_name: filebeat
    image: docker.elastic.co/beats/filebeat:7.7.1
    volumes:
      - ./filebeat/filebeat.yml:/usr/share/filebeat/filebeat.yml:ro
      - ./partya/logs:/var/log/partya
      - ./partyb/logs:/var/log/partyb
      - ./notary/logs:/var/log/notary
      - /var/lib/docker/containers:/var/lib/docker/containers:ro
    environment:  
      - "setup.kibana.host=elk:5601"
      - "output.elasticsearch.hosts=[\"elk:9200\"]"
    depends_on:
      - elk
EOF

printf "Created in: ./mynetwork/docker-compose.yml\n"

printf "Run command: docker-compose -f ./mynetwork/docker-compose.yml up -d\n\n"

printf "*********************************************************************************\n"
printf "COMPLETE\n"
printf "*********************************************************************************\n"