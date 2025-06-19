#tag: EN/React Native
# Relational Persistence in React Native

## Table of Contents
1. [Introduction to the Relational Model](#introduction-to-the-relational-model)
2. [SQL: Structured Query Language](#sql-structured-query-language)
    - [DDL: Data Definition Language](#ddl-data-definition-language)
    - [DML: Data Manipulation Language](#dml-data-manipulation-language)
    - [SELECT: Querying Data](#select-querying-data)
3. [SQLite in React Native](#sqlite-in-react-native)
    - [What is SQLite?](#what-is-sqlite)
    - [Key Features](#key-features)
    - [How to Use SQLite in React Native](#how-to-use-sqlite-in-react-native)
4. [Example: DataManager Class](#example-datamanager-class)
5. [Integrating with TanStack Query](#integrating-with-tanstack-query)
6. [Standardization, RFCs, and Best Practices](#standardization-rfcs-and-best-practices)
7. [Optimization Tips](#optimization-tips)
8. [References & Further Reading](#references--further-reading)

---

## Introduction to the Relational Model

The **relational model** organizes data into **tables** (relations), where:
- **Rows (tuples):** represent individual records
- **Columns (attributes):** represent fields or properties

This model is based on **relational algebra** (operations like join, projection, selection) and **relational calculus** (predicate logic: "exists", "for all").

**Major relational databases:**
- MySQL
- PostgreSQL
- SQL Server
- **SQLite** (embedded, ideal for mobile)

---

## SQL: Structured Query Language

SQL is the standard language for creating, modifying, and querying relational databases. It is governed by the ISO/IEC 9075 standard and influenced by various RFCs and ANSI/ISO standards.

### DDL: Data Definition Language
Defines the structure of the database.

```sql
CREATE TABLE products (
  id INTEGER PRIMARY KEY,
  name TEXT,
  price REAL
);
```
- `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`

### DML: Data Manipulation Language
For inserting, updating, and deleting data.

```sql
INSERT INTO products (name, price) VALUES ('Shirt', 39.90);
UPDATE products SET price = 29.90 WHERE id = 1;
DELETE FROM products WHERE id = 2;
```
- `INSERT INTO`, `UPDATE`, `DELETE FROM`

### SELECT: Querying Data
Retrieve data with filters, ordering, grouping, and aggregation.

```sql
SELECT name, price FROM products WHERE price > 20 ORDER BY price;
```
- `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, `IN`, `LIKE`, `BETWEEN`, `EXISTS`
- Functions: `MAX()`, `MIN()`, `COUNT()`, `AVG()`, `SUM()`

---

## SQLite in React Native

### What is SQLite?
- Embedded relational database
- Stores data **locally** (no server required)
- Lightweight, fast, and reliable
- Supports **ACID transactions** (Atomicity, Consistency, Isolation, Durability)
- Data stored in **B-Trees**
- Special tables: `sqlite_master` (metadata), `sqlite_sequence` (autoincrement control)

### Key Features
- Zero-configuration, cross-platform
- Used by major apps (e.g., WhatsApp, Firefox, Skype)
- Public domain, widely adopted in mobile and IoT

### How to Use SQLite in React Native

1. **Install the package:**
```bash
npm install react-native-sqlite-storage
```

2. **Configure the database:**
```js
import SQLite from 'react-native-sqlite-storage';
const db = SQLite.openDatabase({ name: 'mydb.db', location: 'default' });
```

3. **Create a database instance:**
```js
// src/services/DatabaseInstance.js
import SQLite from 'react-native-sqlite-storage';
const db = SQLite.openDatabase({ name: 'mydb.db', location: 'default' });
export default db;
```

---

## Example: DataManager Class

A class to encapsulate CRUD operations:

```js
import db from './DatabaseInstance';

class DataManager {
  static createTable() {
    db.transaction((tx) => {
      tx.executeSql(`CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL
      );`);
    });
  }

  static insertProduct(name, price) {
    db.transaction((tx) => {
      tx.executeSql('INSERT INTO products (name, price) VALUES (?, ?);', [name, price]);
    });
  }

  static listProducts(callback) {
    db.transaction((tx) => {
      tx.executeSql('SELECT * FROM products;', [], (_, { rows }) => {
        const results = [];
        for (let i = 0; i < rows.length; i++) {
          results.push(rows.item(i));
        }
        callback(results);
      });
    });
  }

  static removeProduct(id) {
    db.transaction((tx) => {
      tx.executeSql('DELETE FROM products WHERE id = ?;', [id]);
    });
  }
}

export default DataManager;
```

---

## Integrating with TanStack Query

**TanStack Query** (React Query) is a powerful library for data fetching, caching, and synchronization in React and React Native. While it is most often used with remote APIs, you can use it to manage local data (e.g., from SQLite) and synchronize with a backend.

### Example: Using TanStack Query with SQLite

```tsx
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import DataManager from './DataManager';

export function useProducts() {
  return useQuery(['products'], () =>
    new Promise((resolve) => DataManager.listProducts(resolve))
  );
}

export function useAddProduct() {
  const queryClient = useQueryClient();
  return useMutation(
    ({ name, price }) => DataManager.insertProduct(name, price),
    {
      onSuccess: () => queryClient.invalidateQueries(['products']),
    }
  );
}
```

- **Best Practice:** Use TanStack Query to keep your UI in sync with local and remote data, and to handle background refetching, caching, and optimistic updates.
- **Tip:** For remote sync, combine SQLite for offline/local storage and TanStack Query for background sync with your API.

---

## Standardization, RFCs, and Best Practices

- **SQL Standard:** ISO/IEC 9075 (SQL:2016 and later)
- **SQLite:** Follows much of the SQL standard, with some extensions and limitations ([see docs](https://sqlite.org/lang.html))
- **Web Best Practices:**
    - Use parameterized queries to prevent SQL injection
    - Normalize data where appropriate, but denormalize for performance if needed
    - Use transactions for batch operations
    - Follow [RFC 8259](https://tools.ietf.org/html/rfc8259) for JSON data interchange
    - Use [RFC 3339](https://tools.ietf.org/html/rfc3339) for date/time formats
- **React Native:**
    - Use hooks and context for state management
    - Keep business logic out of UI components
    - Use TypeScript for type safety

---

## Optimization Tips
- **Index columns** that are frequently queried
- **Batch writes** in transactions for performance
- **Limit result sets** with `LIMIT` and pagination
- **Profile queries** using SQLite's `EXPLAIN`
- **Secure your data:** encrypt the database if storing sensitive information
- **Sync strategies:** Use background sync and conflict resolution for offline-first apps

---

## References & Further Reading
- [SQLite Official Documentation](https://sqlite.org/docs.html)
- [ISO/IEC 9075: SQL Standard](https://en.wikipedia.org/wiki/SQL:2016)
- [TanStack Query Documentation](https://tanstack.com/query/latest)
- [RFC 8259: The JSON Data Interchange Format](https://tools.ietf.org/html/rfc8259)
- [RFC 3339: Date and Time on the Internet](https://tools.ietf.org/html/rfc3339)
