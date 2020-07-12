#!/bin/sh
# vim:sw=4:ts=4:et

set -e

if [ -z "${ENTRYPOINT_QUIET_LOGS:-}" ]; then
    exec 3>&1
else
    exec 3>/dev/null
fi

if [ "$1" = "/usr/bin/supervisord" ]; then
    if /usr/bin/find "/usr/local/lib/docker-entrypoint/" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
        echo >&3 "$0: /usr/local/lib/docker-entrypoint/ is not empty, will attempt to perform configuration"

        echo >&3 "$0: Looking for shell scripts in /usr/local/lib/docker-entrypoint"
        find "/usr/local/lib/docker-entrypoint/" -follow -type f -print | sort -n | while read -r f; do
            case "$f" in
                *.sh)
                    if [ -x "$f" ]; then
                        echo >&3 "$0: Launching $f";
                        "$f"
                    else
                        # warn on shell scripts without exec bit
                        echo >&3 "$0: Ignoring $f, not executable";
                    fi
                    ;;
                *) echo >&3 "$0: Ignoring $f";;
            esac
        done

        echo >&3 "$0: Configuration complete; ready for start up"
    else
        echo >&3 "$0: No files found in /usr/local/lib/docker-entrypoint, skipping configuration"
    fi
fi

exec "$@"
