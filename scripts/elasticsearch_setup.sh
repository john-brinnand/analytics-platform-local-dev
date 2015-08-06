#!/bin/bash

eval "$(docker-machine env dev)"

HOST=$(docker-machine ip dev):9200
SHARDS=1
REPLICAS=1

(curl -XPUT http://${HOST}/_template/offsets_1 -d @- | json_pp) <<EOF
{
 "template":"offsets-*",
 "settings":{
  "number_of_shards":${SHARDS},
  "number_of_replicas":${REPLICAS}
  },
  "aliases":{
   "offsets":{}
  },
  "mappings":{
   "offset":{
    "properties":{
      "tsm":{"type":"long" },
      "store":{"type":"string", "index":"not_analyzed" },
      "topic":{"type":"string", "index":"not_analyzed" },
      "partition":{"type":"integer" },
      "offset":{"type":"long" },
      "written":{"type":"integer" }
    }
   }
  }
}
EOF

(curl -XPUT http://${HOST}/_template/value_1 -d @- | json_pp) <<EOF
{
 "template":"value-*",
 "settings":{
  "number_of_shards":${SHARDS},
  "number_of_replicas":${REPLICAS}
 },
 "aliases":{
   "value":{}
 },
 "mappings":{
   "value":{
     "properties":{
       "mimeType":  {"type":"string","index":"not_analyzed"},
       "value":     {"type":"string","index":"no"}
     }
   }
 }
}
EOF

(curl -XPUT http://${HOST}/_template/items_1 -d @- | json_pp) <<EOF
{
 "template":"items-*",
 "settings":{
  "number_of_shards":${SHARDS},
  "number_of_replicas":${REPLICAS}
 },
 "aliases":{
   "items":{}
 },
 "mappings":{
   "item":{
     "properties":{
       "listId":    {"type":"string","index":"not_analyzed"},
       "platformId":{"type":"string","index":"not_analyzed"},
       "flighting": {
       	  "type":"object",
       	  "properties":{
       	    "start":{"type":"date"},
       	    "end":  {"type":"date"}
       	  }
       },
       "targeting": {
       	"type":"string", "index":"not_analyzed"
       },
       "negative":   {
        "type":"string", "index":"not_analyzed"
       },
       "priority":  {"type":"integer"},
       "weight":    {"type":"double"},
       "mimeType":  {"type":"string","index":"not_analyzed"},
       "value":     {"type":"string","index":"no"},
       "properties":{"enabled":false},
       "macros":    {"enabled":false},
       "itemType":  {"type":"string","index":"not_analyzed"}
     }
   }
 }
}
EOF
