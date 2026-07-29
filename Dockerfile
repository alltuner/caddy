# ABOUTME: Builds a Caddy image with Cloudflare DNS, acmeproxy DNS, Cloudflare
# ABOUTME: trusted-proxy, and docker-proxy modules. Published to ghcr.io/alltuner/caddy.

ARG CADDY_VERSION=2
FROM caddy:${CADDY_VERSION}-builder AS builder

# acmeproxy delegates the DNS-01 challenge to an HTTP endpoint holding the real
# credentials, so a Caddy can answer for zones across several DNS accounts
# while carrying one credential of its own.
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare@v0.2.4 \
    --with github.com/caddy-dns/acmeproxy@v1.1.1 \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
