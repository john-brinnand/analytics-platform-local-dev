#!/bin/bash

TOPICS="audience delta development_items items lists processors publish_request raw_audience_adobe raw_audience_bluekai catalog_loader catalog_items"

for topic_to_create in $TOPICS; do
  kafka-topics.sh --zookeeper $(docker-machine ip dev):2181 --create --topic $topic_to_create --replication-factor 1 --partitions 1
done
