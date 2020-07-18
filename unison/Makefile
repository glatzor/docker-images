THIS_FILE := $(lastword $(MAKEFILE_LIST))

TARGET = dtools/unison:latest

.PHONY: all build push rebuild run

build:
	docker build -t $(TARGET) --network host .

rebuild:
	docker build -t $(TARGET) --network host --no-cache .

run:
	docker run -it $(TARGET)

push: build
	docker push $(TARGET)
