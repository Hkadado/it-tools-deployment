import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const app = express();
const PORT = process.env.PORT || 80;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

process.on('SIGTERM', () => {
    console.log('Received SIGTERM');
});

process.on('SIGINT', () => {
    console.log('Received SIGINT');
});

process.on('beforeExit', (code) => {
    console.log(`beforeExit: ${code}`);
});

process.on('exit', (code) => {
    console.log(`exit: ${code}`);
});

process.on('uncaughtException', (err) => {
    console.error('Uncaught exception:', err);
});

process.on('unhandledRejection', (reason) => {
    console.error('Unhandled rejection:', reason);
});

setInterval(() => {
    console.log('heartbeat');
}, 5000);

app.get('/health', (req, res) => {
    res.json({ status: 'ok' });
});

app.use(express.static(path.join(__dirname, 'dist')));

app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

const server = app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
    console.log(`Server address: ${JSON.stringify(server.address())}`);
});

server.on('error', (err) => {
    console.error('Server error:', err);
    process.exit(1);
});

server.on('listening', () => {
    console.log(`Server successfully listening on ${server.address().address}:${server.address().port}`);
});