#!/bin/bash
. /opt/bitnami/base/functions
. /opt/bitnami/base/helpers

USER=memcached
DAEMON=memcached
EXEC=$(which $DAEMON)
LOGFILE="/opt/bitnami/memcached/logs/memcached.log"
PIDFILE="/opt/bitnami/memcached/tmp/memcached.pid"

# configure command line flags for authentication
if [[ -n $MEMCACHED_PASSWORD ]]; then
    EXTRA_OPTIONS="-S"
fi

ARGS="-p 11211 -P ${PIDFILE} -u memcached -v ${EXTRA_OPTIONS} -vv > ${LOGFILE} 2>&1"

# If container is started as `root` user
if [ $EUID -eq 0 ]; then
    exec gosu ${USER} ${EXEC} ${ARGS}
else
    exec ${EXEC} ${ARGS}
fi
