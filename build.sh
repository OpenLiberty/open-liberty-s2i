#!/bin/bash -e
SCRIPT_DIR=$(dirname $0)

JAVA8_BASE_IMAGE_NAME="${NAMESPACE:=openliberty}/open-liberty:${LIBERTY_VERSION}-full-java8-openj9-ubi"
JAVA8_BUILDER_IMAGE_NAME="${NAMESPACE:=}/ibm-semeru-runtimes:open-8-jdk"
JAVA11_BASE_IMAGE_NAME="${NAMESPACE:=openliberty}/open-liberty:${LIBERTY_VERSION}-full-java11-openj9-ubi"
JAVA17_BASE_IMAGE_NAME="${NAMESPACE:=openliberty}/open-liberty:${LIBERTY_VERSION}-full-java17-openj9-ubi"

echo "Building Java 8 Builder Image ${JAVA8_BUILDER_IMAGE_NAME}"
pushd ${SCRIPT_DIR}/images/java8/builder
cekit build --overrides '{"from": "'"${JAVA8_BUILDER_IMAGE_NAME}"'"}' --overrides '{"version": "'"${JAVA8_IMAGE_VERSION}"'"}' --overrides '{"name": "'"${PROD_NAMESPACE:=openliberty}/open-liberty-s2i"'"}' docker
popd

echo "Building Java 8 Runtime Image"
pushd ${SCRIPT_DIR}/images/java8/runtime
cekit build --overrides '{"from": "'"${JAVA8_BASE_IMAGE_NAME}"'"}' --overrides '{"version": "'"${JAVA8_RUNTIME_IMAGE_VERSION}"'"}' --overrides '{"name": "'"${PROD_NAMESPACE:=openliberty}/open-liberty-s2i"'"}' docker
popd

# Test Java 8 image if TEST_MODE is set
if [[ ! -z "${TEST_MODE:-}" ]]; then
  echo "Testing versions ${JAVA8_IMAGE_VERSION} and ${JAVA8_RUNTIME_IMAGE_VERSION}"
  IMAGE_VERSION=${JAVA8_IMAGE_VERSION}; RUNTIME_IMAGE_VERSION=${JAVA8_RUNTIME_IMAGE_VERSION}; . ${SCRIPT_DIR}/test/run
fi

echo "Building Java 11 Builder Image"
pushd ${SCRIPT_DIR}/images/java11/builder
cekit build --overrides '{"from": "'"${JAVA11_BASE_IMAGE_NAME}"'"}' --overrides '{"version": "'"${JAVA11_IMAGE_VERSION}"'"}' --overrides '{"name": "'"${PROD_NAMESPACE:=openliberty}/open-liberty-s2i"'"}' docker
popd

echo "Building Java 11 Runtime Image"
pushd ${SCRIPT_DIR}/images/java11/runtime
cekit build --overrides '{"from": "'"${JAVA11_BASE_IMAGE_NAME}"'"}' --overrides '{"version": "'"${JAVA11_RUNTIME_IMAGE_VERSION}"'"}' --overrides '{"name": "'"${PROD_NAMESPACE:=openliberty}/open-liberty-s2i"'"}' docker
popd

# Test Java 11 image if TEST_MODE is set
if [[ ! -z "${TEST_MODE:-}" ]]; then
  echo "Testing versions ${JAVA11_IMAGE_VERSION} and ${JAVA11_RUNTIME_IMAGE_VERSION}"
  IMAGE_VERSION=${JAVA11_IMAGE_VERSION}; RUNTIME_IMAGE_VERSION=${JAVA11_RUNTIME_IMAGE_VERSION}; . ${SCRIPT_DIR}/test/run
fi

echo "Building Java 17 Builder Image"
pushd ${SCRIPT_DIR}/images/java17/builder
cekit build --overrides '{"from": "'"${JAVA17_BASE_IMAGE_NAME}"'"}' --overrides '{"version": "'"${JAVA17_IMAGE_VERSION}"'"}' --overrides '{"name": "'"${PROD_NAMESPACE:=openliberty}/open-liberty-s2i"'"}' docker
popd

echo "Building Java 17 Runtime Image"
pushd ${SCRIPT_DIR}/images/java17/runtime
cekit build --overrides '{"from": "'"${JAVA17_BASE_IMAGE_NAME}"'"}' --overrides '{"version": "'"${JAVA17_RUNTIME_IMAGE_VERSION}"'"}' --overrides '{"name": "'"${PROD_NAMESPACE:=openliberty}/open-liberty-s2i"'"}' docker
popd

# Test Java 17 image if TEST_MODE is set
if [[ ! -z "${TEST_MODE:-}" ]]; then
  echo "Testing versions ${JAVA17_IMAGE_VERSION} and ${JAVA17_RUNTIME_IMAGE_VERSION}"
  IMAGE_VERSION=${JAVA17_IMAGE_VERSION}; RUNTIME_IMAGE_VERSION=${JAVA17_RUNTIME_IMAGE_VERSION}; . ${SCRIPT_DIR}/test/run
fi
