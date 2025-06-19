#tag: PT/React Native
# Persistência NoSQL em React Native

## Sumário
1. [Introdução ao NoSQL](#introducao-ao-nosql)
2. [Características Principais dos Bancos NoSQL](#caracteristicas-principais-dos-bancos-nosql)
3. [Tipos de Bancos NoSQL](#tipos-de-bancos-nosql)
    - [Chave-Valor](#chave-valor)
    - [Colunar](#colunar)
    - [Documental](#documental)
    - [Grafos](#grafos)
4. [Vantagens e Desafios](#vantagens-e-desafios)
5. [Exemplo Colunar: HBase](#exemplo-colunar-hbase)
6. [Exemplo Documental: MongoDB](#exemplo-documental-mongodb)
    - [Tipos de Dados BSON](#tipos-de-dados-bson)
    - [Coleções e Validação](#colecoes-e-validacao)
    - [Operações CRUD](#operacoes-crud)
    - [Operadores e Agregação](#operadores-e-agregacao)
7. [Contexto Científico e Projetos Famosos](#contexto-cientifico-e-projetos-famosos)
8. [Integração Backend: Fastify + MongoDB](#integracao-backend-fastify--mongodb)
9. [Integração com React Native (Expo)](#integracao-com-react-native-expo)
10. [Otimização e Boas Práticas](#otimizacao-e-boas-praticas)
11. [Referências e Leituras Sugeridas](#referencias-e-leituras-sugeridas)

---

## Introdução ao NoSQL

**NoSQL** (Not Only SQL) são bancos de dados projetados para flexibilidade, escalabilidade e alta performance, especialmente com grandes volumes de dados ou dados não estruturados. Diferente dos bancos relacionais tradicionais, sistemas NoSQL lidam com grandes volumes, armazenamento distribuído e esquemas dinâmicos—ideais para aplicações web e mobile modernas.

---

## Características Principais dos Bancos NoSQL
- **Performance acima de consistência forte** (normalmente consistência eventual)
- **Alta disponibilidade** e **escalabilidade horizontal**
- **Dados distribuídos e replicados** com baixa latência
- **Esquemas flexíveis e dinâmicos** (sem estrutura fixa de tabelas)
- **Pouco ou nenhum suporte a transações ACID** (com algumas exceções)

---

## Tipos de Bancos NoSQL

### Chave-Valor
- Armazenam dados como pares simples chave-valor.
- A aplicação interpreta o valor.
- **Exemplo:** Redis, Amazon DynamoDB, Oracle Berkeley DB
- **Uso:** Cache, sessões, perfis de usuário.

### Colunar
- Armazenam dados em colunas agrupadas por famílias, não por linhas.
- Excelentes para consultas analíticas e big data.
- **Exemplo:** Apache Cassandra, HBase (inspirado no Google BigTable)
- **Uso:** Séries temporais, analytics, sistemas de recomendação.

### Documental
- Armazenam dados como documentos (JSON, BSON, XML, YAML).
- Suporte a dados semiestruturados e objetos aninhados.
- **Exemplo:** MongoDB, CouchDB, Firebase Firestore
- **Uso:** CMS, dados de usuário, catálogos de produtos.

### Grafos
- Modelam dados como nós (vértices) e relacionamentos (arestas).
- Ideais para dados complexos e interconectados (ex: redes sociais).
- **Exemplo:** Neo4j, Amazon Neptune
- **Uso:** Grafos sociais, detecção de fraude, sistemas de recomendação.

---

## Vantagens e Desafios

### Vantagens
- Alta performance de leitura e escrita
- Escalabilidade horizontal e tolerância a falhas
- Modelos de dados flexíveis (sem schema fixo)
- Suporte a big data e cargas distribuídas

### Desafios
- Consistência eventual (nem sempre imediata)
- Dados duplicados são comuns
- Suporte limitado a transações complexas
- Evolução de schema e versionamento podem ser desafiadores

---

## Exemplo Colunar: HBase

HBase é um banco de dados distribuído, escalável e orientado a colunas, construído sobre o Hadoop. Usado por empresas como Facebook (Messenger) e Netflix (analytics e séries temporais).

**Exemplo de Tabela:**
| Row Key      | aluno:nome | aluno:matricula | turma:codigo | turma:professor | imagens:foto |
|--------------|------------|-----------------|--------------|-----------------|--------------|
| 20181.1873223| Luiz Carlos| 20181...        | ENG2010001   | José Oliveira   | HzvMg4da12...|
| ...          | ...        | ...             | ...          | ...             | ...          |

- **Row Key:** Identificador único (ex: matrícula)
- **Famílias de Colunas:** Agrupam colunas relacionadas (ex: aluno, turma, imagens)
- **Células:** Cada valor pode ter múltiplas versões (timestamp)
- **Flexibilidade:** Adicione colunas/famílias sem migração de schema
- **Dica de otimização:** Armazene dados binários grandes (imagens) em famílias separadas

**Uso real:** O Facebook usa HBase no backend do Messenger, lidando com bilhões de mensagens por dia ([Referência](https://engineering.fb.com/2018/10/08/data-infrastructure/hbase/)).

---

## Exemplo Documental: MongoDB

MongoDB é um dos bancos documentais mais populares, usado por startups e grandes empresas. Armazena dados como documentos JSON, suporta queries ricas e é altamente escalável.

### Tipos de Dados BSON
MongoDB usa BSON (Binary JSON) internamente, suportando mais tipos que o JSON padrão:
- Double, String, Object, Array, Binary Data, ObjectId, Boolean, Date, Null, Regex, Integer, Timestamp, Decimal128, MinKey/MaxKey

### Coleções e Validação
Coleções são como tabelas, mas sem schema fixo. É possível aplicar regras de validação usando JSON Schema:

```js
// Validação estrita
{
  collMod: "contacts",
  validator: { $jsonSchema: {
    bsonType: "object",
    required: [ "phone", "name" ],
    properties: {
      phone: { bsonType: "string", description: "phone deve ser string e obrigatório" },
      name: { bsonType: "string", description: "name deve ser string e obrigatório" }
    }
  } },
  validationLevel: "strict"
}
```

### Operações CRUD
- `insertOne`, `insertMany` — Inserir documentos
- `find` — Consultar documentos
- `updateOne`, `updateMany`, `replaceOne` — Atualizar documentos
- `deleteOne`, `deleteMany` — Remover documentos

**Exemplo:**
```js
// Inserir
await db.collection('inventory').insertOne({ item: 'canvas', qty: 100 });
// Consultar
const cursor = db.collection('inventory').find({ status: 'A' });
// Atualizar
await db.collection('inventory').updateOne({ item: 'paper' }, { $set: { status: 'P' } });
// Remover
await db.collection('inventory').deleteOne({ status: 'D' });
```

### Operadores e Agregação
O MongoDB oferece operadores avançados para queries, updates e pipelines de agregação. Veja a [documentação oficial](https://docs.mongodb.com/manual/reference/operator/) para a lista completa.

**Exemplo:**
```js
// Pipeline de agregação
const result = await db.collection('sales').aggregate([
  { $match: { date: { $gte: new Date('2023-01-01') } } },
  { $group: { _id: '$product', total: { $sum: '$quantity' } } }
]).toArray();
```

---

## Contexto Científico e Projetos Famosos

- **Facebook Messenger:** Usa HBase para armazenamento massivo de mensagens ([fonte](https://engineering.fb.com/2018/10/08/data-infrastructure/hbase/)).
- **Netflix:** Usa Cassandra e HBase para analytics e séries temporais ([fonte](https://netflixtechblog.com/benchmarking-cassandra-scalability-on-aws-over-a-million-writes-per-second-39f45f066c9e)).
- **Twitter:** Usa Manhattan (key-value customizado) e Redis para timelines e cache ([fonte](https://blog.twitter.com/engineering/en_us/topics/infrastructure/2017/manhattan-our-real-time-multi-tenant-distributed-database-for-twitter-scale)).
- **MongoDB:** Usado por eBay, The New York Times, entre outros, para armazenamento flexível e escalável.
- **Literatura científica:**
    - "A Comparative Study of NoSQL Databases" (Sakr et al., 2011)
    - "NoSQL Databases: New Millennium Database for Big Data (Moniruzzaman & Hossain, 2013)"

---

## Integração Backend: Fastify + MongoDB

Você pode construir uma API escalável usando Fastify (framework Node.js de alta performance) e MongoDB. Exemplo de estrutura de projeto:

```ts
// server/services/database.ts
import { MongoClient, Db } from 'mongodb';

const url = 'mongodb://localhost:27017';
const dbName = 'Store';
let db: Db;
let client: MongoClient;

export async function connectToDatabase(): Promise<Db> {
  if (db) return db;
  client = new MongoClient(url);
  await client.connect();
  db = client.db(dbName);
  return db;
}
```

```ts
// server/server.ts
import Fastify from 'fastify';
import { connectToDatabase } from './services/database';
import productRoutes from './routes/productRoutes';

const server = Fastify({ logger: true });
server.register(productRoutes);

const start = async (): Promise<void> => {
  await connectToDatabase();
  await server.listen({ port: 3000 });
};
start();
```

```ts
// server/routes/productRoutes.ts
import { FastifyInstance } from 'fastify';
import { connectToDatabase } from '../services/database';
import { ObjectId } from 'mongodb';

export default async function productRoutes(server: FastifyInstance) {
  const db = await connectToDatabase();
  const collection = db.collection('product');

  server.get('/product', async () => await collection.find().toArray());
  server.get('/product/:id', async (request, reply) => {
    const { id } = request.params as { id: string };
    if (!ObjectId.isValid(id)) return reply.status(400).send({ error: 'ID inválido' });
    const product = await collection.findOne({ _id: new ObjectId(id) });
    if (!product) return reply.status(404).send({ error: 'Produto não encontrado' });
    return product;
  });
  server.post('/product', async (request, reply) => {
    const product = request.body as { name: string; price: number };
    if (!product.name || !product.price) return reply.status(400).send({ error: 'Campos obrigatórios faltando' });
    const result = await collection.insertOne(product);
    reply.code(201).send(result);
  });
  server.delete('/product/:id', async (request, reply) => {
    const { id } = request.params as { id: string };
    if (!ObjectId.isValid(id)) return reply.status(400).send({ error: 'ID inválido' });
    const result = await collection.deleteOne({ _id: new ObjectId(id) });
    if (result.deletedCount === 0) return reply.status(404).send({ error: 'Produto não encontrado' });
    reply.send({ message: 'Deletado com sucesso' });
  });
}
```

---

## Integração com React Native (Expo)

Você pode consumir sua API Fastify+MongoDB no React Native usando `axios`:

```bash
npm install axios
```

```tsx
// src/services/api.ts
import axios from 'axios';

const api = axios.create({
  baseURL: 'http://<SEU_IP_LOCAL>:3000',
});
export default api;
```

```tsx
// src/screens/ProductList.tsx
import React, { useEffect, useState } from 'react';
import { View, Text, FlatList } from 'react-native';
import api from '../services/api';

export default function ProductList() {
  const [products, setProducts] = useState([]);
  useEffect(() => {
    api.get('/product')
      .then(response => setProducts(response.data))
      .catch(error => console.error('Erro ao buscar produtos:', error));
  }, []);
  return (
    <FlatList
      data={products}
      keyExtractor={item => item._id}
      renderItem={({ item }) => (
        <View>
          <Text>{item.name} - R${item.price}</Text>
        </View>
      )}
    />
  );
}
```

> **Dica:** Ao testar em um dispositivo físico, use o IP local da sua máquina, não `localhost`.

---

## Otimização e Boas Práticas
- **Escolha o tipo NoSQL certo** para sua carga (ex: documental para flexibilidade, colunar para analytics)
- **Projete para escalabilidade:** Use sharding e replicação para alta disponibilidade
- **Indexe com sabedoria:** Indexe campos frequentemente consultados, mas evite excesso de índices
- **Valide dados:** Use validação de schema (ex: Zod no React Native, JSON Schema no MongoDB)
- **Monitore performance:** Use ferramentas nativas (MongoDB Atlas, Cassandra OpsCenter)
- **Segurança:** Nunca exponha seu banco diretamente na internet; use camadas de API e autenticação
- **Otimização famosa:** O cluster Cassandra da Netflix lida com mais de 1 milhão de escritas por segundo ([fonte](https://netflixtechblog.com/benchmarking-cassandra-scalability-on-aws-over-a-million-writes-per-second-39f45f066c9e))

---

## Referências e Leituras Sugeridas
- [Documentação Oficial do MongoDB](https://docs.mongodb.com/)
- [HBase no Facebook](https://engineering.fb.com/2018/10/08/data-infrastructure/hbase/)
- [Netflix Tech Blog: Cassandra Benchmark](https://netflixtechblog.com/benchmarking-cassandra-scalability-on-aws-over-a-million-writes-per-second-39f45f066c9e)
- [Twitter Engineering: Manhattan](https://blog.twitter.com/engineering/en_us/topics/infrastructure/2017/manhattan-our-real-time-multi-tenant-distributed-database-for-twitter-scale)
- [A Comparative Study of NoSQL Databases (Sakr et al., 2011)](https://ieeexplore.ieee.org/document/6035790)
- [NoSQL Databases: New Millennium Database for Big Data (Moniruzzaman & Hossain, 2013)](https://ieeexplore.ieee.org/document/6614531)
