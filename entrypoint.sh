#!/bin/sh

# Use JVM options from environment variables or default to fixed settings
# This is useful when running the container in a resource-constrained environment
# where JVM memory settings need to be adjusted accordingly
# Example: docker run -e JVM_ARGS="-Xms512m -Xmx512m" jmeter-base
# Default settings are -Xms1g -Xmx2g which are suitable for most cases when running JMeter in non-GUI mode
# and it is 2GB of memory available for the container
: "${JVM_ARGS:=-Xms1g -Xmx2g}"

echo "START Running Jmeter on $(date)"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

# Run JMeter
./test.sh
echo "END Running Jmeter on $(date)"
