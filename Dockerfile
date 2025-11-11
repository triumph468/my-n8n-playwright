FROM n8nio/n8n:latest

# Switch to root to install dependencies
USER root

# Install Playwright and browsers
RUN apt-get update && apt-get install -y \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g npm@latest

# Install Playwright and the n8n-nodes-playwright community node
RUN npm install playwright
RUN npm install n8n-nodes-playwright

# Install browsers for Playwright
RUN npx playwright install --with-deps

# Switch back to n8n user
USER node

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]
