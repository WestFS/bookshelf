#tag: EN/React Native
# Data Persistence in React Native

> **A comprehensive guide to storing and managing data in modern React Native applications**

---

## Table of Contents
1. [Introduction](#introduction)
2. [Why Data Persistence Matters](#why-data-persistence-matters)
3. [Overview of Storage Options](#overview-of-storage-options)
    - [AsyncStorage](#asyncstorage)
    - [SQLite](#sqlite)
    - [Realm](#realm)
    - [MMKV](#mmkv)
    - [WatermelonDB](#watermelondb)
4. [Choosing the Right Solution](#choosing-the-right-solution)
5. [Best Practices](#best-practices)
6. [Security Considerations](#security-considerations)
7. [TypeScript and Expo Tips](#typescript-and-expo-tips)
8. [Code Examples](#code-examples)
9. [Further Reading](#further-reading)

---

## Introduction
Data persistence is a core requirement for most mobile applications. Whether you need to store user preferences, cache API responses, or manage complex offline data, React Native offers a variety of solutions. This guide explores the most popular options, their trade-offs, and how to use them effectively in modern, TypeScript-based React Native projects.

## Why Data Persistence Matters
- **User Experience:** Retain user data between sessions for seamless experiences.
- **Offline Support:** Enable app functionality without network connectivity.
- **Performance:** Reduce redundant network requests and speed up app load times.
- **Security:** Protect sensitive information with proper storage and encryption.

## Overview of Storage Options

### AsyncStorage
- **What:** Simple key-value storage, suitable for small amounts of data (settings, tokens).
- **Pros:** Easy to use, widely supported, works with Expo.
- **Cons:** Not suitable for large or complex data, no built-in encryption.
- **Library:** [`@react-native-async-storage/async-storage`](https://github.com/react-native-async-storage/async-storage)

### SQLite
- **What:** Embedded relational database, ideal for structured/tabular data.
- **Pros:** ACID-compliant, supports complex queries, works offline.
- **Cons:** Requires schema management, more setup, not as fast as NoSQL for some use cases.
- **Library:** [`expo-sqlite`](https://docs.expo.dev/versions/latest/sdk/sqlite/), [`react-native-sqlite-storage`](https://github.com/andpor/react-native-sqlite-storage)

### Realm
- **What:** Fast, object-oriented NoSQL database with real-time sync options.
- **Pros:** High performance, supports complex data, live objects, encryption, sync.
- **Cons:** Larger bundle size, some features require paid plans.
- **Library:** [`realm`](https://docs.mongodb.com/realm/sdk/react-native/)

### MMKV
- **What:** Ultra-fast key-value storage based on Tencent's MMKV.
- **Pros:** Extremely fast, supports encryption, small footprint.
- **Cons:** Not as flexible as full databases, limited to key-value pairs.
- **Library:** [`react-native-mmkv`](https://github.com/mrousavy/react-native-mmkv)

### WatermelonDB
- **What:** High-performance reactive database for complex, large datasets.
- **Pros:** Scalable, syncs with backends, works well for offline-first apps.
- **Cons:** More complex setup, best for large-scale apps.
- **Library:** [`@nozbe/watermelondb`](https://watermelondb.dev/)

## Choosing the Right Solution
| Use Case | Recommended Solution |
|----------|---------------------|
| Simple settings, tokens | AsyncStorage, MMKV |
| Relational/tabular data | SQLite |
| Complex, object-oriented data | Realm |
| Large, reactive datasets | WatermelonDB |
| High-speed key-value | MMKV |

- **Expo Managed Workflow:** Prefer AsyncStorage, SQLite, or MMKV (with config).
- **Bare Workflow:** All options available.

## Best Practices
- **Keep it simple:** Use the simplest solution that fits your needs.
- **Encrypt sensitive data:** Use MMKV or Realm for built-in encryption, or encrypt before storing.
- **Schema validation:** Use Zod or Yup to validate data before saving.
- **Backup and sync:** Consider cloud sync for critical data (e.g., Firebase, Realm Sync).
- **Test for offline:** Simulate offline scenarios during development.

## Security Considerations
- **Never store plain-text passwords or tokens.**
- **Use device-level encryption when possible.**
- **Leverage secure storage libraries for highly sensitive data.**
- **Follow platform-specific security guidelines (iOS Keychain, Android Keystore).**

## TypeScript and Expo Tips
- **Type your data models:**
  ```ts
  type UserProfile = {
    id: string;
    name: string;
    email: string;
    createdAt: Date;
  };
  ```
- **Validate with Zod:**
  ```ts
  import { z } from 'zod';
  const UserProfileSchema = z.object({
    id: z.string(),
    name: z.string(),
    email: z.string().email(),
    createdAt: z.date(),
  });
  ```
- **Expo:** Use `expo-sqlite` or `@react-native-async-storage/async-storage` for best compatibility.

## Code Examples

### AsyncStorage Example
```ts
import AsyncStorage from '@react-native-async-storage/async-storage';

// Save data
await AsyncStorage.setItem('userToken', 'abc123');

// Retrieve data
const token = await AsyncStorage.getItem('userToken');
```

### SQLite Example (Expo)
```ts
import * as SQLite from 'expo-sqlite';
const db = SQLite.openDatabase('mydb.db');

db.transaction(tx => {
  tx.executeSql(
    'CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, name TEXT);'
  );
  tx.executeSql('INSERT INTO users (id, name) values (?, ?)', ['1', 'Alice']);
  tx.executeSql('SELECT * FROM users', [], (_, { rows }) => {
    console.log(rows._array);
  });
});
```

### Realm Example
```ts
import Realm from 'realm';

class User extends Realm.Object<User> {
  id!: string;
  name!: string;
  static schema = {
    name: 'User',
    properties: {
      id: 'string',
      name: 'string',
    },
    primaryKey: 'id',
  };
}

const realm = await Realm.open({ schema: [User] });
realm.write(() => {
  realm.create('User', { id: '1', name: 'Alice' });
});
```

## Further Reading
- [React Native Docs: Persistence](https://reactnative.dev/docs/asyncstorage)
- [Expo SQLite Guide](https://docs.expo.dev/versions/latest/sdk/sqlite/)
- [Realm React Native](https://docs.mongodb.com/realm/sdk/react-native/)
- [MMKV for React Native](https://github.com/mrousavy/react-native-mmkv)
- [WatermelonDB](https://watermelondb.dev/) 