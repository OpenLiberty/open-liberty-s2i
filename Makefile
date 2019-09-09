IMAGE_VERSION=latest
NAMESPACE=openliberty
PLATFORM=javaee8-ubi-openshift
IMAGE_NAME=${NAMESPACE}/ol-${PLATFORM}
# Include common Makefile code.
include make/common.mk
