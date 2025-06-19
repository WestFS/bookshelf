#tag: PT/React Native
# Principais modelos de navegação no ReactNative
Em aplicações React Native, a navegação entre telas é essencial. Os principais termos e elementos relacionados à navegação são:

- **Pages (Páginas)**: Tela inicial, página home.
- **Screens (Telas)**: Outras páginas secundárias da aplicação.
- **Links**: Internos (entre componentes) e externos (navegador ou apps).
- **Breadcrumb**: Caminho de navegação entre telas.
- **Menus**: Horizontais ou verticais.
- **Navbar**: Barra de navegação superior.

> Os termos `pages` e `screens` são amplamente utilizados na estruturação de navegação em React Native.


Os exemplos desta documentação utilizam as seguintes bibliotecas:
- @react-navigation/native
- @react-navigation/native-stack
- @react-navigation/bottom-tabs
- @react-navigation/drawer
- react-native-reanimated
- react-native-gesture-handler
- react-native-screens
- react-native-safe-area-context


## 1. Stack Navigation

### Conceito

O **Stack Navigator** é baseado no empilhamento de telas, como uma pilha de cartas. A cada nova tela, uma nova "carta" é empilhada sobre a anterior. Ao "voltar", a tela atual é removida e a anterior reaparece.

### Requisitos

- `NavigationContainer` (envolve toda a navegação).
- `createNativeStackNavigator`.
- Pelo menos **duas telas** já implementadas.

### Vantagens
- **Navegador**: Semelhante à forma como os navegadores da web funcionam, onde você pode abrir novas páginas e retornar às anteriores.
- **Histórico**: Mantém um histórico das telas visitadas, permitindo que o usuário navegue para trás ou para a frente (em cenários mais específicos).
- **Transição entre telas**: Animações suaves ao navegar.
- **Gestão do histórico de navegação**: Controla a ordem das telas visitadas.
- **Navegador**: Semelhante à forma como os navegadores da web funcionam, onde você pode abrir novas páginas e retornar às anteriores.
- **Histórico**: Mantém um histórico das telas visitadas, permitindo que o usuário navegue para trás ou para a frente (em cenários mais específicos).

###  Exemplo de uso básico

```tsx
// App.js
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

### Navegação entre telas
``` tsx
// HomeScreen.js
const HomeScreen = ({ navigation }) => {
  return (
    <Button
      title="Ir para o perfil da Jane"
      onPress={() => navigation.navigate('Profile', { name: 'Jane' })}
    />
  );
};
```


```tsx
// ProfileScreen.js
const ProfileScreen = ({ route }) => {
  return <Text>Este é o perfil de {route.params.name}</Text>;
};

```

### Navegação por props
```tsx
navigation.navigate('Profile') // vai para a tela
navigation.push('Home') // empilha outra instância da mesma tela
```

Com a criacao do container usando o  **Stack.Navigator** as props passadas dentro desse ccontainer serao as telas na qual sao armazenadas em formas de pilhas, na qual poderao ser acessadas de duas formas navigate e push

Como mencionado anteriormente os props de: 
- Navegação
	navigation.navigate('About')
    navigation.navigate('Home')
- Histórico
	navigation.push('Home')


---

## 2. Tab Navigation

### Conceito

O **Tab Navigator** permite a navegação por **abas localizadas na parte inferior da tela**. É um padrão comum em apps móveis.

### Requisitos
- `@react-navigation/bottom-tabs`
- `NavigationContainer`
- `createBottomTabNavigator`

### Vantagens

| Vantagem                             | Descrição                                                               |
| ------------------------------------ | ----------------------------------------------------------------------- |
| Interface familiar                   | Navegação com abas é padrão em apps populares                           |
| Acesso rápido                        | Troca de seção com um único toque                                       |
| Altamente customizável               | Ícones, cores, estilos e badges configuráveis                           |
| Navegação por seção                  | Cada aba pode conter seu próprio navegador interno                      |
| Flexível e modular                   | Pode ser combinada com Stack e Drawer                                   |
| Ideal para apps com áreas principais | Quando o app precisa de acesso direto a suas principais funcionalidades |

### Exemplo de uso básico

``` tsx
import * as React from 'react';
 import { View, Text } from 'react-native';
 import { NavigationContainer } from '@react-navigation/native';
 import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

 import HomeScreen from './screens/home';
 import AboutScreen from './screens/about';

 const Tab = createBottomTabNavigator();

 function App() {
     return (
     <NavigationContainer>
         <Tab.Navigator>
         <Tab.Screen name='Home' component={HomeScreen} />
         <Tab.Screen name='About' component={AboutScreen} />
         </Tab.Navigator>
     </NavigationContainer>
     );
 }

 export default App;
