#tag: PT/React Native
# Persistência de Dados em React Native

## Sumário
1. [Introdução](#introducao)
2. [Serialização, Desserialização e Persistência](#serializacao-desserializacao-e-persistencia)
    - [Serialização](#serializacao)
    - [Desserialização](#desserializacao)
    - [Persistência](#persistencia)
3. [Serialização em JavaScript e TypeScript](#serializacao-em-javascript-e-typescript)
4. [Armazenamento de Arquivos em Node.js](#armazenamento-de-arquivos-em-nodejs)
5. [Limitações em Ambientes Mobile](#limitacoes-em-ambientes-mobile)
6. [AsyncStorage: Armazenamento Chave-Valor no React Native](#asyncstorage-armazenamento-chave-valor-no-react-native)
    - [Visão Geral da API do AsyncStorage](#visao-geral-da-api-do-asyncstorage)
    - [Callback vs Async/Await](#callback-vs-asyncawait)
    - [Exemplos Práticos com AsyncStorage](#exemplos-praticos-com-asyncstorage)
    - [Exemplo CRUD com DataManager](#exemplo-crud-com-datamanager)
7. [Boas Práticas e Dicas](#boas-praticas-e-dicas)
8. [Glossário](#glossario)

---

## Introdução

Persistir dados é um requisito fundamental para a maioria dos aplicativos mobile. Seja para armazenar preferências do usuário, cachear respostas de APIs ou salvar objetos complexos, entender serialização, desserialização e persistência é essencial. Este guia cobre os conceitos centrais e abordagens práticas para persistência de dados em React Native, com exemplos em TypeScript e boas práticas.

---

## Serialização, Desserialização e Persistência

### Serialização
Serialização é o processo de converter objetos ou estruturas de dados em um formato contíguo (como um fluxo de bytes) ou textual (como JSON ou XML) para transmissão ou armazenamento.

- **Objetivo:** Permitir transmissão de dados em redes ou armazenamento em arquivos/bancos.

### Desserialização
Desserialização é o processo inverso: reconstruir objetos ou estruturas de dados a partir de um formato serializado.

- **Objetivo:** Permitir comunicação e troca de dados entre sistemas ou estados da aplicação.

### Persistência
Persistência refere-se à capacidade de manter dados mesmo após o fechamento do app ou dispositivo. Os dados podem ser persistidos em cache, arquivos ou bancos, preservando o estado da aplicação entre sessões.

- **Objetivo:** Restaurar e manter o estado da aplicação até que novos dados sejam recebidos ou atualizados.

---

## Serialização em JavaScript e TypeScript

Em JavaScript e TypeScript, a serialização é normalmente feita usando formatos textuais como JSON. Diferente de Java ou C#, que podem serializar para binário ou texto, JS/TS usam principalmente JSON em ambientes web e mobile.

```ts
export class Produto {
  codigo: number;
  nome: string;
  quantidade: number;

  constructor(codigo: number, nome: string, quantidade: number) {
    this.codigo = codigo;
    this.nome = nome;
    this.quantidade = quantidade;
  }
}
```

Para transmitir ou armazenar um objeto `Produto`, converta-o para JSON:

```ts
import { Produto } from './Produto';

const prod1: Produto = new Produto(1, 'Teclado', 50);
const prod1Str: string = JSON.stringify(prod1);
const prod2: Produto = JSON.parse(prod1Str) as Produto;
```

- `JSON.stringify()` serializa o objeto para uma string JSON.
- `JSON.parse()` desserializa a string de volta para um objeto.

---

## Armazenamento de Arquivos em Node.js

Para armazenamento local de arquivos em Node.js, use o módulo nativo `fs` (File System):

```ts
const fs = require('fs');

let prod1 = null;
try {
  let prodStr = fs.readFileSync('prod1.json');
  prod1 = JSON.parse(prodStr);
} catch (err) {
  prod1 = { codigo: 1, nome: 'Teclado', quantidade: 50 };
  let prodStr = JSON.stringify(prod1);
  fs.writeFileSync('prod1.json', prodStr);
}
```

- `fs.readFileSync()` lê um arquivo como string, que é então convertida para objeto.
- `fs.writeFileSync()` grava uma string em um arquivo.

> **Nota:** Operações síncronas de arquivo não são recomendadas em apps mobile, pois podem travar a UI. O módulo `fs` do Node.js **não é compatível** com React Native. Use AsyncStorage para persistência mobile.

---

## Limitações em Ambientes Mobile

- Operações síncronas de arquivo podem travar a interface em dispositivos móveis.
- O módulo `fs` do Node.js **não é compatível** com React Native.
- Use **AsyncStorage** ou outras soluções mobile-friendly para persistência.

---

## AsyncStorage: Armazenamento Chave-Valor no React Native

AsyncStorage é um sistema simples, assíncrono e persistente de armazenamento chave-valor para React Native. Ideal para armazenar pequenas quantidades de dados, como preferências do usuário ou respostas cacheadas.

- Armazena dados como pares chave-valor (como uma chave primária em banco).
- Os valores devem ser serializados (geralmente como strings JSON).

### Visão Geral da API do AsyncStorage

| Método         | Parâmetros      | Retorno/Callback                | Funcionalidade                                        |
| -------------- | -------------- | ------------------------------- | ----------------------------------------------------- |
| `getItem`      | key            | Promise<string | null>          | Obtém um item pela chave.                             |
| `setItem`      | key, value     | Promise<void>                   | Armazena um item pela chave.                          |
| `removeItem`   | key            | Promise<void>                   | Remove um item pela chave.                            |
| `mergeItem`    | key, value     | Promise<void>                   | Mescla valor com item existente.                      |
| `getAllKeys`   | nenhum         | Promise<string[]>               | Obtém todas as chaves.                                |
| `multiGet`     | keys[]         | Promise<[string, string|null][]> | Obtém múltiplos itens pelas chaves.                   |

> **Dica:** Sempre use o padrão async/await para clareza e tratamento de erros.

### Callback vs Async/Await

| Característica      | Callback Style                      | async/await Style         |
| -------------------| ----------------------------------- | ------------------------- |
| Sintaxe            | Funções dentro de funções           | Sequencial, legível       |
| Leitura            | Pode ficar confuso (callback hell)  | Muito mais claro          |
| Tratamento de erro | Dentro do callback                  | Com `try...catch`         |
| Complexidade       | Maior com muitas operações          | Menor, mais elegante      |

#### Exemplo: Salvando e Recuperando Dados

```tsx
import AsyncStorage from '@react-native-async-storage/async-storage';

const salvarTema = async (tema: string): Promise<void> => {
  try {
    await AsyncStorage.setItem('tema', tema);
  } catch (e) {
    console.error(e);
  }
};

const obterTema = async (): Promise<string | null> => {
  try {
    return await AsyncStorage.getItem('tema');
  } catch (e) {
    console.error(e);
    return null;
  }
};
```

#### Exemplo: Salvando e Recuperando Objetos

```tsx
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Produto } from './Produto';

const salvarProduto = async (key: string, value: Produto): Promise<void> => {
  try {
    const jsonValue = JSON.stringify(value);
    await AsyncStorage.setItem(key, jsonValue);
  } catch (e) {
    console.error(e);
  }
};

const removerProduto = async (key: string): Promise<void> => {
  try {
    await AsyncStorage.removeItem(key);
  } catch (e) {
    console.error(e);
  }
};

const obterProdutosJSON = async (): Promise<[string, string | null][]> => {
  try {
    const keys = await AsyncStorage.getAllKeys();
    return await AsyncStorage.multiGet(keys);
  } catch (e) {
    console.error(e);
    return [];
  }
};

const obterProdutos = async (): Promise<Produto[]> => {
  try {
    const objetos: Produto[] = [];
    const objJSON = await obterProdutosJSON();
    objJSON.forEach(element => {
      if (element[1] !== null) {
        const produto: Produto = JSON.parse(element[1]);
        objetos.push(produto);
      }
    });
    return objetos;
  } catch (e) {
    console.error(e);
    return [];
  }
};
```

---

## Exemplo CRUD com DataManager

Uma classe centralizada para gerenciar operações CRUD com AsyncStorage:

```tsx
class DataManager {
  public async remover(key: number): Promise<void> {
    await removerProduto(key.toString());
  }

  public async adicionar(produto: Produto): Promise<void> {
    await salvarProduto(produto.codigo.toString(), produto);
  }

  public async obterTodos(): Promise<Produto[]> {
    return await obterProdutos();
  }
}

export default DataManager;
```

- `adicionar(produto: Produto)`: Salva um produto.
- `remover(key: number)`: Remove um produto pela chave.
- `obterTodos()`: Recupera todos os produtos.

---

## Boas Práticas e Dicas

- **Sempre serialize objetos** antes de armazenar (use `JSON.stringify`).
- **Valide os dados** antes de salvar ou após carregar (considere usar [Zod](https://zod.dev/) para validação de esquemas).
- **Trate erros** com `try...catch` em todas as operações assíncronas.
- **Evite armazenar dados sensíveis** no AsyncStorage; use armazenamento seguro para credenciais.
- **Para dados complexos ou apps offline-first**, considere bancos como [Realm](./Realm%20Database%20-%20Conceitos%20e%20Estrutura.md) ou [WatermelonDB](https://nozbe.github.io/WatermelonDB/).
- **Com Expo:** Use `expo-secure-store` para dados sensíveis e `expo-file-system` para arquivos.
- **Com TanStack Query:** Use AsyncStorage como provedor de cache para persistência offline de dados de queries.

---

## Glossário

- **Serialização:** Converter um objeto para um formato armazenável ou transmissível (ex: JSON).
- **Desserialização:** Reconstruir um objeto a partir do formato serializado.
- **Persistência:** Manter dados entre sessões do app.
- **AsyncStorage:** API de armazenamento chave-valor do React Native.
- **Callback:** Função passada como argumento para outra função, executada após a primeira concluir.
- **async/await:** Sintaxe JavaScript para escrever código assíncrono de forma sequencial.
- **CRUD:** Operações de Criar, Ler, Atualizar e Deletar para gerenciamento de dados.
