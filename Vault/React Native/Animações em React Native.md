## Animações em React Native
Em React Native, estão disponíveis dois recursos nativos para a animação de objetos: a **Animated API** e a **LayoutAnimation API**. Com os recursos disponibilizados por ambas, é possível:

- Animar os componentes de nossa aplicação;
- Inserir efeitos de fade in ou fade out;
- Mover itens a partir da interação do usuário.

### Animated API

#### Conceito

A `Animated` API se baseia em relações declarativas entre entradas e saídas, utilizando transformações configuráveis (como iniciar, parar e interpolar valores). Pode ser usada em componentes como:

- View
- Text
- Image
- ScrollView
- FlatList
- SectionList

Também é possível animar componentes personalizados usando `Animated.createAnimatedComponent()`.


#### Exemplo de Código
Utiliza os hooks `useRef` e `useEffect`. O `useRef` cria uma referência persistente, e `useEffect` executa a animação ao montar o componente.

``` tsx
import React, { useRef, useEffect } from 'react';
import { Animated, Text, View } from 'react-native';

const FadeInText = (props) => {
  const fadeAnim = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(fadeAnim, {
      toValue: 1,
      duration: 1000,
      useNativeDriver: true,
    }).start();
  }, [fadeAnim]);

  return (
    <Animated.Text
      style={{
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
        width: 250,
        height: 50,
        backgroundColor: 'orange',
        opacity: fadeAnim,
      }}
    >
      {props.children}
    </Animated.Text>
  );
};

export default () => (
  <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
    <FadeInText>Texto com Fade In</FadeInText>
  </View>
);
```

Outros recursos da `Animated API`:

- Sequência e paralelismo de animações.
- Combinação de valores animados.
- Interpolação de valores.
- Integração com gestos.

---

### LayoutAnimation API

#### Conceito

`LayoutAnimation` foca na **animação automática do layout** durante re-renderizações. Útil, por exemplo, em "mostrar mais" que expande conteúdo.

#### Exemplo de Código

``` tsx
import React from 'react';
import {
  NativeModules,
  LayoutAnimation,
  Text,
  TouchableOpacity,
  StyleSheet,
  View,
} from 'react-native';

const { UIManager } = NativeModules;
UIManager.setLayoutAnimationEnabledExperimental &&
  UIManager.setLayoutAnimationEnabledExperimental(true);

export default class App extends React.Component {
  state = { w: 200, h: 200 };

  _onPress = () => {
    LayoutAnimation.spring();
    this.setState({ w: this.state.w - 5, h: this.state.h - 5 });
  };

  render() {
    return (
      <View style={styles.container}>
        <View style={[styles.box, { width: this.state.w, height: this.state.h }]} />
        <TouchableOpacity onPress={this._onPress}>
          <View style={styles.button}>
            <Text style={styles.buttonText}>Pressione para diminuir o quadrado</Text>
          </View>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 200,
    height: 200,
    backgroundColor: 'orange',
  },
  button: {
    backgroundColor: 'black',
    paddingHorizontal: 20,
    paddingVertical: 15,
    marginTop: 15,
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
});
```

Esse exemplo apresenta um quadrado que diminui de tamanho ao clicar no botão. A `LayoutAnimation` suaviza a transição de tamanho automaticamente sem configuração extra de animações.

---
## Animated API: Conceitos Avançados

### Uso do `useNativeDriver`

O parâmetro `useNativeDriver` indica que a animação será executada no **thread nativo** do dispositivo, o que aumenta bastante a performance. Porém, nem todas as propriedades podem ser animadas com o driver nativo (por exemplo, algumas propriedades de layout não são suportadas).


Exemplo:
```tsx
Animated.timing(animValue, {
  toValue: 1,
  duration: 500,
  useNativeDriver: true, // garante maior performance
}).start();
```

---
## Exemplos de Animações Comuns

Além de efeitos de fade (opacidade), é possível animar outras propriedades como:

- **Translate:** movimentar um componente na tela.
- **Scale:** aumentar ou diminuir o tamanho.
- **Rotate:** girar um componente.

Exemplo combinando fade e movimento vertical:
```tsx
const MoveAndFade = () => {
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
            translateY: anim.interpolate({
              inputRange: [0, 1],
              outputRange: [50, 0],
            }),
          },
        ],
      }}
    >
      <Text>Movendo e sumindo</Text>
    </Animated.View>
  );
};
```

---
## Combinação de Animações: Sequência, Paralelismo e Stagger

Você pode compor animações usando:

- `Animated.sequence([...])`: executa animações uma após a outra.
- `Animated.parallel([...])`: executa animações ao mesmo tempo.
- `Animated.stagger(delay, [...])`: executa animações em sequência, com um intervalo entre elas.

Exemplo básico de sequência:
```tsx
Animated.sequence([
  Animated.timing(animValue, { toValue: 1, duration: 500, useNativeDriver: true }),
  Animated.timing(animValue, { toValue: 0, duration: 500, useNativeDriver: true }),
]).start();
```

---
## Integração com Gestos

A `Animated API` pode ser integrada com bibliotecas de gestos, como o `PanResponder` ou `react-native-gesture-handler`, para criar animações que respondem ao toque e movimento do usuário, melhorando a interação da interface.

---
# LayoutAnimation API: Recursos Adicionais

## Tipos de Animação Embutidos

O `LayoutAnimation` suporta alguns presets para animações comuns, como:

- `easeInEaseOut`
- `linear`
- `spring`

Exemplo de uso com preset:

```tsx
LayoutAnimation.configureNext(LayoutAnimation.Presets.easeInEaseOut);
this.setState({ w: this.state.w - 5, h: this.state.h - 5 });
```

---
## Configurações Personalizadas
É possível criar configurações de animação personalizadas, definindo duração, tipo e propriedades animadas.

---
## Compatibilidade e Limitações

No Android, é necessário habilitar explicitamente a API com:
```tsx

UIManager.setLayoutAnimationEnabledExperimental && UIManager.setLayoutAnimationEnabledExperimental(true);

```
Além disso, algumas propriedades de layout podem não animar como esperado dependendo da plataforma.

---
# Outras Bibliotecas de Animação

Para animações mais avançadas, o React Native tem bibliotecas como:

- `react-native-reanimated`: mais poderosa e performática.
- `react-native-animatable`: para animações pré-definidas simples.
- `lottie-react-native`: para animações vetoriais e JSON.

Essas opções são recomendadas para apps que precisam de interações e animações complexas.