```

### Observações
- Os botões na parte inferior da tela são responsáveis por trocar de telas (tabs).
- É possível adicionar **ícones**, customizar cores e estilos, e definir a **aba inicial**.
- Cada `Tab.Screen` pode apontar para uma **tela simples** ou até para uma **pilha de navegação completa**, usando `Stack.Navigator`.

### Etapas de Implementação

1. Importar a dependência `@react-navigation/bottom-tabs`.
2. Criar uma constante (`Tab`) com `createBottomTabNavigator()`.
3. Dentro do `NavigationContainer`, incluir o `Tab.Navigator`.
4. Adicionar as telas com `Tab.Screen`, definindo nome e componente.

### Navegação entre telas

No **Tab Navigation**, a navegação acontece ao tocar nas abas visíveis na parte inferior da tela. Isso substitui o uso de botões com `navigation.navigate()`, como no Stack Navigator.

Apesar disso, também é possível navegar programaticamente entre abas usando:
```tsx
navigation.navigate('About');
```

--- 
## 3. Drawer Navigation

### Conceito

O **Drawer Navigator** oferece um **menu lateral oculto** que pode ser aberto deslizando da lateral da tela ou clicando em um botão. É útil para aplicativos com muitas opções de navegação.

### Requisitos 
- `@react-navigation/drawer`
- `NavigationContainer`
- `createDrawerNavigator`
- `react-native-gesture-handler` (essencial para gestos)
### Vantagens
| Vantagem                       | Descrição                                                               |
| ------------------------------ | ----------------------------------------------------------------------- |
| Economia de espaço na tela     | O menu fica oculto até ser aberto, deixando mais espaço para o conteúdo |
| Organização para muitas seções | Ideal para apps com várias rotas ou áreas secundárias                   |
| Boa experiência em tablets     | O layout lateral combina bem com telas maiores                          |
| Suporte a gestos               | Pode ser aberto por swipe lateral (gesto), oferecendo navegação fluida  |
| Altamente personalizável       | É possível adicionar cabeçalho, avatar, ícones e estilos                |
| Integração com Stack e Tab     | Pode ser usado junto com outras navegações para apps mais completos     |
| Familiaridade com apps Android | Muito comum em apps Android, o que melhora a experiência do usuário     |

![](../../../imgs/Drawer Navigation.png)

### Exemplo de uso básico
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

### Navegação entre telas
O Drawer cria um menu (estilo hambúrguer ou sanduíche) no topo/header de nosso aplicativo. Tal menu contém o link para as telas incluídas como `Screen` dentro de `Drawer.Navigator`. Além disso, esses links também ficam visíveis quando se arrasta a tela do canto esquerdo para o centro.

#### Métodos úteis:

- **Abrir o Drawer:** `navigation.openDrawer();`
- **Fechar o Drawer:** `navigation.closeDrawer();`
- **Navegar entre telas:** `navigation.navigate('Settings')`; e `navigation.goBack();`

---
#  Combinação de modelos de navegação

Os modelos de navegação apresentados (Stack, Tab e Drawer) podem ser usados **individualmente**, como demonstrado nos códigos deste módulo, **ou de forma combinada**.

### Como combinar navegadores

Ao optar por combinar modelos de navegação, é importante considerar:

- **Apenas um `NavigationContainer`**  
  Seu aplicativo **deve ter apenas um `NavigationContainer`**. Ao combinar navegadores, você **não pode envolver cada um deles com um container separado**.

- **Composição via `component`**  
  Um tipo de navegador pode **ser definido como um componente de tela (`component`)** dentro de outro. Por exemplo:
  
  - Um `Tab.Navigator` pode conter stacks em cada aba.
  - Um `Drawer.Navigator` pode ter uma aba com navegação por stack.

### Quando faz sentido combinar?

A combinação **é mais útil em aplicativos com múltiplas telas ou funcionalidades complexas**, como:

- Aplicativos com **áreas distintas** (ex: feed, perfil, configurações);
- Aplicativos com **menus laterais** e **subtelas internas**;
- Casos em que se deseja uma navegação mais fluida e organizada para o usuário.

> ⚠️ Para apps simples, como um com apenas 2 telas, **não faz sentido adicionar complexidade** usando múltiplos tipos de navegação combinados.

---

### Exemplo de combinação

```tsx
function App() {
  return (
    <NavigationContainer>
      <Drawer.Navigator>
        <Drawer.Screen name="MainTabs" component={MyTabs} />
        <Drawer.Screen name="Settings" component={SettingsScreen} />
      </Drawer.Navigator>
    </NavigationContainer>
  );
}

function MyTabs() {
  return (
    <Tab.Navigator>
      <Tab.Screen name="Home" component={HomeStack} />
      <Tab.Screen name="About" component={AboutScreen} />
    </Tab.Navigator>
  );
}

function HomeStack() {
  return (
    <Stack.Navigator>
      <Stack.Screen name="Feed" component={FeedScreen} />
      <Stack.Screen name="Post" component={PostScreen} />
    </Stack.Navigator>
  );
}
```

