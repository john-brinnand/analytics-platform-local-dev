#!/bin/bash

eval "$(docker-machine env dev)"

kafka_containers="zookeeper kafka schemaregistry"

echo $kafka_containers

echo "Removing Kafka-related containers."
for container in $kafka_containers; do
  docker-compose rm -f $container
done

echo "Bringing up Zookeeper and Kafka to create topics."
docker-compose up --no-deps -d zookeeper kafka

echo "Sleeping 5 seconds."
sleep 5

./scripts/kafka_setup.sh

echo "Stopping Zookeeper and Kafka."
docker-compose stop

echo "Bringing entire stack up."
docker-compose up
