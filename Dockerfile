FROM n8nio/n8n:latest

# Playwright の必要パッケージ（alpine 用）
USER root

RUN apk update && apk add --no-cache \
    chromium \
    chromium-chromedriver \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm

# n8n カスタムノード用ディレクトリへ
WORKDIR /data

# Playwright 拡張ノードをインストール
RUN npm install n8n-nodes-playwright-ext --omit=dev

# CHROME_PATH を Playwright に教えてあげる
ENV CHROME_PATH="/usr/bin/chromium-browser"
ENV PUPPETEER_SKIP_DOWNLOAD=true

# 権限戻す
USER node

# n8n を起動
CMD ["n8n"]
