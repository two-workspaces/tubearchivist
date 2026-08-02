#!/bin/sh
set -e
mkdir -p /data/cache /data/youtube
[ -L /cache ] || { rm -rf /cache; ln -s /data/cache /cache; }
[ -L /youtube ] || { rm -rf /youtube; ln -s /data/youtube /youtube; }
cd /app
exec /bin/tini -- ./run.sh
