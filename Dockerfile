FROM n8nio/n8n:latest

USER root

# Playwright の依存関係（Debian用・最小セット）
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

# Playwright-ext と Playwright 本体
USER node
RUN npm install -g n8n-nodes-playwright-ext playwright

# Playwright のブラウザ（これが絶対必要）
RUN npx playwright install chromium

# カスタムノードを配置
RUN mkdir -p /home/node/.n8n/nodes
RUN cp -r /usr/local/lib/node_modules/n8n-nodes-playwright-ext /home/node/.n8n/nodes/

USER root
RUN chown -R node:node /home/node/.n8n

USER node
CMD ["n8n"]
