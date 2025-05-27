## AsyncStorage
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

## Leitura e Gravação de Arquivos em Node.js
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
