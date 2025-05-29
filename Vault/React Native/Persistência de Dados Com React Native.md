
## Serialização, Deserialização e Persistência
### Conceito
Quando falamos sobre armazenamento de dados, é crucial entender alguns conceitos importantes:

### **Serialização**
É o processo de converter objetos ou estruturas de dados em um formato contíguo (como uma sequência de bytes) ou textual (como **XML** ou **JSON**) para que possam ser transmitidos ou armazenados.

- **Objetivo:** Possibilitar a transmissão de dados em rede ou seu armazenamento.

### **Deserialização**
É o processo inverso da serialização. Consiste em reconstruir os objetos ou estruturas de dados a partir de um formato serializado.

- **Objetivo:** Permitir a comunicação e a troca de informações entre diferentes sistemas.

### **Persistência**
Refere-se à capacidade de manter os dados disponíveis mesmo após o encerramento de um programa ou dispositivo. Os dados podem ser persistidos em cache ou em bancos de dados, preservando o estado da aplicação em tempo de execução.

- **Objetivo:** Resgatar e manter o estado da aplicação até que novos estados sejam recebidos.

![Exemplo de serialização](imgs/Serialization.png)


---
### Serialização em JavaScript e TypeScript

Em aplicações **JavaScript** e **TypeScript**, a serialização de objetos para transmissão em ambientes web é geralmente feita através de **arquivos textuais**, utilizando formatos como **JSON** ou **XML**. Diferente de linguagens como Java e C#, que podem serializar tanto por bytes quanto por texto.
``` ts
export class Produto{
	codigo: number;
	nome: string;
	quantidade: number;

	constructor(codigo: number, nome: string, quantidade: number){
		this.codigo = codigo;
		this.nome = nome;
		this.quantidade = quantidade;
	}
}
```
Quando um objeto `Produto` é criado, ele ocupa áreas de memória que não são contíguas. Para transmitir ou armazenar as informações desse objeto, precisamos convertê-lo para uma representação apropriado em modo texto, como **JSON**.

**Exemplo de Serialização e Deserialização com JSON:**

A transformação de um objeto `Produto` para **JSON** e o processo inverso podem ser vistos no código abaixo:
```ts
import { Produto } from './Produto';

 let prod1: Produto = new Produto(1,'Teclado',50);
 let prod1Str: string = JSON.stringify(prod1);
 let prod2: Produto = JSON.parse(prod1Str) as Produto;
```

Neste exemplo, a classe `JSON`, que faz parte do núcleo do **Node.js**, é utilizada. O método `JSON.stringify()` serializa o objeto `prod1` para uma string **JSON**, e o método `JSON.parse()` deserializa essa string de volta para um objeto `prod2`.

---
### Leitura e Gravação de Arquivos em Node.js
> Agora que entendemos como serializar dados, vamos ver como é persistir essas informações utilizando arquivos locais com Node.js.

Para gravar e ler informações em arquivos no **Node.js**, é comum usar a biblioteca `fs` (File System):

```ts
const fs = require('fs');

 let prod1 = null;
 try{
     let prodStr = fs.readFileSync('prod1.json');
     prod1 = JSON.parse(prodStr);
 }catch(err){
     prod1 = {codigo: 1, nome: 'Teclado', quantidade: 50};
     let prodStr = JSON.stringify(prod1);
     fs.writeFileSync('prod1.json',prodStr);
 }
                   
```
O método `fs.readFileSync()` lê um arquivo diretamente para uma variável de texto, que é então convertida para um objeto usando `JSON.parse()`. A gravação é feita com `fs.writeFileSync()`.


> [!NOTE]  Limitações em Ambientes Móveis
> A gravação síncrona de arquivos, como demonstrada acima, não é ideal para dispositivos móveis, pois pode causar travamentos na interface gráfica. Além disso, a biblioteca `fs` não é compatível com **React Native**. Nestes cenários, recomenda-se o uso de **AsyncStorage**, uma solução de armazenamento assíncrona, que será explorada nas próximas seções.

**Glossário:**

- **Parser:** Um analisador sintático que determina a estrutura lógica de um texto, de acordo com uma sintaxe de linguagem.

---
## Armazenamento com AsyncStorage

Uma forma simples de persistência assíncrona é pelo **AsyncStorage**, que permite guardar e recuperar pares do tipo **key-value**, ou seja, um identificador e um dado associado, da mesma forma que uma chave primária identificando um registro em uma tabela. Para utilizar objetos como valores, eles devem estar serializados no formato **JSON**, com a utilização dos métodos descritos anteriormente.

O quadro apresentado a seguir descreve os principais métodos de AsyncStorage.

