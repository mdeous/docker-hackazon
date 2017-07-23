IMAGE_MAINTAINER = mdeous
IMAGE_NAME = hackazon
IMAGE_TAG = latest
IMAGE_FULLNAME = $(IMAGE_MAINTAINER)/$(IMAGE_NAME):$(IMAGE_TAG)

DOCKER = /usr/bin/docker
DOCKER_BUILD_ARGS = -t $(IMAGE_FULLNAME)
DOCKER_RUN_ARGS = -it --rm --name=$(IMAGE_NAME) -p 127.0.0.1:80:80

all: build

build:
	$(DOCKER) build $(DOCKER_BUILD_ARGS) .

run:
	$(DOCKER) run $(DOCKER_RUN_ARGS) $(IMAGE_FULLNAME)

.PHONY: all build run

