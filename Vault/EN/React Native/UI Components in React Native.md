#tag: EN/React Native
# UI Components in React Native

## Overview
React Native provides a set of core UI components that help you build interactive, accessible, and beautiful mobile apps. This guide covers essential components for layout, modals, buttons, and loading indicators, with practical TypeScript examples and best practices.

---

## Layout Components

### ScrollView
- Allows vertical or horizontal scrolling of content.
- Use for small lists or when you need to scroll a group of elements.

### SafeAreaView
- Ensures content is rendered within the safe area boundaries of a device (avoiding notches, status bars, etc).

### KeyboardAvoidingView
- Automatically adjusts the position of UI elements when the keyboard appears, preventing it from covering inputs.

---

## Modal
A **Modal** is a native component for displaying content over the entire screen, such as dialogs, forms, or alerts, without navigating away from the current page.

### Example (TypeScript)
```tsx
import React, { useState } from 'react';
import { Modal, View, Text, Button, StyleSheet } from 'react-native';

export default function App() {
  const [visible, setVisible] = useState(false);

  return (
    <View style={styles.container}>
      <Button title="Open Modal" onPress={() => setVisible(true)} />
      <Modal
        visible={visible}
        transparent={true}
        animationType="slide"
        onRequestClose={() => setVisible(false)}
      >
        <View style={styles.modalBackground}>
          <View style={styles.modalContent}>
            <Text>This is a Modal</Text>
            <Button title="Close" onPress={() => setVisible(false)} />
          </View>
        </View>
      </Modal>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, justifyContent: 'center', alignItems: 'center' },
  modalBackground: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(0,0,0,0.5)'
  },
  modalContent: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10
  }
});
```

**Best Practice:** Use modals for focused tasks or alerts. Avoid overusing them, as they interrupt the user flow.

---

## Buttons
React Native offers several button components:
- `Button`
- `Pressable` (recommended)
- `TouchableOpacity`
- `TouchableHighlight`
- `TouchableWithoutFeedback`

### Why Prefer Pressable?
- More control over press events
- Supports dynamic styling (e.g., pressed state)
- More flexible than legacy touchables

#### Example (TypeScript)
```tsx
import { Pressable, Text, StyleSheet } from 'react-native';

export default function App() {
  return (
    <Pressable
      onPress={() => console.log('Pressed!')}
      style={({ pressed }) => [
        {
          backgroundColor: pressed ? '#ddd' : '#0af',
        },
        styles.button,
      ]}
    >
      <Text style={styles.text}>Press here</Text>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  button: {
    padding: 12,
    borderRadius: 5,
    alignItems: 'center',
  },
  text: {
    color: 'white',
    fontWeight: 'bold',
  },
});
```

**Tip:** Use `Pressable` for new projects. Only use legacy touchables for backward compatibility.

---

## ActivityIndicator
A **loading spinner** to show when your app is processing something (e.g., fetching data).

### Example
```tsx
import React from 'react';
import { ActivityIndicator, View, StyleSheet } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <ActivityIndicator size="large" color="#0000ff" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});
```

**How it works:** Under the hood, ActivityIndicator bridges to the native loading indicator of each platform.

---

## Expo Tips
- All these components work out of the box with Expo.
- Use Expo Go to quickly test UI changes on your device.

---

## TanStack Query Integration
Use ActivityIndicator or custom loading components to show loading states while fetching data with TanStack Query.

```tsx
import { useQuery } from '@tanstack/react-query';
import { ActivityIndicator, Text, View } from 'react-native';

function UserProfile({ userId }: { userId: string }) {
  const { data, isLoading, error } = useQuery({
    queryKey: ['user', userId],
    queryFn: () => fetchUser(userId),
    enabled: !!userId,
  });

  if (isLoading) return <ActivityIndicator size="large" color="#0af" />;
  if (error) return <Text>Error: {error.message}</Text>;

  return <Text>{data?.name}</Text>;
}
```

---

## Zod for Data Validation
If you fetch data from an API, use Zod to validate the response before rendering:

```tsx
import { z } from 'zod';

const UserSchema = z.object({
  id: z.string(),
  name: z.string(),
});

async function fetchUser(userId: string) {
  const res = await fetch(`https://api.example.com/users/${userId}`);
  const data = await res.json();
  return UserSchema.parse(data);
}
```

---

## Summary
- Use core UI components for layout, modals, buttons, and loading states.
- Prefer `Pressable` for new touch interactions.
- Use Expo for fast prototyping.
- Combine with TanStack Query and Zod for robust, type-safe data-driven UIs. 

---
## References & Further Reading
- [React Native Components](https://reactnative.dev/docs/components-and-apis)
- [Accessibility in React Native](https://reactnative.dev/docs/accessibility)
- [RFC 8259: JSON](https://tools.ietf.org/html/rfc8259)
- [RFC 3339: Date/Time](https://tools.ietf.org/html/rfc3339) 