FROM node:18-slim

# Instalamos dependencias de sistema
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalamos yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+x /usr/local/bin/yt-dlp

WORKDIR /app

# NOTA: Asegúrate de que hay un espacio antes del punto
COPY package*.json./

RUN npm install

# NOTA: Asegúrate de que hay un espacio entre los dos puntos
COPY..

EXPOSE 3000
CMD ["node", "index.js"]
