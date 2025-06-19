#tag: EN/React Native
# Navigation Models in React Native

## Overview
Navigation is essential in React Native apps. This guide covers the main navigation models: Stack, Tab, and Drawer, with practical TypeScript examples, best practices, and integration tips.

---

## 1. Stack Navigation

### Concept
A **Stack Navigator** manages a stack of screens, like a deck of cards. Each new screen is "pushed" onto the stack, and going back "pops" the top screen off, revealing the previous one.

### Requirements
- `NavigationContainer` (wraps your navigation tree)
- `createNativeStackNavigator`
- At least two implemented screens

### Example (TypeScript)
```tsx
import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import HomeScreen from './screens/HomeScreen';
import ProfileScreen from './screens/ProfileScreen';

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Profile" component={ProfileScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```

#### Navigating Between Screens
```tsx
// HomeScreen.tsx
function HomeScreen({ navigation }) {
  return (
    <Button
      title="Go to Jane's profile"
      onPress={() => navigation.navigate('Profile', { name: 'Jane' })}
    />
  );
}

// ProfileScreen.tsx
function ProfileScreen({ route }) {
  return <Text>This is {route.params.name}'s profile</Text>;
}
```

#### Navigation Methods
- `navigation.navigate('Profile')` // Go to Profile screen
- `navigation.push('Home')` // Push another instance of Home

---

## 2. Tab Navigation

### Concept
A **Tab Navigator** provides navigation via tabs at the bottom of the screen—a common pattern in mobile apps.

### Example (TypeScript)
```tsx
import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import HomeScreen from './screens/HomeScreen';
import AboutScreen from './screens/AboutScreen';

const Tab = createBottomTabNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Tab.Navigator>
        <Tab.Screen name="Home" component={HomeScreen} />
        <Tab.Screen name="About" component={AboutScreen} />
      </Tab.Navigator>
    </NavigationContainer>
  );
}
```

#### Tips
- Customize icons, colors, and initial tab.
- Each `Tab.Screen` can point to a simple screen or a full stack navigator.

---

## 3. Drawer Navigation

### Concept
A **Drawer Navigator** provides a hidden side menu that can be opened by swiping or tapping a button. Useful for apps with many navigation options.

### Example (TypeScript)
```tsx
import { createDrawerNavigator } from '@react-navigation/drawer';

const Drawer = createDrawerNavigator();

function MyDrawer() {
  return (
    <Drawer.Navigator>
      <Drawer.Screen name="Home" component={HomeScreen} />
      <Drawer.Screen name="Settings" component={SettingsScreen} />
    </Drawer.Navigator>
  );
}
```

#### Drawer Methods
- `navigation.openDrawer()`
- `navigation.closeDrawer()`
- `navigation.navigate('Settings')`

---

## Combining Navigation Models
- Use only **one** `NavigationContainer` in your app.
- You can nest navigators: e.g., a Tab navigator with stacks in each tab, or a Drawer with tabs inside.

---

## Best Practices
- Use descriptive screen names.
- Keep navigation logic outside of UI components when possible.
- Use TypeScript for type safety in navigation params.
- Test navigation on both Android and iOS.

---

## Expo Tips
- All navigation libraries work with Expo.
- Use Expo Go to test navigation flows quickly.

---

## TanStack Query Integration
- Use navigation events (e.g., `focus`) to refetch data with TanStack Query if needed.
- Example:
```tsx
import { useFocusEffect } from '@react-navigation/native';
import { useQueryClient } from '@tanstack/react-query';

function Screen() {
  const queryClient = useQueryClient();
  useFocusEffect(
    React.useCallback(() => {
      queryClient.invalidateQueries(['someData']);
    }, [])
  );
}
```

---

## Zod for Navigation Params
- Use Zod to validate navigation params before using them in your screens.

```tsx
import { z } from 'zod';

const ProfileParams = z.object({ name: z.string() });

function ProfileScreen({ route }) {
  const params = ProfileParams.parse(route.params);
  return <Text>{params.name}</Text>;
}
```

---

## 10. Navigation with Expo Router (Modern File-Based Approach)

### What is Expo Router?
Expo Router is a file-based routing system for React Native, inspired by Next.js. It lets you organize screens as files/folders, and navigation is automatically generated.

