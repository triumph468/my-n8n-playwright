FROM n8nio/n8n:1.74.0-debian

# 必要ライブラリ
USER root
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

# Playwright-ext ノードのインストール
USER node
RUN npm install -g n8n-nodes-playwright-ext playwright

# Playwright ブラウザ本体をインストール
RUN npx playwright install chromium

# n8n のカスタムノードディレクトリへコピー
USER root
RUN mkdir -p /home/node/.n8n/nodes \
    && cp -r /usr/local/lib/node_modules/n8n-nodes-playwright-ext /home/node/.n8n/nodes/ \
    && chown -R node:node /home/node/.n8n

USER node
CMD ["n8n"]
