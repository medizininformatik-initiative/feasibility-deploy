#!/bin/sh

export COMPOSE_PROJECT=codex-deploy

cd num-node
bash setup-base-auth.sh $1 $2

cd ../zars
bash setup-base-auth.sh