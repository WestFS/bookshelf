#tag: PT/React Native
# Estilização no React Native

A estilização de aplicativos em React Native segue os mesmos princípios utilizados em páginas web. No entanto, enquanto na web utilizamos **CSS**, no React Native utilizamos **JavaScript** através da propriedade `style`.

Essa propriedade é **nativa** e pode ser aplicada em qualquer componente. Além disso, existe a possibilidade de usar bibliotecas como os **Styled Components**. A seguir veremos como estilizar de forma nativa e também com o uso de bibliotecas.

---

##  Estilização Nativa com a Prop Style

Os estilos são definidos em **JavaScript**, e as propriedades seguem o padrão **camelCase**, diferente do CSS tradicional.

Por exemplo:
- CSS: `margin-top`
- React Native: `marginTop`

Também é possível aplicar estilos de três formas:

### 1. Inline

```tsx
<Text style={{ color: 'blue', fontSize: 18 }}>Texto Azul</Text>
```

### 2. Interno (usando StyleSheet.create)

```tsx
import React from 'react';
import { StyleSheet, Text } from 'react-native';

const styleTXT = () => {
  return <Text style={styles.blueText}>Texto Azul</Text>;
};

const styles = StyleSheet.create({
  blueText: {
    color: 'blue',
    fontSize: 18,
  },
});

export default styleTXT;
```

### 3. Externo (arquivo separado)

**Arquivo de estilo `styles.js`:**

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

**Arquivo principal:**

```tsx
import React from 'react';
import { Text } from 'react-native';
import styles from './styles';

const styleTXT = () => {
  return <Text style={styles.blueText}>Texto Azul</Text>;
};

export default styleTXT;
```

---

## StyleSheet vs Inline

|Critério|StyleSheet.create|Objeto Inline|
|---|---|---|
|Performance|Melhor (pré-processado)|Inferior (recriado a cada render)|
|Leitura|Mais organizado|Mais difícil em componentes grandes|
|Dinamismo|Menos flexível|Mais fácil de aplicar estilos condicionais|

---

##  Estilos Condicionais

```tsx
<Text style={[styles.text, isActive && styles.activeText]}>
  Texto Condicional
</Text>
```

---

## Styled Components

A biblioteca **styled-components** permite estilizar componentes usando **CSS tradicional**. Com ela, podemos escrever estilos de forma mais clara e reutilizável.

###  Instalação

```bash
npm install styled-components
```

###  Exemplo

```tsx
import React from 'react';
import styled from 'styled-components/native';

const StyledText = styled.Text`
  color: blue;
  font-size: 20px;
`;

const styleTXT = () => {
  return <StyledText>Texto Azul</StyledText>;
};

export default styleTXT;
```

---

###  Vantagens do Styled Components

1. Escreve estilos como no CSS da web.
2. Define componentes reutilizáveis com estilo embutido.
3. Suporta **temas**, **animações** e **props dinâmicas**.
---

### Temas com Styled Components

```tsx
import { ThemeProvider } from 'styled-components/native';

const theme = {
  colors: {
    primary: '#6200ee',
    background: '#f5f5f5',
  },
};

// Envolva seu app com o ThemeProvider
<ThemeProvider theme={theme}>
  <App />
</ThemeProvider>

// Em seu componente:
const StyledView = styled.View`
  background-color: ${(props) => props.theme.colors.background};
`;
```

---
## Conclusão

A estilização no React Native é bastante poderosa e flexível. Você pode optar por:

- Estilo direto com `style` inline (para casos simples).
- Uso do `StyleSheet.create` (organização e performance).
- Estilização com `styled-components` (para escalabilidade e componentização).

Dependendo do tamanho do projeto e da equipe, você pode combinar essas abordagens para garantir performance, organização e produtividade.