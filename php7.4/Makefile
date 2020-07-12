THIS_FILE := $(lastword $(MAKEFILE_LIST))

TARGET = dtools/dev:php7.4

.PHONY: build rebuild run

build:
	docker build -t $(TARGET) --network host .

rebuild:
	docker build -t $(TARGET) --network host --no-cache .

run:
	docker run -p 2222:22 -it $(TARGET)

push: build
	docker push $(TARGET)
