# ===== BASE IMAGE =====
FROM node:18-bullseye-slim

# ===== Environment Setup =====
ENV NODE_ENV=production
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http

# ===== Install system dependencies =====
# Playwright が必要とする依存パッケージ
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    fontconfig \
    locales \
    libnss3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    libxshmfence1 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# ===== Create directory =====
WORKDIR /app

# ===== Copy package.json =====
COPY package.json .

# ===== Install n8n + Playwright =====
RUN npm install --omit=dev && \
    npx playwright install --with-deps

# ===== Copy entrypoint =====
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# ===== Expose Port =====
EXPOSE 5678

CMD ["docker-entrypoint.sh"]
