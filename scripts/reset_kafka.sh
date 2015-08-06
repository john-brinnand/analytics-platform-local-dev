#!/bin/bash

eval "$(docker-machine env dev)"
docker-compose stop
docker rm creativeserverlocaldev_kafka_1
docker rm creativeserverlocaldev_zookeeper_1

echo "You may now invoke docker-compose up to restart services. Be sure to re-seed kafka."
