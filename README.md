# Deploy and Host TubeArchivist on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/tubearchivist?utm_medium=integration&utm_source=button&utm_campaign=tubearchivist)

[TubeArchivist](https://www.tubearchivist.com/) is a self-hosted YouTube media server — subscribe to channels, download videos with yt-dlp, index everything with full-text search, and watch ad-free in a clean web player with continue-watching progress. Your archive survives deleted videos, terminated channels, and region blocks.

## About Hosting TubeArchivist

This template deploys the full three-service stack: the TubeArchivist app, an Elasticsearch 8 index, and Redis, wired together over Railway's private network. Media and cache live on a volume mounted at `/data` in the app service; the Elasticsearch index persists on its own volume. Initial admin credentials come from the `TA_USERNAME` / `TA_PASSWORD` variables.

**Important — YouTube and datacenter IPs:** YouTube aggressively rate-limits and blocks requests from cloud provider IPs. A fresh deploy will browse and index fine, but downloads will likely fail until you authenticate: in TubeArchivist go to Settings → Application and add your YouTube cookies (exported with a browser extension like "Get cookies.txt LOCALLY" from a logged-in session), and consider enabling PO tokens per the [TubeArchivist docs](https://docs.tubearchivist.com/settings/application/). Use a throwaway Google account — automation can get accounts flagged.

## Common Use Cases

- Archive channels you care about before videos get deleted, demonetized, or geo-blocked
- Ad-free, algorithm-free YouTube: subscribe in TubeArchivist, watch in its player or through Jellyfin/Plex integrations
- Research corpus: full-text search across subtitles and metadata of thousands of videos

## Dependencies for TubeArchivist Hosting

- Elasticsearch 8 (included as the `archivist-es` service)
- Redis (included as the `archivist-redis` service)

### Deployment Dependencies

- [TubeArchivist documentation](https://docs.tubearchivist.com/)
- [Companion browser extension](https://github.com/tubearchivist/browser-extension)
- [Jellyfin / Plex / Kodi integrations](https://docs.tubearchivist.com/integrations/)
- [Template source on GitHub](https://github.com/nomideusz/tubearchivist-railway)

### Implementation Details

**First boot:** Elasticsearch initializes first; the app service waits for it, runs migrations, and comes healthy a minute or two later. Log in on the app's Railway domain with `TA_USERNAME` and `TA_PASSWORD`.

**Adding content:** subscribe to a channel or paste video URLs under Downloads. Set up cookies first (see above) or downloads from datacenter IPs will fail with bot-detection errors.

**Storage:** downloaded media lands on the app service's `/data` volume — size it for your archive (grow it in service settings; Hobby plan caps volumes at 5 GB, Pro goes much higher). The Elasticsearch volume stays small (metadata only).

Notes and limits:

- `PORT` is used by Railway's healthcheck probing; connection variables between the three services are pre-wired — leave them all unchanged.
- Elasticsearch heap is set to 512 MB (`ES_JAVA_OPTS` in the image), comfortable for tens of thousands of videos.
- Redis holds task queues and download progress; its loss is harmless, so its volume is a convenience.

## Why Deploy TubeArchivist on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying TubeArchivist on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