### Key Features
- Zero config: Navigation from file/folder structure
- Deep linking: URLs map to screens
- Nested layouts: Easy complex navigation
- Works with Expo Go and EAS builds

### Getting Started
```bash
npx create-expo-app -t tabs@latest my-router-app
cd my-router-app
npm install expo-router
```
Or add to an existing Expo project:
```bash
npm install expo-router
npx expo install expo-linking
```
Set entry point in app.json:
```json
{
  "expo": {
    "entryPoint": "./node_modules/expo-router/entry"
  }
}
```

### File-Based Routing Example
```
app/
  _layout.tsx         // Shared layout
  index.tsx           // Home
  profile.tsx         // /profile
  (tabs)/             // Tab group
    home.tsx
    about.tsx
  (drawer)/           // Drawer group
    dashboard.tsx
    account.tsx
  users/
    [id].tsx          // Dynamic route: /users/123
```

### The Role of _layout.tsx in Expo Router

- The `_layout.tsx` file is the heart of navigation in each folder.
- It acts like a layout or navigation container for all screens in that folder.
- You use it to define which navigation model (Stack, Tabs, Drawer) applies to the screens inside.
- You can also add shared UI (headers, footers, etc.) here.

**Example: Stack Navigation Layout**
```tsx
// app/_layout.tsx
import { Stack } from 'expo-router';
export default function Layout() {
  return <Stack />;
}
```

**Example: Tab Navigation Layout**
```tsx
// app/(tabs)/_layout.tsx
import { Tabs } from 'expo-router';
export default function TabLayout() {
  return <Tabs />;
}
```

**Example: Drawer Navigation Layout**
```tsx
// app/(drawer)/_layout.tsx
import { Drawer } from 'expo-router';
export default function DrawerLayout() {
  return <Drawer />;
}
```

- You can nest layouts: a folder can have its own `_layout.tsx` for local navigation, and its parent can have another for global navigation.
- This enables powerful, deeply nested navigation structures with minimal code.

### Navigating Between Screens
```tsx
import { useRouter } from 'expo-router';
const router = useRouter();
router.push('/profile'); // Push new screen
router.replace('/settings'); // Replace
router.back(); // Go back
```
**Dynamic Params:**
```tsx
import { useLocalSearchParams } from 'expo-router';
const { id } = useLocalSearchParams();
```

### TypeScript and Params Validation
```tsx
import { z } from 'zod';
import { useLocalSearchParams } from 'expo-router';
const ProfileParams = z.object({ name: z.string() });
const params = ProfileParams.parse(useLocalSearchParams());
```

### TanStack Query Integration
```tsx
import { useFocusEffect } from '@react-navigation/native';
import { useQueryClient } from '@tanstack/react-query';
function Screen() {
  const queryClient = useQueryClient();
  useFocusEffect(
    React.useCallback(() => {
      queryClient.invalidateQueries(['someData']);
    }, [])
  );
}
```

### Best Practices
- Organize screens by feature (folders)
- Use layouts for shared UI
- Type params with TypeScript/Zod
- Test deep links
- Combine with TanStack Query for robust data

### Further Reading
- [Expo Router Docs](https://docs.expo.dev/router/introduction/)
- [Expo Router Example Apps](https://github.com/expo/examples/tree/master/with-router)
- [React Navigation vs. Expo Router](https://blog.expo.dev/introducing-expo-router-2-0-1e5e7c3e7b6c)
- [TanStack Query in React Native](https://tanstack.com/query/latest/docs/react-native/overview)

### Summary Table: Classic vs. Expo Router
| Feature         | Classic React Navigation         | Expo Router (File-based)         |
|-----------------|---------------------------------|----------------------------------|
| Route setup     | Manual in code                  | File/folder structure            |
| Deep linking    | Manual config                   | Automatic                        |
| Nested layouts  | Manual nesting                  | Folders + _layout.tsx            |
| Dynamic routes  | Params in code                  | [param].tsx files                |
| Type safety     | Manual (with types)             | Inferred from files + TypeScript |
| Expo Go         | Full support                    | Full support                     |

---

## Summary
- Use Stack for sequential screens, Tab for main sections, Drawer for side menus.
- Combine navigators for complex apps.
- Integrate with TanStack Query and Zod for robust, type-safe navigation. 