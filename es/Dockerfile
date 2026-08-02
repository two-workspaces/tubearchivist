FROM docker.elastic.co/elasticsearch/elasticsearch:8.19.0

# Settings the TubeArchivist compose passes as env vars, baked into the config
# instead — Railway variable names can't contain dots. network.bind_host adds
# IPv6 so the instance is reachable over Railway's IPv6-only private network.
RUN { \
  echo 'discovery.type: single-node'; \
  echo 'xpack.security.enabled: true'; \
  echo 'path.repo: /usr/share/elasticsearch/data/snapshot'; \
  echo 'network.bind_host: "::"'; \
} >> /usr/share/elasticsearch/config/elasticsearch.yml

ENV ES_JAVA_OPTS="-Xms512m -Xmx512m"

# Railway volumes mount root-owned; ES runs as uid 1000 and refuses root.
USER root
COPY railway-es-entrypoint.sh /railway-es-entrypoint.sh
RUN chmod +x /railway-es-entrypoint.sh

ENTRYPOINT ["/railway-es-entrypoint.sh"]
