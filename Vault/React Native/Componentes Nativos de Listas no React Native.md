O React Native oferece três componentes principais para renderização  de listas:

- `VirtualizedList`
- `FlatList`
- `SectionList`

Esses componentes são ideais para exibir coleções de dados no formato de listas, como arrays e objetos. A principal vantagem é que eles utilizam **renderização virtualizada**, o que melhora significativamente o desempenho, especialmente com grandes volumes de dados.

##  VirtualizedList
### O que é?
`VirtualizedList` é o **componente base** para os outros dois (`FlatList` e `SectionList`). Ele permite renderizar apenas os itens visíveis na tela, economizando recursos e melhorando o desempenho em listas extensas.
### Vantagens:
- Otimização de performance
- Renderização sob demanda (lazy loading)
- Manutenção de uma "janela" de itens visíveis
- Boa escalabilidade para listas longas

Exemplo de Uso:
```TSX
import React from 'react';
import {View, VirtualizedList, StyleSheet, Text, StatusBar} from 'react-native';
import {SafeAreaView, SafeAreaProvider} from 'react-native-safe-area-context';

// Tipagem do item
type ItemData = {
  id: string;
  title: string;
};

// Retorna um item individual
const getItem = (_data: unknown, index: number): ItemData => ({
  id: Math.random().toString(12).substring(0),
  title: `Item ${index + 1}`,
});

// Retorna o número total de itens
const getItemCount = (_data: unknown) => 50;

// Componente do item
const Item = ({ title }: { title: string }) => (
  <View style={styles.item}>
    <Text style={styles.title}>{title}</Text>
  </View>
);

// Componente principal
const App = () => (
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

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: StatusBar.currentHeight,
  },
  item: {
    backgroundColor: '#f9c2ff',
    height: 150,
    justifyContent: 'center',
    marginVertical: 8,
    marginHorizontal: 16,
    padding: 20,
  },
  title: {
    fontSize: 32,
  },
});

export default App;

```

##  Atributos Fundamentais

### 🔸 `data`

Tipo opaco de dado passado para as funções `getItem` e `getItemCount` para acessar os itens da lista.

| Propriedade | Valor |
| ----------- | ----- |
| Tipo        | `any` |
| Obrigatório | ✅ Sim |

---

### 🔸 `getItem`

Função que extrai um item do conjunto de dados com base no índice.

```tsx
(data: any, index: number) => any;
```

| Propriedade | Valor      |
| ----------- | ---------- |
| Tipo        | `function` |
| Obrigatório | ✅ Sim      |

---

### 🔸 `getItemCount`

Função que retorna a quantidade total de itens presentes em `data`.

```tsx
(data: any) => number;
```
 
| Propriedade | Valor      |
| ----------- | ---------- |
| Tipo        | `function` |
| Obrigatório | ✅ Sim      |

---
### 🔸 `renderItem`

Função que recebe um item de `data` e o renderiza como um componente da lista.

```tsx
(info: any) => ?React.Element<any>
```
 
| Propriedade | Valor      |
| ----------- | ---------- |
| Tipo        | `function` |
| Obrigatório | ✅ Sim      |

---

🔸`initialNumToRender`
Número inicial de itens a serem renderizados assim que a lista é montada. Isso afeta o desempenho inicial e a experiência visual do usuário.
```tsx
number
```

| Propriedade | Valor    |
| ----------- | -------- |
| Tipo        | `number` |
| Obrigatório | ❌ Não    |

> [!NOTE]
> **Dica:** Ajuste esse valor conforme a altura dos itens e o espaço visível na tela. Um número muito alto pode impactar a performance inicial; um número muito baixo pode causar espaços em branco visíveis ao carregar a lista.

---
### 🔸 ``keyExtractor``

Função que retorna uma chave única para cada item da lista, usada para melhorar a performance na renderização.

```tsx
(item: any, index: number) => string
```
 
| Propriedade | Valor      |
| ----------- | ---------- |
| Tipo        | `function` |
| Obrigatório | ✅ Sim      |

---



##  Exemplos de Uso

```tsx
const data = ['Maçã', 'Banana', 'Laranja'];

const getItem = (data: string[], index: number) => data[index];

const getItemCount = (data: string[]) => data.length;

const renderItem = ({ item }: { item: string }) => (
  <Text>{item}</Text>
);
```
## Notas e Dicas

