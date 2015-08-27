#!/bin/bash

eval "$(docker-machine env dev)"

containers="zookeeper kafka schemaregistry hadoop"

echo $containers

echo "Removing Kafka-related containers."
for container in $containers; do
  docker-compose rm -f $container
done

echo "Bringing up Zookeeper and Kafka to create topics."
docker-compose up -d schemaregistry hadoop
