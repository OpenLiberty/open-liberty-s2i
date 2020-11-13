build = make/build.sh

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