- O parâmetro `data` pode ser qualquer estrutura iterável (array, objeto, Map, etc.). A responsabilidade de interpretar esse tipo é do `getItem` e `getItemCount`.
- Para melhor performance, evite recriar as funções `getItem`, `getItemCount` e `renderItem` dentro do corpo do componente.
- `renderItem` normalmente recebe um objeto no formato `{ item: T, index: number }`. Dependendo da biblioteca (como React Native's FlatList), o formato pode variar.

---

##  Sugestão de Tipagem para `info`

Você pode tipar melhor `renderItem` para maior segurança com TypeScript:
```tsx
type RenderItemInfo<T> = {
  item: T;
  index: number;
};

const renderItem = ({ item, index }: RenderItemInfo<string>) => (
  <Text key={index}>{item}</Text>
);
```


---

#  SectionList

O `SectionList` é um componente para exibição de listas que permite agrupar os itens em seções com cabeçalhos personalizados. Ele é ideal quando você quer organizar os dados de forma categorizada.

```tsx
import React from 'react';
import {StyleSheet, Text, View, SectionList, StatusBar} from 'react-native';
import {SafeAreaView, SafeAreaProvider} from 'react-native-safe-area-context';

const DATA = [
  {
    title: 'Main dishes',
    data: ['Pizza', 'Burger', 'Risotto'],
  },
  {
    title: 'Sides',
    data: ['French Fries', 'Onion Rings', 'Fried Shrimps'],
  },
  {
    title: 'Drinks',
    data: ['Water', 'Coke', 'Beer'],
  },
  {
    title: 'Desserts',
    data: ['Cheese Cake', 'Ice Cream'],
  },
];

const App = () => (
  <SafeAreaProvider>
    <SafeAreaView style={styles.container} edges={['top']}>
      <SectionList
        sections={DATA}
        keyExtractor={(item, index) => item + index}
        renderItem={({item}) => (
          <View style={styles.item}>
            <Text style={styles.title}>{item}</Text>
          </View>
        )}
        renderSectionHeader={({section: {title}}) => (
          <Text style={styles.header}>{title}</Text>
        )}
      />
    </SafeAreaView>
  </SafeAreaProvider>
);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: StatusBar.currentHeight,
    marginHorizontal: 16,
  },
  item: {
    backgroundColor: '#f9c2ff',
    padding: 20,
    marginVertical: 8,
  },
  header: {
    fontSize: 32,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
  },
});

export default App;

```

![[SectionList.png]]


##  Atributos Fundamentais do `SectionList`
### 🔸 `renderItem`

Função que recebe um item de `data` e o renderiza como um componente da lista.

```tsx
(info: any) => ?React.Element<any>
```
 
| Propriedade | Valor      |
| ----------- | ---------- |
| Tipo        | `function` |
| Obrigatório | ✅ Sim      |

### 🔸 `sections`

Array que representa os grupos de itens da lista. Cada objeto da array deve conter as propriedades `title` (nome da seção) e `data` (itens da seção).

```tsx
type Section<T> = {
  title: string;
  data: T[];
};
```
 
| Propriedade | Valor              |
| ----------- | ------------------ |
| Tipo        | `array of Section` |
| Obrigatório | ✅ Sim              |

---
#  FlatList

Componente de lista utilizado para renderizar listas simples e básicas, com ótimo desempenho.

Além disso, oferece suporte a diversas funcionalidades:

- Totalmente multiplataforma.
- Modo horizontal opcional.
- Callbacks de visibilidade configuráveis.
- Suporte a cabeçalho (`Header`).
- Suporte a rodapé (`Footer`).
- Suporte a separadores (`Separator`).
- Pull to Refresh (arrastar para atualizar).
- Carregamento ao rolar (`Scroll loading`).
- Suporte a `ScrollToIndex`.
- Suporte a múltiplas colunas.

### Exemplo de `FlatList` Selecionável
```tsx
import React, {useState} from 'react';
import {
  FlatList,
  StatusBar,
  StyleSheet,
  Text,
  TouchableOpacity,
} from 'react-native';
import {SafeAreaView, SafeAreaProvider} from 'react-native-safe-area-context';

type ItemData = {
  id: string;
  title: string;
};

const DATA: ItemData[] = [
  {
    id: 'bd7acbea-c1b1-46c2-aed5-3ad53abb28ba',
    title: 'First Item',
  },
  {
    id: '3ac68afc-c605-48d3-a4f8-fbd91aa97f63',
    title: 'Second Item',
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d72',
    title: 'Third Item',
  },
];

type ItemProps = {
  item: ItemData;
  onPress: () => void;
  backgroundColor: string;
  textColor: string;
};

const Item = ({item, onPress, backgroundColor, textColor}: ItemProps) => (
  <TouchableOpacity onPress={onPress} style={[styles.item, {backgroundColor}]}>
    <Text style={[styles.title, {color: textColor}]}>{item.title}</Text>
  </TouchableOpacity>
);

const App = () => {
  const [selectedId, setSelectedId] = useState<string>();

  const renderItem = ({item}: {item: ItemData}) => {
    const backgroundColor = item.id === selectedId ? '#6e3b6e' : '#f9c2ff';
    const color = item.id === selectedId ? 'white' : 'black';

    return (
      <Item
        item={item}
        onPress={() => setSelectedId(item.id)}
        backgroundColor={backgroundColor}
        textColor={color}
      />
    );
  };

  return (
    <SafeAreaProvider>
      <SafeAreaView style={styles.container}>
        <FlatList
          data={DATA}
          renderItem={renderItem}
          keyExtractor={item => item.id}
          extraData={selectedId}
        />
      </SafeAreaView>
    </SafeAreaProvider>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: StatusBar.currentHeight || 0,
  },
  item: {
    padding: 20,
    marginVertical: 8,
    marginHorizontal: 16,
  },
  title: {
    fontSize: 32,
  },
});

export default App;

```

##  Atributos Fundamentais do `FlatList`

Como o `FlatList` herda do `VirtualizedList`, ele possui os mesmos atributos fundamentais (`data`, `renderItem`, `keyExtractor`, etc.), e muitos outros específicos para suas funcionalidades. No exemplo fornecido de `FlatList`, os atributos `data`, `renderItem` e `keyExtractor` já são utilizados.