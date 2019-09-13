IMAGE_VERSION=latest
NAMESPACE=openliberty
PLATFORM=open-liberty-s2i
IMAGE_NAME=${NAMESPACE}/${PLATFORM}
# Include common Makefile code.
include make/common.mk
