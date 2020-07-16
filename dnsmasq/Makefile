THIS_FILE := $(lastword $(MAKEFILE_LIST))

TARGET = dtools/dev:dnsmasq

.PHONY: all build push rebuild run

build:
	docker build -t $(TARGET) --network host .

rebuild:
	docker build -t $(TARGET) --network host --no-cache .

run:
	docker run -p 53:53 -p 53:53/udp --cap-add NET_ADMIN -it $(TARGET)

push: build
	docker push $(TARGET)
