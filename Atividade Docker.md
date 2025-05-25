## 📦 Projeto de Exemplo: API simples em Node.js + PostgreSQL (usando Docker Compose)

meu-projeto/
├── docker-compose.yml
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   └── index.js
└── .env

1️⃣ `index.js` (backend/index.js)

const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = 3000;

const pool = new Pool({
  host: 'db',
  user: 'postgres',
  password: 'postgres',
  database: 'meubanco',
});

app.get('/', async (req, res) => {
  const result = await pool.query('SELECT NOW()');
  res.send(`Hora do banco: ${result.rows[0].now}`);
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});


2️⃣ `package.json` (backend/package.json)
{
  "name": "api-docker",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.10.0"
  }
}


3️⃣ `Dockerfile` (backend/Dockerfile)

FROM node:18

WORKDIR /app

COPY package.json ./
RUN npm install

COPY . .

CMD ["npm", "start"]


4️⃣ `.env` (arquivo na raiz do projeto)

POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=meubanco

5️⃣ `docker-compose.yml` (arquivo na raiz do projeto)

version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "3000:3000"
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
