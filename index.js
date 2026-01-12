const express = require('express');
const { spawn } = require('child_process');
const app = express();

app.get('/audio', (req, res) => {
    const videoUrl = req.query.url;
    if (!videoUrl) return res.status(400).send('Falta la URL del video');

    // Configuramos los encabezados para que n8n entienda que recibe un archivo de audio
    res.setHeader('Content-Type', 'audio/mpeg');
    res.setHeader('Content-Disposition', 'attachment; filename="audio.mp3"');

    // Lanzamos yt-dlp para extraer solo el audio y enviarlo por la "tubería" (stdout) [1]
    const ytdlp = spawn('yt-dlp',
        videoUrl
    ]);

    ytdlp.stdout.pipe(res);

    ytdlp.stderr.on('data', (data) => {
        console.error(`Error: ${data}`);
    });

    ytdlp.on('close', (code) => {
        if (code!== 0) console.log(`Proceso terminado con código ${code}`);
        res.end();
    });
});

app.listen(3000, () => console.log('API de audio lista en puerto 3000'));
