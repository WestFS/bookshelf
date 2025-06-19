#tag: EN/React Native
# React Native + TypeScript: Best Practices for Storage and Project Organization

## Table of Contents
1. [Local Storage Solutions](#local-storage-solutions)
    - [AsyncStorage / MMKV](#asyncstorage--mmkv)
    - [SQLite / Room / WatermelonDB](#sqlite--room--watermelondb)
    - [Local File Storage](#local-file-storage)
2. [Cloud Storage Solutions](#cloud-storage-solutions)
    - [APIs & Backend](#apis--backend)
    - [Firebase Realtime Database / Firestore](#firebase-realtime-database--firestore)
    - [Secure Storage](#secure-storage)
3. [General Best Practices](#general-best-practices)
4. [Project Structure for React Native + TypeScript](#project-structure-for-react-native--typescript)
    - [Directory Layout](#directory-layout)
    - [Feature-based Organization](#feature-based-organization)
5. [Integrating with TanStack Query](#integrating-with-tanstack-query)
6. [Standardization, RFCs, and Good Practices](#standardization-rfcs-and-good-practices)
7. [Optimization & Tips](#optimization--tips)
8. [References & Further Reading](#references--further-reading)

---

## Local Storage Solutions

### AsyncStorage / MMKV
- **Best for:** Simple key-value data (e.g., login tokens, preferences)
- **AsyncStorage:** Easy to use, but not encrypted by default
- **MMKV:** Modern, faster, and more efficient alternative
- **Tip:** Use [expo-secure-store](https://docs.expo.dev/versions/latest/sdk/securestore/) for sensitive data

### SQLite / Room / WatermelonDB
- **Best for:** Structured, relational data (e.g., product lists, users, tasks)
- **SQLite:** Embedded SQL database, robust and persistent
- **Room:** Abstraction layer for SQLite (Android)
- **WatermelonDB:** High-performance, observable database for React Native

### Local File Storage
- **Best for:** Storing files (e.g., images, documents)
- **Libraries:** `expo-file-system`, `react-native-fs`

---

## Cloud Storage Solutions

### APIs & Backend
- **REST APIs / GraphQL:** For syncing data between devices and reliable persistence
- **Use cases:** Lists, users, carts, etc.
- **Tip:** Use TanStack Query for data fetching, caching, and background sync

### Firebase Realtime Database / Firestore
- **Backend-as-a-Service:** Real-time data, authentication, notifications
- **No backend required:** Can be used directly from the app

### Secure Storage
- **Sensitive data:** Store tokens, passwords, etc. in secure storage
    - `expo-secure-store` (cross-platform)
    - `Keychain` (iOS)
    - `EncryptedSharedPreferences` (Android)

---

## General Best Practices
- 🔒 **Sensitive data → Secure Storage**
- 📶 **Sync data → API/Backend**
- 📴 **Offline support → SQLite or local storage**
- 🧪 **Validate data:** Use [Zod](https://zod.dev/) or similar for schema validation
- 🧩 **Type safety:** Use TypeScript everywhere
- 🧹 **Separation of concerns:** Keep business logic out of UI components

---

## Project Structure for React Native + TypeScript

### Directory Layout
```text
my-react-native-app/
├── android/
├── ios/
├── node_modules/
├── src/
│   ├── assets/
│   │   ├── fonts/
│   │   ├── icons/
│   │   ├── images/
│   │   └── lottie/
│   ├── components/
│   │   ├── common/
│   │   ├── specific/
│   ├── features/
│   │   ├── Auth/
│   │   ├── Products/
│   │   └── Settings/
│   ├── navigation/
│   ├── services/
│   ├── contexts/
│   ├── hooks/
│   ├── utils/
│   ├── constants/
│   ├── store/
│   ├── types/
│   └── App.tsx
├── App.tsx
├── index.tsx
├── package.json
├── tsconfig.json
├── app.json
└── .gitignore
```

### Feature-based Organization
- **`features/`**: Group code by domain (e.g., Auth, Products)
- **`components/`**: Reusable UI components (common/specific)
- **`services/`**: API and data access logic
- **`contexts/`**: Global state via Context API
- **`hooks/`**: Reusable hooks (e.g., `useDebounce`, `useAuth`)
- **`utils/`**: Generic helper functions
- **`constants/`**: Centralized constants (colors, routes, etc.)
- **`store/`**: Global state (Redux, Zustand, etc.)
- **`types/`**: TypeScript types and interfaces

**Advantages:**
- Scalable for medium/large apps
- Domain isolation for easier maintenance
- Supports team collaboration

---

## Integrating with TanStack Query

**TanStack Query** (React Query) is a best-in-class library for data fetching, caching, and synchronization in React Native. It can be used for both remote APIs and local data (e.g., SQLite, MMKV).

### Example: Using TanStack Query for API Data
```tsx
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../services/api';

export function useProducts() {
  return useQuery(['products'], async () => {
    const { data } = await api.get('/products');
    return data;
  });
}

export function useAddProduct() {
  const queryClient = useQueryClient();
  return useMutation(
    (newProduct) => api.post('/products', newProduct),
    {
      onSuccess: () => queryClient.invalidateQueries(['products']),
    }
  );
}
```

### Example: Using TanStack Query for Local Data (e.g., SQLite)
```tsx
import DataManager from '../services/DataManager';

export function useLocalProducts() {
  return useQuery(['localProducts'], () =>
    new Promise((resolve) => DataManager.listProducts(resolve))
  );
}
```

- **Best Practice:** Use TanStack Query for background sync, caching, and optimistic updates
- **Tip:** Combine with Zod for runtime data validation

---

## Standardization, RFCs, and Good Practices
- **TypeScript:** Use strict typing for all code
- **API:** Follow RESTful conventions or GraphQL best practices
- **JSON:** Follow [RFC 8259](https://tools.ietf.org/html/rfc8259) for data interchange
- **Dates:** Use [RFC 3339](https://tools.ietf.org/html/rfc3339) for date/time formats
- **Security:** Never store sensitive data in plain AsyncStorage
- **Testing:** Use Jest/React Native Testing Library for unit/integration tests
- **Documentation:** Use JSDoc or TypeDoc for code documentation

---

## Optimization & Tips
- **Use MMKV for performance-critical key-value storage**
- **Batch API requests** where possible
- **Profile and monitor app performance** (e.g., with Flipper, React Native Debugger)
- **Keep dependencies up to date**
- **Automate formatting/linting** (Prettier, ESLint)
- **Use environment variables** for config (e.g., with react-native-dotenv)

---

## References & Further Reading
- [React Native Docs](https://reactnative.dev/docs/getting-started)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [TanStack Query Docs](https://tanstack.com/query/latest)
- [RFC 8259: JSON](https://tools.ietf.org/html/rfc8259)
- [RFC 3339: Date/Time](https://tools.ietf.org/html/rfc3339)
- [MMKV Storage](https://github.com/mrousavy/react-native-mmkv)
- [WatermelonDB](https://nozbe.github.io/WatermelonDB/)
- [Zod Validation](https://zod.dev/) 