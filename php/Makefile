THIS_FILE := $(lastword $(MAKEFILE_LIST))

PHP_VERSION ?= 7.4

TARGET = dtools/dev:php$(PHP_VERSION)

.PHONY: build rebuild run

build:
	docker build -t $(TARGET) --build-arg PHP_VERSION=$(PHP_VERSION) --network host .

rebuild:
	docker build -t $(TARGET) --build-arg PHP_VERSION=$(PHP_VERSION) --network host --no-cache .

run:
	docker run -p 2222:22 -it $(TARGET)

push: build
	docker push $(TARGET)
