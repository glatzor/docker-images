THIS_FILE := $(lastword $(MAKEFILE_LIST))

PHP_VERSION ?= 7.4

TARGET = dtools/dev:php$(PHP_VERSION)

.PHONY: all build push rebuild run

build:
	docker build -t $(TARGET) --build-arg PHP_VERSION=$(PHP_VERSION) --network host .

rebuild:
	docker build -t $(TARGET) --build-arg PHP_VERSION=$(PHP_VERSION) --network host --no-cache .

run:
	docker run -p 2222:22 -it $(TARGET)

push: build
	docker push $(TARGET)

all:
	make push PHP_VERSION=7.1
	make push PHP_VERSION=7.2
	make push PHP_VERSION=7.3
	make push PHP_VERSION=7.4
