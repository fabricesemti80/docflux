# docflux (dfx) conversion image.
#
# Bundles the full toolchain so md <-> docx/pdf conversion — including tables
# and offline Mermaid rendering — runs anywhere with no host setup:
#   - pandoc          : the core converter
#   - wkhtmltopdf     : PDF engine (dfx's fallback engine; self-contained)
#   - Node + mmdc     : Mermaid CLI, pointed at the system Chromium
#   - chromium        : headless browser mmdc renders through
#   - git             : GitLab CI clones the repo *inside* this image
#   - fonts           : Liberation/DejaVu for text, Noto emoji for 📀 ✅ etc.
FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
      pandoc \
      wkhtmltopdf \
      nodejs npm \
      chromium \
      git \
      fonts-liberation fonts-dejavu-core fonts-noto-color-emoji \
      ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Render Mermaid through the distro Chromium and never download a bundled one.
# (dfx already writes a --no-sandbox puppeteer config, which Chromium needs
# when running as root inside a container.)
ENV PUPPETEER_SKIP_DOWNLOAD=1 \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
RUN npm install -g @mermaid-js/mermaid-cli

# Install dfx itself.
WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir .

# Direct use:  docker run --rm -v "$PWD:/work" -w /work IMAGE -i doc.md --pdf
# In GitLab CI, override this entrypoint (see .gitlab-ci.yml) so the runner
# can start its own shell.
WORKDIR /work
ENTRYPOINT ["dfx"]
