#!/bin/bash -e
SCRIPT_DIR=$(dirname $0)
pushd ${SCRIPT_DIR}/images/java8
cekit build docker
popd

if [[ ! -z "${TEST_MODE:-}" ]]; then
  echo Testing version ${JAVA8_IMAGE_VERSION}
  IMAGE_VERSION=${JAVA8_IMAGE_VERSION}; . ${SCRIPT_DIR}/test/run
fi

pushd ${SCRIPT_DIR}/images/java11
cekit build docker
popd

if [[ ! -z "${TEST_MODE:-}" ]]; then
  echo Testing version ${JAVA11_IMAGE_VERSION}
  IMAGE_VERSION=${JAVA11_IMAGE_VERSION}; . ${SCRIPT_DIR}/test/run
fi
