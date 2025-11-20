# ベースは軽めで安定した Node.js スリムイメージ
FROM node:18-slim

# 必要なパッケージをインストール（Playwright が要求するネイティブ依存）
# ここで一度にインストールしてキャッシュを小さくする
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      wget \
      gnupg \
      lsb-release \
      libgbm1 \
      libnss3 \
      libxss1 \
      libasound2 \
      libatk1.0-0 \
      libatk-bridge2.0-0 \
      libcups2 \
      libdrm2 \
      libx11-xcb1 \
      libxcomposite1 \
      libxdamage1 \
      libxrandr2 \
      libxshmfence1 \
      libpangocairo-1.0-0 \
      libpango-1.0-0 \
      libgtk-3-0 \
      fonts-liberation \
      tzdata \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリ
WORKDIR /home/node/app

# n8n をグローバルにインストール（安定版）
# Playwright をプロジェクト依存でインストール
RUN npm install -g n8n@^0.258.0  || npm install -g n8n

# Playwright と Chromium をインストール
# --with-deps は環境によって利用可能だが、ここではブラウザ本体を明示インストール
RUN npm init -y \
  && npm install playwright \
  && npx playwright install chromium

# n8n のデータを格納するディレクトリを準備し、権限を node ユーザに渡す
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node

# デフォルトポート
EXPOSE 5678

# 推奨：環境変数のデフォルト
ENV N8N_PORT=5678 \
    N8N_HOST=0.0.0.0 \
    N8N_PROTOCOL=http \
    TZ=Asia/Tokyo \
    NODE_ENV=production

# 非rootユーザで実行（node: イメージに既存）
USER node

# デフォルトコマンド：n8n をフォアグラウンドで起動
CMD ["n8n", "start"]
