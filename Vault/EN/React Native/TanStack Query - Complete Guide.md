#tag: EN/React Native
# TanStack Query: Complete Guide for React Native

## Table of Contents
1. [Introduction to TanStack Query](#1-introduction-to-tanstack-query)
    1.1 [Key Features](#11-key-features)
2. [Core Concepts](#2-core-concepts)
3. [Installation and Setup](#3-installation-and-setup)
4. [Basic Usage](#4-basic-usage)
    4.1 [Query States](#41-query-states)
5. [Advanced Features](#5-advanced-features)
6. [Mutations](#6-mutations)
7. [Error Handling](#7-error-handling)
8. [Optimization Techniques](#8-optimization-techniques)
9. [Best Practices](#9-best-practices)
10. [TypeScript Integration](#10-typescript-integration)
11. [Real-World Examples](#11-real-world-examples)
12. [Troubleshooting](#12-troubleshooting)
13. [References & Further Reading](#13-references--further-reading)
14. [Summary](#14-summary)

---

## 1. Introduction to TanStack Query

TanStack Query is a powerful library for managing, caching, and synchronizing server state in React and React Native applications. It provides a declarative, efficient, and robust way to fetch, cache, and update data, reducing boilerplate and improving user experience.

### 1.1 Key Features
- Automatic caching and background updates
- Optimistic UI updates
- Built-in error handling and retry logic
- DevTools for debugging
- TypeScript support
- Infinite queries and pagination
- Prefetching and dependent queries
- Custom hooks and cache management

---

## 2. Core Concepts

- **Query:** Read-only operation (GET) for fetching data, automatically cached and shared
- **Mutation:** Write operation (POST, PUT, DELETE) for creating/updating/deleting data, triggers cache updates
- **Query Keys:** Unique identifiers for queries, control cache and invalidation
- **Query Functions:** Async functions that fetch data (return a Promise)

### 2.1 Query vs Mutation

**Query**: Read-only operations (GET requests)
- Used for fetching data
- Automatically cached
- Can be shared across components

**Mutation**: Write operations (POST, PUT, DELETE)
- Used for creating, updating, deleting data
- Not cached by default
- Trigger cache updates

### 2.2  Query Keys

Query keys are unique identifiers for your queries. They determine cache behavior and invalidation.

```typescript
// Simple key
['todos']

// Parameterized key
['todo', todoId]

// Complex key
['todos', { status: 'done', userId: 123 }]
```

### 2.3 Query Functions

Functions that return promises and fetch your data:

```tsx
const fetchTodos = async (): Promise<Todo[]> => {
  const response = await fetch('/api/todos');
  return response.json();
};
```

---
## 3. Installation and Setup

```bash
npm install @tanstack/react-query
```

**Basic Setup:**
```tsx
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
const queryClient = new QueryClient();

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <YourApp />
    </QueryClientProvider>
  );
}
```

**React Native Tips:**
- Disable DevTools in production
- Use `refetchOnReconnect` for mobile

---

## 4. Basic Usage

**Simple Query:**
```tsx
import { useQuery } from '@tanstack/react-query';

function TodoList() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['todos'],
    queryFn: fetchTodos,
  });
  if (isLoading) return <Text>Loading...</Text>;
  if (error) return <Text>Error: {error.message}</Text>;
  return (
    <View>{data?.map(todo => <Text key={todo.id}>{todo.title}</Text>)}</View>
  );
}
```

**Query with Parameters:**
```tsx
function TodoDetail({ todoId }: { todoId: string }) {
  const { data: todo, isLoading } = useQuery({
    queryKey: ['todo', todoId],
    queryFn: () => fetchTodo(todoId),
    enabled: !!todoId,
  });
  if (isLoading) return <Text>Loading...</Text>;
  return <View><Text>{todo?.title}</Text></View>;
}
```

### 4.1 Query States
TanStack Query provides detailed state for every query:
```tsx
const {
  data,           // The data returned from queryFn
  error,          // Error object if query failed
  isError,        // Boolean indicating if query failed
  isLoading,      // Boolean indicating if query is loading for first time
  isFetching,     // Boolean indicating if query is fetching (including background)
  isSuccess,      // Boolean indicating if query was successful
  isIdle,         // Boolean indicating if query is disabled
  status,         // 'idle' | 'loading' | 'error' | 'success'
  fetchStatus,    // 'idle' | 'fetching' | 'paused'
} = useQuery({ queryKey: ['todos'], queryFn: fetchTodos });
```

---

## 5. Advanced Features

### Infinite Queries
For paginated data:
```tsx
import { useInfiniteQuery } from '@tanstack/react-query';

function TodoList() {
  const {
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
  } = useInfiniteQuery({
    queryKey: ['todos'],
    queryFn: ({ pageParam = 0 }) => fetchTodos({ page: pageParam }),
    getNextPageParam: (lastPage, pages) => {
      return lastPage.hasMore ? pages.length : undefined;
    },
  });

  return (
    <FlatList
      data={data?.pages.flat()}
      renderItem={({ item }) => <TodoItem todo={item} />}
      onEndReached={() => {
        if (hasNextPage && !isFetchingNextPage) {
          fetchNextPage();
        }
      }}
      onEndReachedThreshold={0.5}
    />
  );
}
```

### Dependent Queries
```tsx
function UserTodos({ userId }: { userId: string }) {
  // First, get user info
  const { data: user } = useQuery({
    queryKey: ['user', userId],
    queryFn: () => fetchUser(userId),
  });

  // Then, get user's todos (depends on user data)
  const { data: todos } = useQuery({
    queryKey: ['todos', userId],
    queryFn: () => fetchUserTodos(userId),
    enabled: !!user, // Only run after user is loaded
  });

  return (
    <View>
      <Text>User: {user?.name}</Text>
      {todos?.map(todo => (
        <Text key={todo.id}>{todo.title}</Text>
      ))}
    </View>
  );
}
```

### Query Prefetching
```tsx
import { useQueryClient } from '@tanstack/react-query';

function TodoList() {
  const queryClient = useQueryClient();

  const prefetchTodo = async (todoId: string) => {
    await queryClient.prefetchQuery({
      queryKey: ['todo', todoId],
      queryFn: () => fetchTodo(todoId),
    });
  };

  return (
    <View>
      {todos?.map(todo => (
        <TouchableOpacity
          key={todo.id}
          onPress={() => prefetchTodo(todo.id)}
        >
          <Text>{todo.title}</Text>
        </TouchableOpacity>
      ))}
    </View>
  );
}
```

---

## 6. Mutations

### Basic Mutation
```tsx
import { useMutation, useQueryClient } from '@tanstack/react-query';

function AddTodo() {
  const queryClient = useQueryClient();
  const addTodoMutation = useMutation({
    mutationFn: (newTodo) => createTodo(newTodo),
    onSuccess: (newTodo) => {
      queryClient.invalidateQueries({ queryKey: ['todos'] });
    },
  });
  // ...
}
```

### Optimistic Updates
- Update UI before server confirms mutation
- Rollback on error

```tsx
function TodoItem({ todo }: { todo: Todo }) {
  const queryClient = useQueryClient();

  const toggleTodoMutation = useMutation({
    mutationFn: (todoId: string) => toggleTodo(todoId),
    onMutate: async (todoId) => {
      // Cancel outgoing refetches
      await queryClient.cancelQueries({ queryKey: ['todos'] });

      // Snapshot previous value
      const previousTodos = queryClient.getQueryData(['todos']);

      // Optimistically update
      queryClient.setQueryData(['todos'], (old: Todo[]) =>
        old.map(t => 
          t.id === todoId ? { ...t, completed: !t.completed } : t
        )
      );

      return { previousTodos };
    },
    onError: (err, todoId, context) => {
      // Rollback on error
      queryClient.setQueryData(['todos'], context?.previousTodos);
    },
    onSettled: () => {
      // Always refetch after error or success
      queryClient.invalidateQueries({ queryKey: ['todos'] });
    },
  });

  return (
    <TouchableOpacity
      onPress={() => toggleTodoMutation.mutate(todo.id)}
      disabled={toggleTodoMutation.isPending}
    >
      <Text style={{ textDecorationLine: todo.completed ? 'line-through' : 'none' }}>
        {todo.title}
      </Text>
    </TouchableOpacity>
  );
}
```

---

## 7. Error Handling

### Global Error Handling
```tsx
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: (failureCount, error) => {
        // Don't retry on 4xx errors
        if (error.status >= 400 && error.status < 500) {
          return false;
        }
        return failureCount < 3;
      },
      onError: (error) => {
        console.error('Query error:', error);
        // Show global error toast
        showErrorToast(error.message);
      },
    },
    mutations: {
      onError: (error) => {
        console.error('Mutation error:', error);
        showErrorToast(error.message);
      },
    },
  },
});
```

### Component-Level Error Handling
```tsx
function TodoList() {
  const { data, error, isError } = useQuery({
    queryKey: ['todos'],
    queryFn: fetchTodos,
    retry: 2,
    retryDelay: (attemptIndex) => Math.min(1000 * 2 ** attemptIndex, 30000),
  });

  if (isError) {
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorText}>
          Failed to load todos: {error.message}
        </Text>
        <TouchableOpacity onPress={() => refetch()}>
          <Text>Retry</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <View>
      {data?.map(todo => <TodoItem key={todo.id} todo={todo} />)}
    </View>
  );
}
```

---

## 8. Optimization Techniques

### Query Configuration
```tsx
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000, // Data is fresh for 5 minutes
      cacheTime: 10 * 60 * 1000, // Cache for 10 minutes
      refetchOnMount: true,      // Refetch when component mounts
      refetchOnWindowFocus: false, // Don't refetch on focus (RN)
      refetchOnReconnect: true,  // Refetch when network reconnects
      retry: 3,                  // Retry failed requests 3 times
      retryDelay: (attemptIndex) => Math.min(1000 * 2 ** attemptIndex, 30000),
    },
  },
});
```

### Selective Invalidation
```tsx
// Invalidate all todos
queryClient.invalidateQueries({ queryKey: ['todos'] });

// Invalidate specific todo
queryClient.invalidateQueries({ queryKey: ['todo', todoId] });

// Invalidate todos with specific status
queryClient.invalidateQueries({ 
  queryKey: ['todos'],
  predicate: (query) => query.queryKey[1]?.status === 'completed'
});
```

### Cache Management
```tsx
// Remove specific query from cache
queryClient.removeQueries({ queryKey: ['todos'] });

// Clear entire cache
queryClient.clear();

// Get cache data
const todos = queryClient.getQueryData(['todos']);

// Set cache data manually
queryClient.setQueryData(['todos'], newTodos);
```

---

## 9. Best Practices

### 1. Query Key Structure
```tsx
// ✅ Good: Hierarchical and descriptive
['todos', { status: 'completed', userId: 123 }]
['user', userId, 'profile']
['posts', { category: 'tech', page: 1 }]

// ❌ Bad: Flat and unclear
['todos']
['userData']
['posts']
```

### 2. Custom Hooks
```tsx
// hooks/useTodos.ts
export function useTodos(status?: string) {
  return useQuery({
    queryKey: ['todos', { status }],
    queryFn: () => fetchTodos({ status }),
  });
}

export function useTodo(id: string) {
  return useQuery({
    queryKey: ['todo', id],
    queryFn: () => fetchTodo(id),
    enabled: !!id,
  });
}

// Usage
function TodoList() {
  const { data: todos } = useTodos('completed');
  return <View>{/* render todos */}</View>;
}
```

### 3. Error Boundaries
```tsx
class QueryErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    console.error('Query error boundary caught an error:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return <Text>Something went wrong.</Text>;
    }

    return this.props.children;
  }
}
```

### 4. TypeScript Integration
```tsx
// types/todo.ts
interface Todo {
  id: string;
  title: string;
  completed: boolean;
  userId: string;
}

interface CreateTodo {
  title: string;
  completed: boolean;
  userId: string;
}

// api/todos.ts
export const fetchTodos = async (): Promise<Todo[]> => {
  const response = await fetch('/api/todos');
  if (!response.ok) {
    throw new Error('Failed to fetch todos');
  }
  return response.json();
};

export const createTodo = async (todo: CreateTodo): Promise<Todo> => {
  const response = await fetch('/api/todos', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(todo),
  });
  if (!response.ok) {
    throw new Error('Failed to create todo');
  }
  return response.json();
};
```

---

## 10. TypeScript Integration

### 10.1 TypeScript Integration

TanStack Query provides detailed state for every query:
```tsx
const {
  data,           // The data returned from queryFn
  error,          // Error object if query failed
  isError,        // Boolean indicating if query failed
  isLoading,      // Boolean indicating if query is loading for first time
  isFetching,     // Boolean indicating if query is fetching (including background)
  isSuccess,      // Boolean indicating if query was successful
  isIdle,         // Boolean indicating if query is disabled
  status,         // 'idle' | 'loading' | 'error' | 'success'
  fetchStatus,    // 'idle' | 'fetching' | 'paused'
} = useQuery({ queryKey: ['todos'], queryFn: fetchTodos });
```

---

## 11. Real-World Examples

### Complete Todo App
```tsx
// App.tsx
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import TodoApp from './components/TodoApp';

const queryClient = new QueryClient();

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <TodoApp />
    </QueryClientProvider>
  );
}

// components/TodoApp.tsx
import { useTodos } from '../hooks/useTodos';
import { useCreateTodo, useUpdateTodo, useDeleteTodo } from '../hooks/useTodoMutations';

export default function TodoApp() {
  const { data: todos, isLoading, error } = useTodos();
  const createTodo = useCreateTodo();
  const updateTodo = useUpdateTodo();
  const deleteTodo = useDeleteTodo();

  if (isLoading) return <Text>Loading...</Text>;
  if (error) return <Text>Error: {error.message}</Text>;

  return (
    <View style={styles.container}>
      <AddTodoForm onSubmit={createTodo.mutate} />
      <TodoList 
        todos={todos} 
        onToggle={updateTodo.mutate}
        onDelete={deleteTodo.mutate}
      />
    </View>
  );
}

// hooks/useTodoMutations.ts
export function useCreateTodo() {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: createTodo,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['todos'] });
    },
  });
}

export function useUpdateTodo() {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: updateTodo,
    onSuccess: (updatedTodo) => {
      queryClient.setQueryData(['todos'], (old: Todo[]) =>
        old.map(todo => todo.id === updatedTodo.id ? updatedTodo : todo)
      );
    },
  });
}

export function useDeleteTodo() {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: deleteTodo,
    onSuccess: (_, deletedId) => {
      queryClient.setQueryData(['todos'], (old: Todo[]) =>
        old.filter(todo => todo.id !== deletedId)
      );
    },
  });
}
```

### Infinite Scroll with Search
```tsx
function SearchableTodoList() {
  const [searchTerm, setSearchTerm] = useState('');
  
  const {
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
  } = useInfiniteQuery({
    queryKey: ['todos', 'search', searchTerm],
    queryFn: ({ pageParam = 0 }) => 
      searchTodos({ term: searchTerm, page: pageParam }),
    getNextPageParam: (lastPage, pages) => 
      lastPage.hasMore ? pages.length : undefined,
    enabled: searchTerm.length > 0,
  });

  const debouncedSearch = useMemo(
    () => debounce(setSearchTerm, 300),
    []
  );

  return (
    <View>
      <TextInput
        placeholder="Search todos..."
        onChangeText={debouncedSearch}
      />
      <FlatList
        data={data?.pages.flat()}
        renderItem={({ item }) => <TodoItem todo={item} />}
        onEndReached={() => {
          if (hasNextPage && !isFetchingNextPage) {
            fetchNextPage();
          }
        }}
        onEndReachedThreshold={0.5}
      />
    </View>
  );
}
```

---

## 12. Troubleshooting

### Common Issues

**1. Queries not refetching**
```tsx
// Check if query is enabled
const { data } = useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  enabled: !!userId, // Make sure this is true
});
```

**2. Cache not updating**
```tsx
// Make sure to invalidate or update cache after mutations
const mutation = useMutation({
  mutationFn: updateTodo,
  onSuccess: () => {
    queryClient.invalidateQueries({ queryKey: ['todos'] });
  },
});
```

**3. Memory leaks**
```tsx
// Use proper cache time
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      cacheTime: 5 * 60 * 1000, // 5 minutes
    },
  },
});
```

**4. Network errors**
```tsx
// Implement proper error handling
const { data, error, isError } = useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  retry: (failureCount, error) => {
    if (error.status === 404) return false;
    return failureCount < 3;
  },
});
```

### Debugging
```tsx
// Enable DevTools in development
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';

// In your App component
<ReactQueryDevtools initialIsOpen={false} />

// Log query states
const { data, isLoading, error } = useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  onSuccess: (data) => console.log('Query succeeded:', data),
  onError: (error) => console.error('Query failed:', error),
});
```

---

## 13. References & Further Reading

- [TanStack Query Official Documentation](https://tanstack.com/query/latest)
- [TanStack Query React Native Guide](https://tanstack.com/query/latest/docs/react/guides/react-native)
- [React Query DevTools](https://tanstack.com/query/latest/docs/react/devtools)
- [TanStack Query Examples](https://github.com/TanStack/query/tree/main/examples)
- [React Query Best Practices](https://tkdodo.eu/blog/practical-react-query)

---

## 14. Summary

TanStack Query transforms how you handle server state in React Native applications by providing:

- **Automatic caching and background updates**
- **Optimistic updates for better UX**
- **Built-in error handling and retry logic**
- **Powerful DevTools for debugging**
- **TypeScript support for type safety**

By following the patterns and best practices outlined in this guide, you can build robust, performant, and maintainable React Native applications with excellent user experiences. 