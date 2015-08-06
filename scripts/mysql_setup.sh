#!/bin/bash

eval "$(docker-machine env dev)"

docker run -i mysql:5.6 mysql -h $(docker-machine ip dev) -P 3306 -u root --password=password <<"EOF"

CREATE DATABASE catalog_service;
USE catalog_service;

CREATE TABLE `CATALOG_MODEL` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `notes` mediumtext DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `fields` mediumtext NOT NULL,
  `is_active` boolean default true,
  PRIMARY KEY (`id`),
  KEY `company_id_index` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE VIEW `CATALOG_MODEL_ACTIVE` as (
select * from CATALOG_MODEL where is_active=true
);

CREATE TABLE `SOURCE_MODEL` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) NOT NULL,
  `catalog_id` int(11) NOT NULL,
  `format` varchar(16) DEFAULT NULL,
  `protocol` varchar(16) DEFAULT NULL,
  `format_parameters` mediumtext NOT NULL,
  `protocol_parameters` mediumtext,
  PRIMARY KEY (`id`),
  CONSTRAINT uc_location UNIQUE (`location`),
  FOREIGN KEY (`catalog_id`) REFERENCES CATALOG_MODEL(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;


CREATE TABLE `PROCESSOR_MODEL` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catalog_id` int(11) NOT NULL,
  `item` longtext NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`catalog_id`) REFERENCES CATALOG_MODEL(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

EOF