| Método         | Parâmetros      | Callback                      | Funcionalidade                                        |
| -------------- | --------------- | ----------------------------- | ----------------------------------------------------- |
| **getltem**    | key             | (error, result) => void       | Obtém um item da coleção a partir da chave fornecida. |
| **setltem**    | key   <br>value | (error) => void               | Armazena um novo item da coleção a partir da chave.   |
| **removeltem** | key             | (error) => void               | Remove um item a partir da chave fornecida.           |
| **mergeltem**  | key   <br>value | (error) => void               | Atualiza um item da coleção localizado pela chave.    |
| **getAllKeys** | (nothing)       | (error, keys[ ]) => void      | Obtém todas as chaves que estão na coleção.           |
| **multiGet**   | key[ ]          | (erros[ ], result[ ]) => void | Obtém múltiplos itens.                                |

> [!NOTE] O que é um **callback**?
> Um **callback** é uma função que você passa como **parâmetro para outra função**, e que será **executada depois** que essa função terminar sua tarefa — normalmente usada para lidar com **operações assíncronas** (que demoram, como leitura de dados).

Para usar o AsyncStorage, você vai precisar dos seguintes conceitos assíncronos:
- **async**
- **await**
- **then**

### **Diferença entre callback e async/await**

| Característica     | Callback                             | async/await              |
| ------------------ | ------------------------------------ | ------------------------ |
| Estilo de escrita  | Usa funções dentro de funções        | Parece código sequencial |
| Leitura            | Pode ficar confuso com muitos níveis | Muito mais claro         |
| Tratamento de erro | Feito dentro do callback             | Feito com `try...catch`  |
| Complexidade       | Maior quando tem várias operações    | Menor e mais elegante    |

```tsx
const saveTheme = async (theme: string): Promise<void> => {
  try {
    await AsyncStorage.setItem('theme', theme);
  } catch (e) {
    console.error(e);
  }
}

```

```tsx
const getTheme = async (): Promise<string | null> => {
  try {
    return await AsyncStorage.getItem('theme');
  } catch (e) {
    console.error(e);
    return null;
  }
}
```


```tsx
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Product } from './Product';

// Funções utilitárias
const saveProduct = async (key: string, value: any): Promise<void> => {
  try {
    const jsonValue = JSON.stringify(value);
    await AsyncStorage.setItem(key, jsonValue);
  } catch (e) {
    console.error(e);
  }
}

const removeProduct = async (key: string): Promise<void> => {
  try {
    await AsyncStorage.removeItem(key);
  } catch (e) {
    console.error(e);
  }
}

const getProductJSON = async (): Promise<[string, string | null][]> => {
  try {
    const keys = await AsyncStorage.getAllKeys();
    return await AsyncStorage.multiGet(keys);
  } catch (e) {
    console.error(e);
    return [];
  }
}

const getProduct = async (): Promise<Product[]> => {
  try {
    const objetos: Product[] = [];
    const objJSON = await getProductJSON();

    objJSON.forEach(element => {
      if (element[1] !== null) {
        const product: Product = JSON.parse(element[1]);
        objetos.push(product);
      }
    });

    return objetos;
  } catch (e) {
    console.error(e);
    return [];
  }
}

// Classe de gerenciamento do CRUD
class DataManager {
  public async remover(key: number): Promise<void> {
    await removeProduct(key.toString());
  }

  public async add(product: Product): Promise<void> {
    await saveProduct(product.code.toString(), product);
  }

  public async getAll(): Promise<Product[]> {
    return await getProduct();
  }
}

export default DataManager;

```
### Explicação

Após as importações necessárias, definimos várias funções assíncronas responsáveis por manipular dados armazenados localmente usando o AsyncStorage:

- **saveProduct**
    
    - Recebe uma **key** (string) e um objeto produto.
    - Converte o objeto em uma string JSON com `JSON.stringify`.
    - Usa `await AsyncStorage.setItem` para armazenar essa string.
    - O `await` garante que a operação termine antes de prosseguir.
    
- **removeProduct**
    
    - Recebe a key do item a ser removido.
    - Usa `await AsyncStorage.removeItem` para apagar o produto.
    
- **getProductsJSON**
    
    - Recupera todas as keys  armazenadas com `await AsyncStorage.getAllKeys`.
    - Obtém todos os valores correspondentes com `await AsyncStorage.multiGet`.
    - Retorna um array com pares `[key, valueJSON]` de todos os produtos.
    
- **getProducts**
    
    - Chama `getProductsJSON` para obter os dados JSON.
    - Itera sobre os pares `[key, valueJSON]` e desserializa cada valor com `JSON.parse`.
    - Monta um array com objetos do tipo `Product`.
    - Retorna essa lista com todos os produtos obtidos.


---

### Classe `DataManager`

A classe `DataManager` encapsula as operações principais para manipulação dos produtos:

- **Método `add(product: Product)`**: chama `saveProduct` para salvar um produto no AsyncStorage.
- **Método `remove(key: number)`**: remove o produto identificado pela chave (convertida para string).
- **Método `getAll()`**: obtém todos os produtos armazenados chamando `getProducts`.

Dessa forma, o `DataManager` funciona como um gerenciador centralizado para o armazenamento local dos produtos, facilitando a organização do código e abstraindo os detalhes do AsyncStorage.

