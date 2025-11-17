FROM node:20-bullseye-slim

# 必要パッケージ
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    curl \
    unzip \
    fontconfig \
    libnss3 \
    libatk1.0-0 \
    libcups2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libxkbcommon0 \
    libpango1.0-0 \
    libxshmfence1 \
    libasound2 \
    libx11-xcb1 \
    libxcb1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Playwright をインストール（最新版）
RUN npm install -g playwright && \
    playwright install --with-deps

# n8n をグローバルインストール
RUN npm install -g n8n

# データディレクトリ
ENV N8N_USER_FOLDER=/root/.n8n

EXPOSE 5678

# 正しい CMD（これが無いと "command start not found" が出る！）
CMD ["n8n", "start"]
