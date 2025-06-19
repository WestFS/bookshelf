#tag: EN/React Native
# NoSQL Persistence in React Native

## Table of Contents
1. [Introduction to NoSQL](#introduction-to-nosql)
2. [Key Characteristics of NoSQL Databases](#key-characteristics-of-nosql-databases)
3. [Types of NoSQL Databases](#types-of-nosql-databases)
    - [Key-Value Stores](#key-value-stores)
    - [Columnar Databases](#columnar-databases)
    - [Document Stores](#document-stores)
    - [Graph Databases](#graph-databases)
4. [Advantages and Caveats](#advantages-and-caveats)
5. [Columnar Example: HBase](#columnar-example-hbase)
6. [Document Example: MongoDB](#document-example-mongodb)
    - [BSON Data Types](#bson-data-types)
    - [Collections and Validation](#collections-and-validation)
    - [CRUD Operations](#crud-operations)
    - [Operators and Aggregation](#operators-and-aggregation)
7. [Scientific Context & Famous Projects](#scientific-context--famous-projects)
8. [Backend Integration: Fastify + MongoDB](#backend-integration-fastify--mongodb)
9. [React Native Integration (with Expo)](#react-native-integration-with-expo)
10. [Optimization & Best Practices](#optimization--best-practices)
11. [References & Further Reading](#references--further-reading)
12. [NoSQL in React Native: Practical Guide](#nosql-in-react-native-practical-guide)

---

## Introduction to NoSQL

**NoSQL** (Not Only SQL) databases are designed for flexibility, scalability, and high performance, especially with large or unstructured datasets. Unlike traditional relational databases, NoSQL systems can handle massive volumes of data, distributed storage, and dynamic schemas—making them ideal for modern web and mobile applications.

---

## Key Characteristics of NoSQL Databases
- **Performance over strict consistency** (often eventual consistency)
- **High availability** and **horizontal scalability**
- **Distributed and replicated data** with low latency
- **Flexible, dynamic schemas** (no fixed table structure)
- **Limited or no ACID transactions** (with some exceptions)

---

## Types of NoSQL Databases

### Key-Value Stores
- Store data as simple key-value pairs.
- The application interprets the value.
- **Example:** Redis, Amazon DynamoDB, Oracle Berkeley DB
- **Use case:** Caching, session storage, user profiles.

### Columnar Databases
- Store data in columns grouped by families, not rows.
- Excellent for analytical queries and big data workloads.
- **Example:** Apache Cassandra, HBase (inspired by Google BigTable)
- **Use case:** Time-series data, analytics, recommendation engines.

### Document Stores
- Store data as documents (JSON, BSON, XML, YAML).
- Support for semi-structured data and nested objects.
- **Example:** MongoDB, CouchDB, Firebase Firestore
- **Use case:** Content management, user data, product catalogs.

### Graph Databases
- Model data as nodes (vertices) and relationships (edges).
- Ideal for complex, interconnected data (e.g., social networks).
- **Example:** Neo4j, Amazon Neptune
- **Use case:** Social graphs, fraud detection, recommendation systems.

---

## Advantages and Caveats

### Advantages
- High read/write performance
- Horizontal scalability and fault tolerance
- Flexible data models (schema-less)
- Support for big data and distributed workloads

### Caveats
- Eventual consistency (not always immediate)
- Data duplication is common
- Limited support for complex transactions
- Schema evolution and versioning can be challenging

---

## Columnar Example: HBase

HBase is a distributed, scalable, column-oriented database built on top of Hadoop. It is used by companies like Facebook (for its Messaging platform) and Netflix (for time-series data and analytics).

| Row Key       | student:name | student:id | class:code | class:teacher | images:photo  |
| ------------- | ------------ | ---------- | ---------- | ------------- | ------------- |
| 20181.1873223 | Luiz Carlos  | 20181...   | ENG2010001 | José Oliveira | HzvMg4da12... |
|               |              |            |            |               |               |


- **Row Key:** Unique identifier (e.g., student ID)
- **Column Families:** Group related columns (e.g., student, class, images)
- **Cells:** Each value can have multiple versions (timestamped)
- **Schema flexibility:** Add columns/families without schema migration
- **Optimization tip:** Store large binary data (e.g., images) in separate families for performance

**Famous Use:** Facebook uses HBase for its Messenger backend, handling billions of messages per day ([Reference](https://engineering.fb.com/2018/10/08/data-infrastructure/hbase/)).

---

## Document Example: MongoDB

MongoDB is a leading document-oriented database, widely used in startups and enterprises. It stores data as JSON-like documents, supports rich queries, and is highly scalable.

### BSON Data Types
MongoDB uses BSON (Binary JSON) internally, which supports more data types than standard JSON:
- Double, String, Object, Array, Binary Data, ObjectId, Boolean, Date, Null, Regex, Integer, Timestamp, Decimal128, MinKey/MaxKey

### Collections and Validation
Collections are like tables, but schema-less. You can enforce validation rules using JSON Schema:

```js
// Strict validation
{
  collMod: "contacts",
  validator: { $jsonSchema: {
    bsonType: "object",
    required: [ "phone", "name" ],
    properties: {
      phone: { bsonType: "string", description: "phone must be a string and is required" },
      name: { bsonType: "string", description: "name must be a string and is required" }
    }
  } },
  validationLevel: "strict"
}
```

### CRUD Operations
- `insertOne`, `insertMany` — Insert documents
- `find` — Query documents
- `updateOne`, `updateMany`, `replaceOne` — Update documents
- `deleteOne`, `deleteMany` — Delete documents

**Example:**
```js
// Insert
await db.collection('inventory').insertOne({ item: 'canvas', qty: 100 });
// Find
const cursor = db.collection('inventory').find({ status: 'A' });
// Update
await db.collection('inventory').updateOne({ item: 'paper' }, { $set: { status: 'P' } });
// Delete
await db.collection('inventory').deleteOne({ status: 'D' });
```

### Operators and Aggregation
MongoDB provides a rich set of operators for queries, updates, and aggregation pipelines. See the [official docs](https://docs.mongodb.com/manual/reference/operator/) for a full list.

**Example:**
```js
// Aggregation pipeline
const result = await db.collection('sales').aggregate([
  { $match: { date: { $gte: new Date('2023-01-01') } } },
  { $group: { _id: '$product', total: { $sum: '$quantity' } } }
]).toArray();
```

---

## Scientific Context & Famous Projects

- **Facebook Messenger:** Uses HBase for massive-scale message storage and retrieval ([source](https://engineering.fb.com/2018/10/08/data-infrastructure/hbase/)).
- **Netflix:** Uses Cassandra and HBase for time-series and analytics workloads ([source](https://netflixtechblog.com/benchmarking-cassandra-scalability-on-aws-over-a-million-writes-per-second-39f45f066c9e)).
- **Twitter:** Uses Manhattan (a custom key-value store) and Redis for timelines and caching ([source](https://blog.twitter.com/engineering/en_us/topics/infrastructure/2017/manhattan-our-real-time-multi-tenant-distributed-database-for-twitter-scale)).
- **MongoDB:** Used by eBay, The New York Times, and many others for flexible, scalable data storage.
- **Scientific Literature:**
    - "A Comparative Study of NoSQL Databases" (Sakr et al., 2011)
    - "NoSQL Databases: New Millennium Database for Big Data, Big Users, Cloud Computing and Its Security" (Moniruzzaman & Hossain, 2013)

---

## Backend Integration: Fastify + MongoDB

You can build a scalable API using Fastify (a high-performance Node.js framework) and MongoDB. Example project structure:

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
    if (!ObjectId.isValid(id)) return reply.status(400).send({ error: 'Invalid ID' });
    const product = await collection.findOne({ _id: new ObjectId(id) });
    if (!product) return reply.status(404).send({ error: 'Product not found' });
    return product;
  });
  server.post('/product', async (request, reply) => {
    const product = request.body as { name: string; price: number };
    if (!product.name || !product.price) return reply.status(400).send({ error: 'Missing fields' });
    const result = await collection.insertOne(product);
    reply.code(201).send(result);
  });
  server.delete('/product/:id', async (request, reply) => {
    const { id } = request.params as { id: string };
    if (!ObjectId.isValid(id)) return reply.status(400).send({ error: 'Invalid ID' });
    const result = await collection.deleteOne({ _id: new ObjectId(id) });
    if (result.deletedCount === 0) return reply.status(404).send({ error: 'Product not found' });
    reply.send({ message: 'Deleted successfully' });
  });
}
```

---

## React Native Integration (with Expo)

You can consume your Fastify+MongoDB API in React Native using `axios`:

```bash
npm install axios
```

```tsx
// src/services/api.ts
import axios from 'axios';

const api = axios.create({
  baseURL: 'http://<YOUR_LOCAL_IP>:3000',
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
      .catch(error => console.error('Error fetching products:', error));
  }, []);
  return (
    <FlatList
      data={products}
      keyExtractor={item => item._id}
      renderItem={({ item }) => (
        <View>
          <Text>{item.name} - ${item.price}</Text>
        </View>
      )}
    />
  );
}
```

> **Tip:** When testing on a physical device, use your machine's local IP address, not `localhost`.

---

## Optimization & Best Practices
- **Choose the right NoSQL type** for your workload (e.g., document for flexibility, columnar for analytics)
- **Design for scalability:** Use sharding and replication for high availability
- **Index wisely:** Index fields that are frequently queried, but avoid over-indexing
- **Validate data:** Use schema validation (e.g., with Zod in React Native, or JSON Schema in MongoDB)
- **Monitor performance:** Use built-in tools (e.g., MongoDB Atlas, Cassandra OpsCenter)
- **Security:** Never expose your database directly to the internet; use API layers and authentication
- **Famous optimization:** Netflix's Cassandra cluster handles over a million writes per second ([source](https://netflixtechblog.com/benchmarking-cassandra-scalability-on-aws-over-a-million-writes-per-second-39f45f066c9e))

---

## References & Further Reading
- [MongoDB Official Documentation](https://docs.mongodb.com/)
- [HBase at Facebook](https://engineering.fb.com/2018/10/08/data-infrastructure/hbase/)
- [Netflix Tech Blog: Cassandra Benchmark](https://netflixtechblog.com/benchmarking-cassandra-scalability-on-aws-over-a-million-writes-per-second-39f45f066c9e)
- [Twitter Engineering: Manhattan](https://blog.twitter.com/engineering/en_us/topics/infrastructure/2017/manhattan-our-real-time-multi-tenant-distributed-database-for-twitter-scale)
- [A Comparative Study of NoSQL Databases (Sakr et al., 2011)](https://ieeexplore.ieee.org/document/6035790)
- [NoSQL Databases: New Millennium Database for Big Data (Moniruzzaman & Hossain, 2013)](https://ieeexplore.ieee.org/document/6614531)

---

## NoSQL in React Native: Practical Guide

### Popular NoSQL Solutions for React Native
- **Realm:** Object-oriented, local-first, live objects, encryption, sync, TypeScript support. Best for complex, nested, offline-first data.
- **Firebase:** Cloud-hosted, real-time sync, offline support, cross-platform. Best for real-time updates, cross-device sync, cloud backend.
- **WatermelonDB:** High-performance, local-first, sync with custom backends, reactive queries. Best for large, complex local data, offline-first, custom sync logic.

### Schema Design and Validation
- Define clear data models for consistency, even in NoSQL.
- Validate with Zod:
  ```ts
  import { z } from 'zod';
  const NoteSchema = z.object({
    id: z.string(),
    title: z.string(),
    content: z.string(),
    createdAt: z.date(),
  });
  ```
- Document your schema for migrations and collaboration.

### Offline-First Strategies
- Local-first writes: Save data locally, then sync to the cloud when online.
- Conflict resolution: Use timestamps, versioning, or merge strategies.
- Background sync: Use libraries or custom logic to sync when connectivity is restored.

### TypeScript and Zod Integration
- Type your models:
  ```ts
  type Note = z.infer<typeof NoteSchema>;
  ```
- Validate before saving:
  ```ts
  const parsed = NoteSchema.safeParse(data);
  if (!parsed.success) throw new Error('Invalid data');
  ```

### Example: Using Realm with TypeScript
```ts
import Realm from 'realm';

class Note extends Realm.Object<Note> {
  id!: string;
  title!: string;
  content!: string;
  createdAt!: Date;
  static schema = {
    name: 'Note',
    properties: {
      id: 'string',
      title: 'string',
      content: 'string',
      createdAt: 'date',
    },
    primaryKey: 'id',
  };
}

const realm = await Realm.open({ schema: [Note] });
realm.write(() => {
  realm.create('Note', {
    id: '1',
    title: 'First Note',
    content: 'This is a note.',
    createdAt: new Date(),
  });
});
```

### Best Practices and Pitfalls
- Validate all data before saving.
- Plan for migrations: NoSQL schemas can evolve—use versioning.
- Encrypt sensitive data.
- Test offline and sync scenarios thoroughly.
- Monitor performance for large datasets.

References
- [Expo SQLite Guide](https://docs.expo.dev/versions/latest/sdk/sqlite/)
- [TypeORM Docs](https://typeorm.io/)
- [Drizzle ORM](https://orm.drizzle.team/)
- [React Native SQLite Storage](https://github.com/andpor/react-native-sqlite-storage) 