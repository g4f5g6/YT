FROM node:18-slim

# Instalamos Python y FFmpeg (indispensables para yt-dlp) [4, 5]
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Descargamos la última versión de yt-dlp [3, 5]
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+x /usr/local/bin/yt-dlp

WORKDIR /app
COPY package*.json./
RUN npm install
COPY..

EXPOSE 3000
CMD ["node", "index.js"]
