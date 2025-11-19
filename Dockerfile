FROM n8nio/n8n:latest

USER root

# Playwright に必要な Alpine パッケージ
RUN apk update && apk add --no-cache \
    chromium \
    chromium-chromedriver \
    nss \
    freetype \
    harfbuzz \
    ttf-freefont \
    udev

ENV CHROME_PATH="/usr/bin/chromium-browser"
ENV PLAYWRIGHT_BROWSERS_PATH=0
ENV PUPPETEER_SKIP_DOWNLOAD=true

# n8n カスタムノードの場所（ここが正解）
USER node
WORKDIR /home/node/.n8n

# playwright-ext だけ入れる
RUN npm install n8n-nodes-playwright-ext --omit=dev

CMD ["n8n"]
