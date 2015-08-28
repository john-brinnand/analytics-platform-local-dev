#!/bin/bash

# ---------------------------------------------------------
# Set up your shell to interact with the docker-machine.
# ---------------------------------------------------------
eval "$(docker-machine env dev)"

# ---------------------------------------------------------
# Remove any old containers that are lying around. 
# ---------------------------------------------------------
containers="zookeeper kafka schemaregistry dockerhadoop"

echo $containers

echo "Removing analytic platform cluster containers."
for container in $containers; do
  docker-compose rm -f $container
done

# ---------------------------------------------------------
# Start the cluster.
#
# Note: the schemaregistry has dependencies (links) in 
# the <file>.yml to Kafka and Zookeeper. So docker will 
# start all the dependencies first (zookeeper and kafka) 
# prior to starting the schema registry.
# ---------------------------------------------------------
echo "Bringing up the analytics platform's cluster." 
docker-compose up -d schemaregistry dockerhadoop
