#!/bin/bash
set -e
chown -R 1000:0 /usr/share/elasticsearch/data
# Drop to the elasticsearch user (ES refuses to run as root).
exec chroot --userspec=1000:0 / /bin/tini -- /usr/local/bin/docker-entrypoint.sh eswrapper
