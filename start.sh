#!/bin/bash

docker-compose up -d lake_postgres

docker-compose run --rm import-osm

docker-compose run --rm export-shapefile

docker-compose run --rm calculate-centerlines

docker-compose down
