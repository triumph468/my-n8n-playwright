FROM n8nio/n8n:latest

USER root

# Playwright 必須の依存関係
RUN apt-get update && apt-get install -y \
    ca-certificates \
    wget \
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

USER node

# playwright-ext と playwright 本体を入れる
RUN npm install -g n8n-nodes-playwright-ext playwright

# Playwright のブラウザ（Chromium）を Docker 内に展開
RUN npx playwright install --with-deps chromium

# カスタムノード配置
USER root
RUN mkdir -p /home/node/.n8n/nodes \
 && cp -r /usr/local/lib/node_modules/n8n-nodes-playwright-ext /home/node/.n8n/nodes/ \
 && chown -R node:node /home/node/.n8n

USER node
CMD ["n8n"]
