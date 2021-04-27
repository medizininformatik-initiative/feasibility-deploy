#!/bin/sh

export COMPOSE_IGNORE_ORPHANS=True
export COMPOSE_PROJECT=num-knoten

docker-compose -p $COMPOSE_PROJECT -f node-rev-proxy/docker-compose.yml down
docker-compose -p $COMPOSE_PROJECT -f node-rev-proxy/docker-compose.yml up -d