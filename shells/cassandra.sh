eval "$(docker-machine env dev)"
docker run -it cassandra cqlsh $(docker-machine ip dev) 
