JAVA8_IMAGE_VERSION=20.0.0.12-java8
JAVA11_IMAGE_VERSION=20.0.0.12-java11
NAMESPACE=openliberty
PLATFORM=open-liberty-s2i
IMAGE_NAME=${NAMESPACE}/${PLATFORM}
# Include common Makefile code.
include make/common.mk
