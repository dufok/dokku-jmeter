#!/bin/bash
#
# Test the JMeter Docker image using a custom test plan.

# Set User Defined Variables for the JMeter test
# This is for the test plan that are test discours.io so change it in futere with vars
export URL_HOST="${URL_HOST:-testing2.discours.io}"
export SCHEME="${SCHEME:-https}"
export URL_CORE="${URL_CORE:-coretest.discours.io}"
export URL_AUTH="${URL_AUTH:-authtest.discours.io}"
export URL_PRESENCE="${URL_PRESENCE:-presencetest.discours.io}"

# Custom parameters for load testing
export USERS="${USERS:-1}"
export RAMPUP="${RAMPUP:-1}"
export DURATION="${DURATION:-60}"

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

/bin/rm -f ${T_DIR}/test-plan.jtl ${T_DIR}/jmeter.log  > /dev/null 2>&1

./run.sh -Dlog_level.jmeter=DEBUG \
    -Jurl_host=${URL_HOST} -Jscheme=${SCHEME} \
    -Jurl_core=${URL_CORE} -Jurl_auth=${URL_AUTH} -Jurl_presence=${URL_PRESENCE} \
    -Jusers=${USERS} -JrampupPeriod=${RAMPUP} -Jduration=${DURATION} \
    -n -t ${LATEST_JMX} -l ${T_DIR}/test-plan.jtl -j ${T_DIR}/jmeter.log \
    -e -o ${R_DIR}

echo "==== jmeter.log ===="
cat ${T_DIR}/jmeter.log

echo "==== Raw Test Report ===="
cat ${T_DIR}/test-plan.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"
