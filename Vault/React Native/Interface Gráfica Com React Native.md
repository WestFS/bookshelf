# Interface Gráfica Com React Native
	ScrollView
	SafeAreaView
	KeyboardAvoidingView

## Modal 
Componente nativo do React Native para exibir na tela inteira algum conteudo sem que precise sair da pagina algo como (caixa de dialogo, formulario,aleaart, etc..) pareccido com um Popup

```JSX
import React, { useState } from 'react';
import { Modal, View, Text, Button, StyleSheet } from 'react-native';

const App = () => {
  const [visible, setVisible] = useState(false);

  return (
    <View style={styles.container}>
      <Button title="Abrir Modal" onPress={() => setVisible(true)} />
      <Modal
        visible={visible}
        transparent={true}
        animationType="slide"
        onRequestClose={() => setVisible(false)}
      >
        <View style={styles.modalBackground}>
          <View style={styles.modalContent}>
            <Text>Este é um Modal</Text>
            <Button title="Fechar" onPress={() => setVisible(false)}/>
          </View>
        </View>
      </Modal>
    </View>
  );
};

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

export default App;
```

```JSX
const [modalVisible, setModalVisible] = useState(false);

return (
  <View>
    {/* Isso aparece quando modalVisible é true */}
    <Modal visible={modalVisible}>
      <Text>Este é o Modal</Text>
    </Modal>

    {/* Botão para abrir o modal */}
    <Pressable onPress={() => setModalVisible(true)}>
      <Text>Abrir Modal</Text>
    </Pressable>
  </View>
);

```


## Botões
Sao um dos componentes nativos do React Natives alguns dos seguintes comandos 
- Button
- TouchableHighlight
- TouchableOpacity
- TouchableWithoutFeedback

> A principal característica do Button é reagir a eventos de interação por parte do usuário, como o toque, leve ou demorado, sobre eles.

![[Button-ReactNative.png]]

E recomendando pela documentacao do React Native a utiliza;'ao de componentes pressable em vez de componentes legados como 

- TouchableHighlight
- TouchableOpacity
- TouchableWithoutFeedback

| Recurso / Componente      | `Pressable`    | `TouchableOpacity` | `TouchableHighlight` | `TouchableWithoutFeedback` |
| ------------------------- | -------------- | ------------------ | -------------------- | -------------------------- |
| Controle sobre eventos    | ✅ Total        | ⚠️ Limitado        | ⚠️ Limitado          | ⚠️ Limitado                |
| Estilo dinâmico (pressed) | ✅ Sim          | ❌ Não              | ❌ Não                | ❌ Não                      |
| Feedback visual embutido  | 🔄Customizável | ✅ Opacidade        | ✅ Cor de fundo       | ❌ Nenhum                   |
| onPress                   | ✅ Sim          | ✅ Sim              | ✅ Sim                | ✅ Sim                      |
| onPressIn / onPressOut    | ✅ Sim          | ✅ Sim              | ✅ Sim                | ✅ Sim                      |
| onLongPress               | ✅ Sim          | ✅ Sim              | ✅ Sim                | ✅ Sim                      |
| Flexibilidade             | 🔝 Alta        | Média              | Média                | Baixa                      |
| Substitui                 | ✅ Todos        | ❌                  | ❌                    | ❌                          |


Exemplo de uso 
```JSX
import { Pressable, Text, StyleSheet } from 'react-native';

export default function App() {
  return (
    <Pressable
      onPress={() => console.log('Pressionado!')}
      style={({ pressed }) => [
        {
          backgroundColor: pressed ? '#ddd' : '#0af',
        },
        styles.button,
      ]}
    >
      <Text style={styles.text}>Pressione aqui</Text>
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

## ActivyIndicator
O `ActivityIndicator` é um componente de **indicador de carregamento** que pode ser exibido enquanto o app está processando alguma operação que leva tempo, como uma requisição de rede, carregamento de dados ou operações pesadas.

Exemplo:
```JSX
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
Sendo ele uma abstracao de componentes nativos que por de tras do pano exibi uuma tela de carregamento enquanto o codigo em ReactNative faz o **bridge** com o javascript para se comunicar com sua api atravez da arquitetura JSI