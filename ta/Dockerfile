FROM bbilly1/tubearchivist:v0.5.10

# Railway allows one volume per service — TA hardcodes /cache and /youtube,
# so the entrypoint symlinks both onto the single volume at /data.
COPY railway-entrypoint.sh /railway-entrypoint.sh
RUN chmod +x /railway-entrypoint.sh

ENTRYPOINT ["/railway-entrypoint.sh"]
