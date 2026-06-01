# caddy

A [Caddy](https://caddyserver.com/) image built with the modules we use across our projects:

- [caddy-dns/cloudflare](https://github.com/caddy-dns/cloudflare) — DNS-01 ACME challenges via Cloudflare
- [caddy-cloudflare-ip](https://github.com/WeidiDeng/caddy-cloudflare-ip) — `trusted_proxies cloudflare` support
- [caddy-docker-proxy](https://github.com/lucaslorentz/caddy-docker-proxy) — label-driven routing from the Docker socket

## Usage

```sh
docker pull ghcr.io/alltuner/caddy:latest
```

The image ships no Caddyfile. Mount your own and point Caddy at it:

```yaml
services:
  caddy:
    image: ghcr.io/alltuner/caddy:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./Caddyfile:/Caddyfile
    environment:
      - CADDY_DOCKER_CADDYFILE_PATH=/Caddyfile
```

The default command is `caddy docker-proxy`.

## Tags

- `latest` — built from `main`
- `sha-<commit>` — immutable, per commit

Built for `linux/amd64` and `linux/arm64`, and rebuilt weekly to pick up upstream Caddy patches.
