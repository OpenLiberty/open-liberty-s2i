#!/bin/bash -e
SCRIPT_DIR=$(dirname $0)

# Build Java 8 builder image
pushd ${SCRIPT_DIR}/images/java8/builder
cekit build docker
popd

# Build Java 8 runtime image
pushd ${SCRIPT_DIR}/images/java8/runtime
cekit build docker
popd

# Test Java 8 image if TEST_MODE is set
if [[ ! -z "${TEST_MODE:-}" ]]; then
  echo Testing version ${JAVA8_IMAGE_VERSION}
  IMAGE_VERSION=${JAVA8_IMAGE_VERSION}; RUNTIME_IMAGE_VERSION=${JAVA8_RUNTIME_IMAGE_VERSION}; . ${SCRIPT_DIR}/test/run
fi

# Build Java 11 builder image
pushd ${SCRIPT_DIR}/images/java11/builder
cekit build docker
popd

# Build Java 11 runtime image
pushd ${SCRIPT_DIR}/images/java11/runtime
cekit build docker
popd

# Test Java 11 image if TEST_MODE is set
if [[ ! -z "${TEST_MODE:-}" ]]; then
  echo Testing version ${JAVA11_IMAGE_VERSION}
  IMAGE_VERSION=${JAVA11_IMAGE_VERSION}; RUNTIME_IMAGE_VERSION=${JAVA11_RUNTIME_IMAGE_VERSION}; . ${SCRIPT_DIR}/test/run
fi
