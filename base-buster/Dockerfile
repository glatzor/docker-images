FROM debian:buster

LABEL maintainer="Sebastian Heinlein <sebastian.heinlein@dpool.com>"

ENV DEBIAN_FRONTEND noninteractive

# Set random root password
RUN P="$(dd if=/dev/random bs=1 count=8 2>/dev/null | base64)" ; echo $P && echo "root:$P" | chpasswd

# Helper to cleanup downloaded files
COPY files/apt-cleanup.sh /usr/local/sbin/apt-cleanup
RUN chmod a+x /usr/local/sbin/apt-cleanup

# Setup the package manager and import defaults
COPY files/debconf-selections /tmp/debconf-selections
COPY files/sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -q -y \
	apt-transport-https \
	apt-utils \
	debconf-utils \
	whiptail && apt-cleanup

# Load defaults
RUN debconf-set-selections /tmp/debconf-selections

# Set timezone
RUN \
	rm /etc/localtime && \
	ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
	echo Europe/Berlin > /etc/timezone

RUN echo docker.dpool.com > /etc/mailname

COPY files/motd /etc/motd
COPY files/gitconfig /etc/gitconfig

# Avoid unsecure memory warning by gnupg
RUN \
	mkdir /root/.gnupg && \
	echo "no-secmem-warning" > /root/.gnupg/gpg.conf

# Bash setup
COPY files/bash.bashrc /etc/bash.bashrc
COPY files/bash.skel /etc/skel/.bashrc
COPY files/bash.skel /root/.bashrc

# The docker image only contains a minimal base
RUN apt-get update && apt-get install -q -y \
	adduser \
	bash-completion \
	bind9-host \
	bsdmainutils \
	debconf-i18n \
	cpio \
	cron \
	curl \
	git \
	gnupg \
	gosu \
	less \
	locales \
	logrotate \
	lsb-release \
	man \
	msmtp-mta \
	nano \
	netcat \
	procps \
	rsync \
	ssh \
	supervisor \
	tree \
	wget && apt-cleanup

# Remove the machine id - this way it gets recreated for each container
RUN rm -f /etc/machine-id /var/lib/dbus/machine-id

# AWK function helper
COPY files/awk /usr/local/share/awk

# SSH setup
RUN mkdir /root/.ssh
COPY files/authorized_keys /root/.ssh/authorized_keys
RUN chmod -R 0700 /root/.ssh

# Use mstmp to relay mails by mail.dpool.net
COPY files/msmtprc /etc/msmtprc

# Setup SSH
COPY files/supervisord-ssh.conf /etc/supervisor/conf.d/ssh.conf
RUN mkdir /var/run/sshd


# Healthcheck
COPY files/healthcheck.sh /usr/local/sbin/healthcheck
RUN \
	chmod a+x /usr/local/sbin/healthcheck && \
	mkdir -p /usr/local/lib/healthcheck
COPY files/healthcheck-ssh.sh /usr/local/lib/healthcheck/ssh.sh
HEALTHCHECK --interval=30s --timeout=10s --retries=1 CMD /usr/local/sbin/healthcheck

EXPOSE 22

RUN mkdir -p /usr/local/lib/docker-entrypoint
COPY files/docker-entrypoint.sh /usr/local/sbin/docker-entrypoint
COPY files/docker-entrypoint-msmtp.sh /usr/local/lib/docker-entrypoint/msmtp.sh
RUN \
	chmod a+x /usr/local/lib/docker-entrypoint/* && \
	chmod a+x /usr/local/sbin/docker-entrypoint
ENTRYPOINT ["/usr/local/sbin/docker-entrypoint"]

CMD ["/usr/bin/supervisord", "-n", "-u", "root", "-c", "/etc/supervisor/supervisord.conf"]
