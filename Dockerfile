# ---- Base: lightweight Node + necessary libs for Playwright ----
FROM node:current-slim

# Prevent tzdata from prompting
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies for Chromium/Playwright minimal
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    git \
    unzip \
    fontconfig \
    locales \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libglib2.0-0 \
    libgdk-pixbuf2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# ---- Install n8n (latest global) ----
RUN npm install -g n8n

# ---- Install Playwright + Chromium (latest) ----
# playwright-core + chromium brings only what's needed
RUN npm install -g playwright && \
    PLAYWRIGHT_BROWSERS_PATH=0 playwright install chromium

# Default working directory
WORKDIR /data

# n8n recommended port
EXPOSE 5678

# Environment variables for Render-friendly execution
ENV N8N_EDITOR_BASE_URL=http://localhost:5678
ENV N8N_HOST=0.0.0.0

CMD ["n8n"]
