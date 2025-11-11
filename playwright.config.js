// playwright.config.js
module.exports = {
  use: {
    headless: true,
    args: [
      "--no-sandbox",
      "--disable-gpu",
      "--disable-dev-shm-usage"
    ]
  },
  // さらに必要な設定があれば記載
};
