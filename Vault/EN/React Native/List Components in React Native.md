#tag: EN/React Native
# List Components in React Native

## Overview
React Native provides three main components for rendering lists:
- `VirtualizedList`
- `FlatList`
- `SectionList`

These components are ideal for displaying collections of data, such as arrays and objects. Their main advantage is **virtualized rendering**, which improves performance, especially with large datasets.

---

## VirtualizedList
### What is it?
`VirtualizedList` is the **base component** for `FlatList` and `SectionList`. It only renders items visible on the screen, saving resources and improving performance for long lists.

### Key Benefits
- Performance optimization
- On-demand (lazy) rendering
- Maintains a "window" of visible items
- Scalable for long lists

### Example (TypeScript)
```tsx
import React from 'react';
import { View, VirtualizedList, StyleSheet, Text, StatusBar } from 'react-native';
import { SafeAreaView, SafeAreaProvider } from 'react-native-safe-area-context';

type ItemData = { id: string; title: string };
const getItem = (_data: unknown, index: number): ItemData => ({
  id: Math.random().toString(12).substring(0),
  title: `Item ${index + 1}`,
});
const getItemCount = (_data: unknown) => 50;
const Item = ({ title }: { title: string }) => (
  <View style={styles.item}>
    <Text style={styles.title}>{title}</Text>
  </View>
);

export default function App() {
  return (
    <SafeAreaProvider>
      <SafeAreaView style={styles.container} edges={['top']}>
        <VirtualizedList
          initialNumToRender={4}
          renderItem={({ item }) => <Item title={item.title} />}
          keyExtractor={item => item.id}
          getItemCount={getItemCount}
          getItem={getItem}
        />
      </SafeAreaView>
    </SafeAreaProvider>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, marginTop: StatusBar.currentHeight },
  item: { backgroundColor: '#f9c2ff', height: 150, justifyContent: 'center', marginVertical: 8, marginHorizontal: 16, padding: 20 },
  title: { fontSize: 32 },
});
```

---

## FlatList
`FlatList` is the most commonly used list component. It is a wrapper around `VirtualizedList` with a simpler API for most use cases.

### Example (TypeScript)
```tsx
import React from 'react';
import { FlatList, Text, View, StyleSheet } from 'react-native';

const DATA = [
  { id: '1', title: 'Apple' },
  { id: '2', title: 'Banana' },
  { id: '3', title: 'Orange' },
];

export default function App() {
  return (
    <FlatList
      data={DATA}
      renderItem={({ item }) => (
        <View style={styles.item}>
          <Text style={styles.title}>{item.title}</Text>
        </View>
      )}
      keyExtractor={item => item.id}
    />
  );
}

const styles = StyleSheet.create({
  item: { backgroundColor: '#f9c2ff', padding: 20, marginVertical: 8, marginHorizontal: 16 },
  title: { fontSize: 24 },
});
```

---

## SectionList
`SectionList` is used for grouped lists with section headers.

### Example (TypeScript)
```tsx
import React from 'react';
import { SectionList, Text, View, StyleSheet } from 'react-native';

const DATA = [
  { title: 'Main dishes', data: ['Pizza', 'Burger', 'Risotto'] },
  { title: 'Sides', data: ['French Fries', 'Onion Rings', 'Fried Shrimps'] },
  { title: 'Drinks', data: ['Water', 'Coke', 'Beer'] },
  { title: 'Desserts', data: ['Cheese Cake', 'Ice Cream'] },
];

export default function App() {
  return (
    <SectionList
      sections={DATA}
      keyExtractor={(item, index) => item + index}
      renderItem={({ item }) => (
        <View style={styles.item}>
          <Text style={styles.title}>{item}</Text>
        </View>
      )}
      renderSectionHeader={({ section: { title } }) => (
        <Text style={styles.header}>{title}</Text>
      )}
    />
  );
}

const styles = StyleSheet.create({
  item: { backgroundColor: '#f9c2ff', padding: 20, marginVertical: 8, marginHorizontal: 16 },
  title: { fontSize: 24 },
  header: { fontSize: 28, fontWeight: 'bold', backgroundColor: '#eee', padding: 8 },
});
```

---

## Best Practices
- Use `FlatList` for most lists; use `VirtualizedList` for custom or advanced cases.
- Always provide a unique `keyExtractor` for performance.
- Avoid inline functions for `renderItem` in large lists (use `useCallback` or memoized components).
- Use `initialNumToRender` and `windowSize` to optimize performance for large lists.

---

## Expo Tips
- All list components work out of the box with Expo.
- Use the Expo Go app to test performance on real devices.

---

## TanStack Query Integration
Use TanStack Query to fetch data for your lists. Combine with `ActivityIndicator` for loading states.

```tsx
import { useQuery } from '@tanstack/react-query';
import { FlatList, ActivityIndicator, Text } from 'react-native';

function TodoList() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['todos'],
    queryFn: fetchTodos,
  });

  if (isLoading) return <ActivityIndicator size="large" color="#0af" />;
  if (error) return <Text>Error: {error.message}</Text>;

  return (
    <FlatList
      data={data}
      renderItem={({ item }) => <Text>{item.title}</Text>}
      keyExtractor={item => item.id}
    />
  );
}
```

---

## Zod for Data Validation
Validate list data from APIs before rendering:

```tsx
import { z } from 'zod';

const TodoSchema = z.object({ id: z.string(), title: z.string() });
const TodosSchema = z.array(TodoSchema);

async function fetchTodos() {
  const res = await fetch('https://api.example.com/todos');
  const data = await res.json();
  return TodosSchema.parse(data);
}
```

---

## Summary
- Use `FlatList` for most lists, `SectionList` for grouped data, and `VirtualizedList` for custom cases.
- Optimize performance with proper props and memoization.
- Integrate with TanStack Query and Zod for robust, type-safe lists. 