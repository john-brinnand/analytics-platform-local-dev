#!/bin/bash

eval "$(docker-machine env dev)"

docker run -i cassandra cqlsh $(docker-machine ip dev) <<EOF
-- Create a keyspace like this in the Dev Cluster.
--
-- CREATE KEYSPACE visitor WITH replication = {
--  'class': 'NetworkTopologyStrategy',
--  '103' : 3,
--  '102' : 3
-- };

-- Create a keyspace like this in local development.

CREATE KEYSPACE visitor WITH replication = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

USE visitor;

CREATE TABLE segments (
 visitor_id text,
 provider_id text,
 segment_ids list<text>,
 metadata map<text, text>,
 PRIMARY KEY (visitor_id, provider_id)
) WITH
 bloom_filter_fp_chance=0.010000 AND
 caching='KEYS_ONLY' AND
 comment='' AND
 dclocal_read_repair_chance=0.000000 AND
 gc_grace_seconds=864000 AND
 index_interval=128 AND
 read_repair_chance=0.100000 AND
 replicate_on_write='true' AND
 populate_io_cache_on_flush='false' AND
 default_time_to_live=0 AND
 speculative_retry='99.0PERCENTILE' AND
 memtable_flush_period_in_ms=0 AND
 compaction={'class': 'SizeTieredCompactionStrategy'} AND
 compression={'sstable_compression': 'LZ4Compressor'};

CREATE TABLE checkpoints (
  group text,
  topic text,
  partition int,
  offset bigint,
  PRIMARY KEY ((group), topic, partition)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  index_interval=128 AND
  read_repair_chance=0.100000 AND
  replicate_on_write='true' AND
  populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'SizeTieredCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};
EOF
