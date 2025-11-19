FROM n8nio/n8n:latest

USER root

# Alpine 版 Chromium + 必須ライブラリ
RUN apk update && apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ttf-freefont \
    udev \
    nodejs \
    npm

# Playwright 側に Chromium の場所を教える
ENV CHROME_PATH="/usr/bin/chromium-browser"
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PLAYWRIGHT_BROWSERS_PATH=0

USER node
WORKDIR /data

# playwright-ext ノードだけインストール（Playwright 本体は不要）
RUN npm install n8n-nodes-playwright-ext --omit=dev

CMD ["n8n"]
