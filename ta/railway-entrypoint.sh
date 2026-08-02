#!/bin/sh
set -e
mkdir -p /data/cache /data/youtube
# Railway: /cache and /youtube are plain dirs — replace with symlinks onto the
# volume. Plain docker: they are VOLUME mountpoints (rm fails busy) — leave them.
for d in cache youtube; do
  if [ ! -L "/$d" ]; then
    rm -rf "/$d" 2>/dev/null || true
    [ -d "/$d" ] || ln -s "/data/$d" "/$d"
  fi
done
cd /app
exec /bin/tini -- ./run.sh
