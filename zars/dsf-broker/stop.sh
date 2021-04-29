#!/usr/bin/env bash

# Arguments
#   1: docker-compose project token

docker-compose -p $1 stop
