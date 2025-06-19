#tag: EN/React Native
# Realm Database – Concepts and Structure

> **A Teacher's Guide to Realm for React Native: Concepts, Best Practices, and Real-World Scenarios**

## Concept
**Realm** is an open-source, object-oriented DBMS designed primarily for mobile applications. It was later acquired by **MongoDB**. Realm is known for its **performance, reactive model**, and ease of use with modern languages like TypeScript.

## Key Advantages and Features

### Compression
Realm optimizes memory usage by converting repeated string lists into enums, reducing data redundancy.

### Concurrency Control (MVCC)
Realm uses **Multi-Version Concurrency Control (MVCC)** with **Copy-On-Write**. This allows multiple concurrent reads and writes. Each new transaction creates a **snapshot** of the database, ensuring **atomicity** and isolation during execution.

### Object Model
Realm is based on **object-oriented classes**. Developers define the database schema directly in code, similar to modern ORMs.

### Indexes
Realm uses an internal structure based on **B+ Trees**, optimizing searches and sequential reads.

### Query Execution
Realm uses a **tuple-at-a-time** model with **lazy-loading**: only accessed properties are loaded from memory/disk, reducing I/O usage.

### Query Interface
Realm provides a **custom API** to query objects by properties, supporting **filters** and **sorting**.

### Storage Architecture
Realm works in both **disk** and **in-memory** modes, with no need for serialization/deserialization: access is direct via memory mapping.

### Decomposition Storage Model (Columnar)
Each property is stored in contiguous blocks. This allows direct access to a property without loading the entire object's "row."

### Storage Organization
Implements **copy-on-write** with **shadow paging**: a new transaction operates on a copy of the database, and after verification (two-phase commit), data is atomically written to disk.

### Views
Realm supports:
- **Virtual Views (imperative):** Results are fixed at the start of the transaction.
- **Materialized Views (reactive):** Data updates automatically as the database changes.

## Disadvantages
- No detailed transaction log support.
- No support for `JOIN` operations as in relational databases.
- No support for foreign keys.

## Example Implementation with React Native + TypeScript

### Installation
```bash
npm install realm @realm/react
```
Or, with Expo:
```bash
npx expo-cli init ReactRealmTSTemplateApp -t @realm/expo-template-js
```

### Person Model
```tsx
import { Realm } from 'realm';

export class Person extends Realm.Object<Person> {
  static schema = {
    name: 'Person',
    primaryKey: '_id',
    properties: {
      _id: 'objectId',
      name: 'string',
      age: 'int?',
      date: { type: 'date', default: () => new Date() },
      cars: { type: 'list', objectType: 'Car' },
      address: 'Address',
    },
  };
}
```

### Car Model
```tsx
import { Realm } from 'realm';

export class Car extends Realm.Object<Car> {
  static schema = {
    name: 'Car',
    primaryKey: '_id',
    properties: {
      _id: 'objectId',
      c_name: 'string',
      c_color: 'string',
      date: { type: 'date', default: () => new Date() },
    },
  };
}
```

### Address Model (Embedded)
```tsx
import { Realm } from 'realm';

export class Address extends Realm.Object<Address> {
  static schema = {
    name: 'Address',
    embedded: true,
    properties: {
      country: 'string?',
    },
  };
}
```

## Relationships in Realm
- **`Person` → `Car`:** One-to-many relationship (list of cars).
- **`Person` → `Address`:** One-to-one relationship with an embedded object.
- Embedded objects (like `Address`) are **stored inside the parent object**, not as a separate row.

## Creating Related Objects
```ts
realm.write(() => {
  const car1 = realm.create('Car', {
    _id: new Realm.BSON.ObjectID(),
    c_name: 'Toyota Camry',
    c_color: 'Red',
  });

  const car2 = realm.create('Car', {
    _id: new Realm.BSON.ObjectID(),
    c_name: 'Honda Accord',
    c_color: 'Blue',
  });

  realm.create('Person', {
    _id: new Realm.BSON.ObjectID(),
    name: 'John Doe',
    age: 30,
    cars: [car1, car2],
    address: { country: 'USA' },
  });
});
```

## Best Practices and Tips
- **Use TypeScript** for type safety in models and queries.
- **Use embedded objects** for tightly coupled data (e.g., address inside person).
- **Avoid large transactions**; keep writes small and frequent.
- **Test on real devices** for performance.
- **Use Expo** for fast prototyping (with the Expo Realm template).

## Summary
- Realm is a high-performance, object-oriented database for React Native.
- Supports advanced features like MVCC, copy-on-write, and columnar storage.
- No joins or foreign keys, but supports embedded objects and one-to-many relationships.
- Use TypeScript and follow best practices for robust, maintainable code. 