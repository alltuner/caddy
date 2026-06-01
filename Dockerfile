# ABOUTME: Builds a Caddy image with Cloudflare DNS, Cloudflare trusted-proxy, and docker-proxy modules.
# ABOUTME: Published to ghcr.io/alltuner/caddy; ships no Caddyfile — consumers mount their own.

ARG CADDY_VERSION=2
FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare@v0.2.4 \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
