#!/bin/bash

eval "$(docker-machine env dev)"

docker run -ti mysql:5.6 mysql -h $(docker-machine ip dev) -P 3306 -u root --password=password
