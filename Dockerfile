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

# AQUÍ EL ESPACIO ES VITAL: Entre el asterisco y el punto
COPY package*.json ./

RUN npm install

# AQUÍ TAMBIÉN: Hay un espacio entre el primer punto y el segundo punto
COPY . .

EXPOSE 3000
CMD ["node", "index.js"]
