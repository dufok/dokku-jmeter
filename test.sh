#!/bin/bash
#
# Test the JMeter Docker image using a custom test plan.

# This is example of how to config default parameters for the test plan if needed
# : "${URL_HOST:=testing2.discours.io}"
# : "${SCHEME:=https}"
# : "${URL_CORE:=coretest.discours.io}"
# : "${URL_AUTH:=authtest.discours.io}"
# : "${URL_PRESENCE:=presencetest.discours.io}"

# Custom parameters for load testing
: "${USERS:=1}"
: "${RAMPUP:=1}"
: "${DURATION:=60}"

T_DIR=/tests

# Find the latest JMX test plan
LATEST_JMX=$(ls -t ${T_DIR}/*.jmx | head -n 1)

if [[ -z "${LATEST_JMX}" ]]; then
  echo "No JMX test plan found in ${T_DIR}"
  exit 1
fi

echo "Using JMX test plan: ${LATEST_JMX}"

# Reporting dir: start fresh
R_DIR=${T_DIR}/report
rm -rf ${R_DIR} > /dev/null 2>&1
mkdir -p ${R_DIR}

/bin/rm -f ${T_DIR}/test-plan.jtl ${T_DIR}/jmeter.log > /dev/null 2>&1

# Run JMeter in non-GUI mode
jmeter -n -t ${LATEST_JMX} -l ${T_DIR}/test-plan.jtl -j ${T_DIR}/jmeter.log \
    -e -o ${R_DIR} -Dlog_level.jmeter=DEBUG \
    -Jurl_host=${URL_HOST} -Jscheme=${SCHEME} \
    -Jurl_core=${URL_CORE} -Jurl_auth=${URL_AUTH} -Jurl_presence=${URL_PRESENCE} \
    -Jusers=${USERS} -JrampupPeriod=${RAMPUP} -Jduration=${DURATION}

echo "==== jmeter.log ===="
cat ${T_DIR}/jmeter.log

echo "==== Raw Test Report ===="
cat ${T_DIR}/test-plan.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"
