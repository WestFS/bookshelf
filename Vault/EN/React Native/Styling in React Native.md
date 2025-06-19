#tag: EN/React Native
# Styling in React Native

## Overview
Styling in React Native follows similar principles to web development, but instead of CSS, you use **JavaScript** via the `style` prop. This guide covers native styling, using StyleSheet, styled-components, and best practices for scalable, maintainable styles.

---

## Native Styling with the Style Prop
Styles are defined in **JavaScript** using camelCase property names (e.g., `marginTop` instead of `margin-top`).

### 1. Inline Styles
```tsx
<Text style={{ color: 'blue', fontSize: 18 }}>Blue Text</Text>
```

### 2. Internal Styles (StyleSheet.create)
```tsx
import React from 'react';
import { StyleSheet, Text } from 'react-native';

const styles = StyleSheet.create({
  blueText: {
    color: 'blue',
    fontSize: 18,
  },
});

export default function App() {
  return <Text style={styles.blueText}>Blue Text</Text>;
}
```

### 3. External Styles (Separate File)
**styles.ts**
```tsx
import { StyleSheet } from 'react-native';

const styles = StyleSheet.create({
  blueText: {
    color: 'blue',
    fontSize: 18,
  },
});

export default styles;
```
**Usage:**
```tsx
import styles from './styles';
<Text style={styles.blueText}>Blue Text</Text>
```

---

## StyleSheet vs Inline
| Criteria         | StyleSheet.create | Inline Object |
|------------------|------------------|--------------|
| Performance      | Better           | Worse        |
| Readability      | More organized   | Harder in large components |
| Dynamic Styles   | Less flexible    | Easier for conditional styles |

---

## Conditional Styles
```tsx
<Text style={[styles.text, isActive && styles.activeText]}>
  Conditional Text
</Text>
```

---

## Styled Components
**styled-components** lets you write styles using familiar CSS syntax and create reusable styled components.

### Installation
```bash
npm install styled-components
```

### Example
```tsx
import styled from 'styled-components/native';

const StyledText = styled.Text`
  color: blue;
  font-size: 20px;
`;

export default function App() {
  return <StyledText>Blue Text</StyledText>;
}
```

### Advantages
1. Write styles like web CSS.
2. Create reusable components with embedded styles.
3. Supports **themes**, **animations**, and **dynamic props**.

---

## Theming with Styled Components
```tsx
import { ThemeProvider } from 'styled-components/native';

const theme = {
  colors: {
    primary: '#6200ee',
    background: '#f5f5f5',
  },
};

<ThemeProvider theme={theme}>
  <App />
</ThemeProvider>

// In your component:
const StyledView = styled.View`
  background-color: ${(props) => props.theme.colors.background};
`;
```

---

## Best Practices
- Use `StyleSheet.create` for performance and organization.
- Use inline styles for quick, simple cases or dynamic styles.
- Use styled-components for scalable, themeable projects.
- Keep style logic out of your main component logic.
- Use TypeScript for type safety with styled-components.

---

## Summary
- Style with inline, StyleSheet, or styled-components.
- Prefer StyleSheet for performance, styled-components for scalability.
