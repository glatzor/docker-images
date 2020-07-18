FROM eugenmayer/unison:2.51.2.2

LABEL maintainer="Sebastian Heinlein <sebastian.heinlein@dpool.com>"

ENV HOST_VOLUME 	/host_sync
ENV APP_VOLUME		/app_sync
ENV UNISON_SRC		/host_sync
ENV UNISON_DEST		/app_sync
ENV UNISON_DIR		/data
ENV OWNER_UID		33
ENV UNISON_ARGS		-ignore=\'Name ignored_folder\' -ignore=\'Name .ignored_dot_folder\' -prefer /host_sync -numericids -auto -batch
ENV UNISON_WATCH_ARGS 	-repeat watch

ENV TZ			Europe/Berlin
ENV LANG		C.UTF-8
ENV HOME		/root

# Cherry pick unreleased supervisord config to get logging to stdout
COPY files/supervisor.daemon.conf /etc/supervisor.conf.d/supervisor.daemon.conf
