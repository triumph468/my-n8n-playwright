FROM n8nio/n8n:latest

# Playwright の必要ライブラリ
USER root
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
    libcurl4 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Playwright-ext と Playwright のインストール
USER node
RUN npm install -g n8n-nodes-playwright-ext playwright

# Playwright のブラウザ本体を Docker 内にインストール
RUN npx playwright install --with-deps chromium

# n8n のデータディレクトリにカスタムノードを追加
RUN mkdir -p /home/node/.n8n/nodes
RUN cp -r /usr/local/lib/node_modules/n8n-nodes-playwright-ext /home/node/.n8n/nodes/

# 権限修正
USER root
RUN chown -R node:node /home/node/.n8n

USER node

CMD ["n8n"]
