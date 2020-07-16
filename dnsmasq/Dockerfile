FROM debian:buster

LABEL maintainer="Sebastian Heinlein <sebastian.heinlein@dpool.com>"

RUN \
	apt-get update && \
	apt-get install -q -y dnsmasq && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN echo "address=/dev/127.0.0.1" > /etc/dnsmasq.d/dev.conf

CMD ["/etc/init.d/dnsmasq", "systemd-exec"]

EXPOSE 53 53/udp
