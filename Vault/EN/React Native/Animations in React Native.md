#tag: EN/React Native
# Animations in React Native

## Overview
React Native provides two main APIs for animations: **Animated API** and **LayoutAnimation API**. These allow you to animate components, create fade effects, move items, and respond to user interactions.

---

## Animated API

### Concept
The `Animated` API is based on declarative relationships between input and output values, using configurable transformations (start, stop, interpolate). You can animate:
- View
- Text
- Image
- ScrollView
- FlatList
- SectionList

You can also animate custom components using `Animated.createAnimatedComponent()`.

### Basic Example (TypeScript)
```tsx
import React, { useRef, useEffect } from 'react';
import { Animated, Text, View } from 'react-native';

function FadeInText({ children }: { children: React.ReactNode }) {
  const fadeAnim = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(fadeAnim, {
      toValue: 1,
      duration: 1000,
      useNativeDriver: true,
    }).start();
  }, [fadeAnim]);

  return (
    <Animated.Text style={{ opacity: fadeAnim }}>{children}</Animated.Text>
  );
}

export default function App() {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <FadeInText>Fade In Text</FadeInText>
    </View>
  );
}
```

---

## LayoutAnimation API

### Concept
`LayoutAnimation` automatically animates layout changes during re-renders. Useful for expanding/collapsing content, reordering lists, etc.

### Example (TypeScript)
```tsx
import React, { useState } from 'react';
import { LayoutAnimation, Text, TouchableOpacity, StyleSheet, View, Platform, UIManager } from 'react-native';

if (Platform.OS === 'android' && UIManager.setLayoutAnimationEnabledExperimental) {
  UIManager.setLayoutAnimationEnabledExperimental(true);
}

export default function App() {
  const [size, setSize] = useState(200);

  const onPress = () => {
    LayoutAnimation.spring();
    setSize(size - 5);
  };

  return (
    <View style={styles.container}>
      <View style={[styles.box, { width: size, height: size }]} />
      <TouchableOpacity onPress={onPress} style={styles.button}>
        <Text style={styles.buttonText}>Shrink the box</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, alignItems: 'center', justifyContent: 'center' },
  box: { backgroundColor: 'orange' },
  button: { backgroundColor: 'black', paddingHorizontal: 20, paddingVertical: 15, marginTop: 15 },
  buttonText: { color: '#fff', fontWeight: 'bold' },
});
```

---

## Advanced Animated API Concepts

### useNativeDriver
- Setting `useNativeDriver: true` runs the animation on the native thread for better performance.
- Not all properties are supported (e.g., some layout properties).

### Example
```tsx
Animated.timing(animValue, {
  toValue: 1,
  duration: 500,
  useNativeDriver: true,
}).start();
```

---

## Common Animation Types
- **Fade (opacity)**
- **Translate (move)**
- **Scale (resize)**
- **Rotate (spin)**

### Example: Move and Fade
```tsx
import React, { useRef, useEffect } from 'react';
import { Animated, Text } from 'react-native';

function MoveAndFade() {
  const anim = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(anim, {
      toValue: 1,
      duration: 1000,
      useNativeDriver: true,
    }).start();
  }, []);

  return (
    <Animated.View
      style={{
        opacity: anim,
        transform: [
          {
            translateY: anim.interpolate({ inputRange: [0, 1], outputRange: [50, 0] }),
          },
        ],
      }}
    >
      <Text>Moving and fading</Text>
    </Animated.View>
  );
}
```

---

## Composing Animations
- `Animated.sequence([...])`: Runs animations one after another.
- `Animated.parallel([...])`: Runs animations at the same time.
- `Animated.stagger(delay, [...])`: Runs animations in sequence with a delay.

### Example: Sequence
```tsx
Animated.sequence([
  Animated.timing(animValue, { toValue: 1, duration: 500, useNativeDriver: true }),
  Animated.timing(animValue, { toValue: 0, duration: 500, useNativeDriver: true }),
]).start();
```

---

## Gesture Integration
Combine `Animated` with gesture libraries (e.g., `react-native-gesture-handler`) for interactive animations.

---

## LayoutAnimation Presets
- `easeInEaseOut`
- `linear`
- `spring`

### Example
```tsx
LayoutAnimation.configureNext(LayoutAnimation.Presets.easeInEaseOut);
setSize(size - 5);
```

---

## Best Practices
- Use `useNativeDriver` for performance.
- Keep animations simple and purposeful.
- Test on both Android and iOS.
- Use Expo for fast prototyping.

---

## Summary
- Use `Animated` for fine-grained, custom animations.
- Use `LayoutAnimation` for automatic layout transitions.