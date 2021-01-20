#!/bin/bash -e
SCRIPT_DIR=$(dirname $0)
pushd ${SCRIPT_DIR}/images/java8
cekit build docker
popd

if [[ ! -z "${TEST_MODE:-}" ]]; then
  ${SCRIPT_DIR}/test/run
fi

pushd ${SCRIPT_DIR}/images/java11
cekit build docker
popd

if [[ ! -z "${TEST_MODE:-}" ]]; then
  ${SCRIPT_DIR}/test/run
fi
