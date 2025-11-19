FROM n8nio/n8n:latest

USER root

# Playwright / Chromium に必要な依存関係（Debian）
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    ca-certificates \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libasound2 \
    libx11-xcb1 \
    libxshmfence1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENV CHROME_PATH="/usr/bin/chromium"

# n8n カスタムノードを置くフォルダ
USER node
WORKDIR /home/node/.n8n

# Playwright-ext のみインストール（本体は Chromium を使う）
RUN npm install n8n-nodes-playwright-ext --omit=dev

CMD ["n8n"]
