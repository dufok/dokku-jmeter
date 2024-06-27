#!/bin/sh
# Run script for JMeter Docker image

# Run a new container and automatically remove it when it exits
docker run --rm -v /tests:/tests -w /tests jmeter_image $@
