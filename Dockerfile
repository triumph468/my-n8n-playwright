FROM n8nio/n8n:latest

USER root

# Playwright に必要な Debian ライブラリ
RUN apt-get update && apt-get install -y \
    wget \
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

# Playwright-ext ノードを追加
USER node
RUN npm install -g n8n-nodes-playwright-ext playwright

# Playwright ブラウザ本体をインストール
RUN npx playwright install chromium

# カスタムノードを n8n ディレクトリにコピー
USER root
RUN mkdir -p /home/node/.n8n/nodes
RUN cp -r /usr/local/lib/node_modules/n8n-nodes-playwright-ext /home/node/.n8n/nodes/

# 権限調整
RUN chown -R node:node /home/node/.n8n

USER node

CMD ["n8n"]
