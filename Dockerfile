# --- Base: Official n8n image (latest, stable, with correct CLI setup) ---
FROM n8nio/n8n:latest

USER root

# Install Playwright dependencies (Chromium only)
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxdamage1 \
    libxcomposite1 \
    libxrandr2 \
    libgbm1 \
    libxkbcommon0 \
    libxfixes3 \
    libxshmfence1 \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright + Chromium only
RUN npm install -g playwright && \
    PLAYWRIGHT_BROWSERS_PATH=0 playwright install chromium

# n8n default workdir
WORKDIR /data

EXPOSE 5678

CMD ["n8n"]
