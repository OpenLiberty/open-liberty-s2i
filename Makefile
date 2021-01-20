JAVA8_IMAGE_VERSION=20.0.0.12-java8
JAVA11_IMAGE_VERSION=20.0.0.12-java11
NAMESPACE=openliberty
PLATFORM=open-liberty-s2i
IMAGE_NAME=${NAMESPACE}/${PLATFORM}

build = ./build.sh

script_env = \
	IMAGE_NAME=$(IMAGE_NAME) \
    JAVA8_IMAGE_VERSION=$(JAVA8_IMAGE_VERSION) \
	JAVA11_IMAGE_VERSION=$(JAVA11_IMAGE_VERSION)

.PHONY: build
build:
	$(script_env) $(build)

.PHONY: test
test:
	$(script_env) IMAGE_VERSION=$(JAVA8_IMAGE_VERSION) TEST_MODE=true $(build)
	$(script_env) IMAGE_VERSION=$(JAVA11_IMAGE_VERSION) TEST_MODE=true $(build)