FROM bbilly1/tubearchivist:v0.5.12

# Healthcheck answered by nginx directly: Railway probes by private hostname,
# which Django's ALLOWED_HOSTS (built from TA_HOST) rejects with 400.
# Also listen on [::] — Railway's private network is IPv6-only.
RUN sed -i "s|listen 8000;|listen 8000;\n    listen [::]:8000;\n    location = /healthcheck { add_header Content-Type text/plain; return 200 'ok'; }|" /etc/nginx/sites-available/default

# Railway allows one volume per service — TA hardcodes /cache and /youtube,
# so the entrypoint symlinks both onto the single volume at /data.
COPY railway-entrypoint.sh /railway-entrypoint.sh
RUN chmod +x /railway-entrypoint.sh

ENTRYPOINT ["/railway-entrypoint.sh"]
