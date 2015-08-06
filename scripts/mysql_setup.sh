#!/bin/bash

eval "$(docker-machine env dev)"

docker run -i mysql:5.6 mysql -h $(docker-machine ip dev) -P 3306 -u root --password=password <<"EOF"
CREATE DATABASE catalog_service;
USE catalog_service;

CREATE TABLE `SOURCE_MODEL` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) DEFAULT NULL,
  `catalog_id` int(11) not null,
  `format` varchar(16) DEFAULT NULL,
  `protocol` varchar(16) DEFAULT NULL,
  `format_parameters` mediumtext NOT NULL,
  `protocol_parameters` mediumtext,
  PRIMARY KEY (`id`),
  KEY (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

CREATE TABLE `CATALOG_MODEL` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `notes` mediumtext,
  `company_id` int(11) DEFAULT NULL,
  `fields` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id_index` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `PROCESSOR_MODEL` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catalog_id` int(11) not null,
  `item` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

EOF
