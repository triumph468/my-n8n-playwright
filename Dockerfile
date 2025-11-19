FROM n8nio/n8n:latest

USER root

# Alpine 版 n8n 用の Chromium 依存パッケージ
RUN apk update && apk add --no-cache \
    chromium \
    chromium-chromedriver \
    nss \
    freetype \
    harfbuzz \
    ttf-freefont \
    ca-certificates \
    udev \
    nodejs \
    npm

ENV CHROME_PATH="/usr/bin/chromium-browser"
ENV PLAYWRIGHT_BROWSERS_PATH=0
ENV PUPPETEER_SKIP_DOWNLOAD=true

USER node
WORKDIR /data

# playwright-ext だけ入れる（playwright 本体は不要）
RUN npm install n8n-nodes-playwright-ext --omit=dev

CMD ["n8n"]
