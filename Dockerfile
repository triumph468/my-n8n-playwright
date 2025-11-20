FROM node:20

ENV DEBIAN_FRONTEND=noninteractive

# Install Chromium dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    git \
    fontconfig \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxdamage1 \
    libxcomposite1 \
    libxrandr2 \
    libgbm1 \
    libxkbcommon0 \
    libxfixes3 \
    libxshmfence1 \
    libgtk-3-0 \
    libglib2.0-0 \
    libnss3 \
    libxss1 \
    libasound2 \
    libxi6 \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Install n8n
RUN npm install -g n8n

# Install Playwright Chromium only
RUN npm install -g playwright && \
    PLAYWRIGHT_BROWSERS_PATH=0 playwright install chromium

WORKDIR /data

EXPOSE 5678

ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

CMD ["n8n"]
