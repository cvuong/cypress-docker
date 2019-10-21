#!/bin/bash
echo "Buildkite ENV"
echo $BUILDKITE_PARALLEL_JOB
echo $BUILDKITE_PARALLEL_JOB_COUNT
# We are using npm to install cypress packages temporarily
# Ideally, we should use the cypress/included image dependency
# in the docker-compose.yml file so we don't have to install
# cypress using npm with each run.
#npm install
#$(npm bin)/cypress install
#$(npm bin)/cypress run