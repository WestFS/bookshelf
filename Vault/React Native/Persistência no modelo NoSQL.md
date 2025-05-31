## Not Only SQL (NoSQL)
Bancos de dados NoSQL (Not Only SQL) representam uma alternativa flexível aos bancos de dados relacionais tradicionais, projetados para lidar com grandes volumes de dados e alta escalabilidade.
#### ⚙️ **Características principais**

- **Desempenho priorizado** em vez de consistência forte.
- **Alta disponibilidade** e **escalabilidade horizontal**.
- Dados distribuídos e replicados entre nós (com pequena latência).
- Pouco ou nenhum suporte a **transações ACID**.
- Estrutura de dados **flexível e dinâmica** (sem esquemas fixos).


---

### 🧩 **Principais Tipos de Bancos NoSQL**

#### 🔑 1. **Chave-Valor**
- Armazenamento simples: `chave → valor`.
- Aplicações fazem a interpretação do valor.
- **Exemplo Conceitual:** `produto_id:12345` → `{ "nome": "Camiseta", "preco": 29.90 }`
- Ex: Oracle Berkeley DB.
#### 🧱 2. **Colunar**
- Valores divididos em **colunas agrupadas por famílias**.
- Alta flexibilidade e excelente desempenho em **consultas analíticas**.
- **Exemplo Conceitual:** Veja o exemplo detalhado de HBase abaixo.
- Ex: **HBase**, baseado no Google BigTable, com suporte a Hadoop e MapReduce.

#### 📄 3. **Documental**
- Cada chave aponta para um **documento estruturado** (JSON, XML, YAML, etc).
- Armazena dados **semiestruturados** com metadados.
- **Exemplo Conceitual:**
```json
{
  "_id": "65b4e7b8f9e6d4c1a2b3c0e1",
  "nome": "João Silva",
  "email": "joao.silva@exemplo.com",
  "enderecos": [
    { "rua": "Rua das Flores, 123", "cidade": "São Paulo" },
    { "rua": "Av. Principal, 45", "cidade": "Rio de Janeiro" }
  ],
  "interesses": ["tecnologia", "viagens"]
}
```
- Ex: **MongoDB** (usa JSON e tem geração automática de IDs).


#### 🔗 4. **Grafos**
- Dados como **vértices (nós)** conectados por **arestas (relacionamentos)**.
- Ideal para modelar **redes complexas** (ex: redes sociais, sistemas de recomendação).
- **Exemplo Conceitual:**
    - **Nós:** `(:Pessoa {nome: 'Alice'})`, `(:Pessoa {nome: 'Bob'})`, `(:Filme {titulo: 'Matrix'})`
    - **Arestas:** `(Alice)-[:CONHECE]->(Bob)`, `(Bob)-[:ASSISTIU]->(Matrix)`
- Ex: **Neo4j**, com suporte a transações e consultas complexas.

---

### 🚀 **Vantagens do NoSQL**

- Alta performance em leitura e escrita.
- Escalabilidade e tolerância a falhas.
- Estrutura de dados flexível.    
- Suporte a grandes volumes de dados (Big Data).


### ⚠️ **Pontos de Atenção**

- Menor consistência imediata (eventual consistency).
- Dados duplicados são comuns.
- Alterações e exclusões podem ser limitadas (inclusão massiva é priorizada).
- Necessidade de **versionamento** para rastrear mudanças.

---
### 📊 **Exemplo de Estrutura de Dados no HBase**

No HBase, os dados são armazenados em **tabelas**, mas com um formato **colunar**, dividido em **famílias de colunas**. Cada linha é identificada por uma **chave única (row key)**, e cada célula possui um **timestamp** (oculto) para versionamento.

#### 🧱 **Exemplo: Tabela de Alunos**

|Row Key|aluno:nome|aluno:matricula|turma:codigo|turma:professor|imagens:foto|
|---|---|---|---|---|---|
|20181.1873223|Luiz Carlos|20181.1873223|ENG2010001|José Oliveira|HzvMg4da12...|
|20181.2341581|Ana Lima|20181.2341581|ECO2010012|Thiago Abreu|HzfxHb5kPr...|
|20192.0923127|Paulo Silva|20192.0923127|ENG2010001|José Oliveira|HzAtyKmcv5...|
#### 🔍 **Explicação**

- **Row Key**: Identificador único da linha (ex: matrícula do aluno).
- **Famílias de colunas**:
    
    - `aluno`: contém `nome`, `matricula`.
    - `turma`: contém `codigo`, `professor`.
    - `imagens`: contém `foto` (geralmente em base64 ou binário).
    
- **Células**: Cada valor pode ter várias versões, controladas automaticamente por timestamp.
    

#### 📌 Observações

- É possível adicionar **mais colunas** ou **famílias de colunas** sem alterar um esquema fixo.
- O campo `imagens:foto` está separado em uma família para **otimizar performance**, já que dados binários ocupam mais espaço.

---

## Banco de dados MongoDB

Trabalhando com um modelo orientado a documentos, o **MongoDB** é baseado no formato **JSON**, permitindo a modelagem de dados complexos, com hierarquias expressas por meio de campos aninhados. O uso de uma notação natural do JavaScript facilita a **indexação** e a **busca**, sendo possível utilizar consultas por campo, faixa de valores ou até mesmo **expressões regulares**, além de oferecer recursos para **amostragem** aleatória.

Link para download: [https://www.mongodb.com/try/download/community](https://www.mongodb.com/try/download/community).

### BSON: O Formato de Dados do MongoDB

Embora o MongoDB utilize a notação JSON para seus documentos, internamente ele armazena os dados em um formato binário chamado **BSON** (Binary JSON). O BSON é uma extensão binária do JSON que oferece algumas vantagens importantes:

- **Eficiência:** O BSON é mais compacto e rápido para analisar (parsear) do que o JSON puro, o que melhora o desempenho das operações de leitura e escrita.
- **Tipos de Dados Ricos:** O BSON expande os tipos de dados do JSON, permitindo o armazenamento de informações mais complexas e específicas, como dados binários, datas e ObjectIds. Isso garante que os dados sejam armazenados de forma mais precisa e eficiente.
- **Capacidade de Travessia:** O BSON inclui prefixos de comprimento para cada elemento, o que otimiza a navegação pelos campos do documento durante as consultas.

**Principais Tipos de Dados BSON:**

O BSON suporta uma variedade de tipos de dados, alguns dos quais são exclusivos ou têm uma representação mais rica que seus equivalentes JSON:

- **Double:** Números de ponto flutuante de 64 bits.
- **String:** Texto codificado em UTF-8.
- **Object:** Documentos aninhados, permitindo estruturas hierárquicas.
- **Array:** Listas de valores, que podem conter outros tipos BSON.
- **Binary Data (BinData):** Dados binários genéricos, ideais para armazenar imagens, vídeos ou outros arquivos.
- **ObjectId:** Um identificador exclusivo de 12 bytes, frequentemente usado como a chave primária `_id` dos documentos.
- **Boolean:** Valores `true` ou `false`.
- **Date:** Um inteiro de 64 bits que representa milissegundos desde a Época Unix.
- **Null:** Indica a ausência de um valor.
- **Regular Expression (Regex):** Expressões regulares para consultas de padrão.
- **Integer (32 e 64 bits):** Números inteiros.
- **Timestamp:** Um tipo interno usado para operações de replicação.
- **Decimal128:** Um tipo decimal de 128 bits para alta precisão em aplicações financeiras.
- **MinKey / MaxKey:** Tipos especiais para ordenação, representando os valores mínimo e máximo possíveis.

### Collections

O MongoDB armazena os dados em **collections**, que são o equivalente às tabelas em bancos de dados relacionais. No entanto, uma collection no MongoDB é uma "tabela de documentos" que não exige um esquema fixo, oferecendo grande flexibilidade. As collections podem ter regras de validação utilizando `validationLevel`:

- `strict`: Restringe as inserções para garantir a conformidade dos dados com as regras.
- `moderate`: Não exige validação estrita, permitindo mais flexibilidade nas inserções.

```node.js
db.runCommand( {
   collMod: "contacts",
   validator: { $jsonSchema: {
      bsonType: "object",
      required: [ "phone", "name" ],
      properties: {
         phone: {
            bsonType: "string",
            description: "phone must be a string and is required"
         },
         name: {
            bsonType: "string",
            description: "name must be a string and is required"
         }
      }
   } },
   validationLevel: "strict"
} )
```

``` node.js
db.runCommand( {
   collMod: "contacts",
   validator: { $jsonSchema: {
      bsonType: "object",
      required: [ "phone", "name" ],
      properties: {
         phone: {
            bsonType: "string",
            description: "phone must be a string and is required"
         },
         name: {
            bsonType: "string",
            description: "name must be a string and is required"
         }
      }
   } },
   validationLevel: "moderate"
} )
```

---

### Operações CRUD do MongoDB

#### Comandos de Insert:

- `db.collection.insertOne()`: Insere um único documento.
- `db.collection.insertMany()`: Insere múltiplos documentos.

**Exemplo: Inserir um único documento**
```node.js
await db.collection('inventory').insertOne({
  item: 'canvas',
  qty: 100,
  tags: ['cotton'],
  size: { h: 28, w: 35.5, uom: 'cm' }
});
``````
**insertOne()** retorna uma promessa que fornece um `result`. A promessa `result.insertedId` contém o `_id` do documento recém-inserido.

**Exemplo: Inserir vários documentos**
```node.js
await db.collection('inventory').insertMany([
  {
    item: 'journal',
    qty: 25,
    tags: ['blank', 'red'],
    size: { h: 14, w: 21, uom: 'cm' }
  },
  {
    item: 'mat',
    qty: 85,
    tags: ['gray'],
    size: { h: 27.9, w: 35.5, uom: 'cm' }
  },
  {
    item: 'mousepad',
    qty: 25,
    tags: ['gel', 'blue'],
    size: { h: 19, w: 22.85, uom: 'cm' }
  }
]);
```
**insertMany()** retorna uma promessa que fornece um `result`. O campo `result.insertedIds` contém uma array com `_id` de cada documento recém-inserido.

#### Comandos de Find:

- `db.collection.find()`: Consulta documentos.

**Exemplos de Consultas:**
```node.js
const cursor = db.collection('inventory').find({});
// SELECT * FROM inventory

const cursor = db.collection('inventory').find({ status: 'D' });
// SELECT * FROM inventory WHERE status = "D"

const cursor = db.collection('inventory').find({
  status: { $in: ['A', 'D'] }
});
// SELECT * FROM inventory WHERE status in ("A", "D")

const cursor = db.collection('inventory').find({
  status: 'A',
  qty: { $lt: 30 }
});
// SELECT * FROM inventory WHERE status = "A" AND qty < 30


const cursor = db.collection('inventory').find({
  $or: [{ status: 'A' }, { qty: { $lt: 30 } }]
});
// SELECT * FROM inventory WHERE status = "A" OR qty < 30


const cursor = db.collection('inventory').find({
  status: 'A',
  $or: [{ qty: { $lt: 30 } }, { item: { $regex: '^p' } }]
}); 
// SELECT * FROM inventory WHERE status = "A" AND ( qty < 30 OR item LIKE "p%")


```

#### Comandos de Update:

- `db.collection.updateOne()`
- `db.collection.updateMany()`
- `db.collection.replaceOne()`

#### Comandos de Delete:

- `db.collection.deleteOne()`
- `db.collection.deleteMany()`


---
## Operadores Mais Utilizados do MongoDB

O MongoDB oferece uma rica variedade de operadores para manipular e consultar dados. Abaixo, você encontrará os mais frequentemente usados, divididos por categoria para facilitar a referência.

---

### **1. Operadores de Query (Consulta)**

Utilizados principalmente no método `db.collection.find()` para filtrar documentos.

|Categoria|Operador|Descrição|Exemplo de Uso|
|:--|:--|:--|:--|
|**Comparação**|`$eq`|Corresponde a valores que são **iguais** a um valor especificado.|`db.produtos.find({ preco: { $eq: 10 } })`|
||`$ne`|Corresponde a valores que **não são iguais** a um valor especificado.|`db.usuarios.find({ status: { $ne: "inativo" } })`|
||`$gt`|Corresponde a valores **maiores que** o valor especificado.|`db.pedidos.find({ total: { $gt: 100 } })`|
||`$gte`|Corresponde a valores **maiores ou iguais a** o valor especificado.|`db.vendas.find({ quantidade: { $gte: 50 } })`|
||`$lt`|Corresponde a valores **menores que** o valor especificado.|`db.alunos.find({ idade: { $lt: 18 } })`|
||`$lte`|Corresponde a valores **menores ou iguais a** o valor especificado.|`db.estoque.find({ disponivel: { $lte: 10 } })`|
||`$in`|Corresponde a qualquer um dos valores em um **array** especificado.|`db.clientes.find({ cidade: { $in: ["SP", "RJ"] } })`|
||`$nin`|Corresponde a nenhum dos valores em um **array** especificado.|`db.estados.find({ uf: { $nin: ["SP", "RJ"] } })`|
|**Lógicos**|`$and`|Une cláusulas de consulta com um `AND` lógico; retorna documentos onde **todas** as condições são verdadeiras.|`db.usuarios.find({ $and: [{ idade: { $gte: 18 } }, { status: "ativo" }] })`|
||`$or`|Une cláusulas de consulta com um `OR` lógico; retorna documentos onde **pelo menos uma** das condições é verdadeira.|`db.pedidos.find({ $or: [{ status: "pendente" }, { total: { $lt: 50 } }] })`|
||`$not`|Inverte o efeito de uma expressão de query.|`db.produtos.find({ preco: { $not: { $gt: 100 } } })`|
|**Elemento**|`$exists`|Corresponde a documentos que possuem (ou não) um campo específico.|`db.usuarios.find({ email: { $exists: true } })`|
||`$type`|Seleciona documentos baseados no tipo BSON de um campo.|`db.itens.find({ valor: { $type: "string" } })`|
|**Avaliação**|`$regex`|Seleciona documentos onde os valores de um campo correspondem a uma **expressão regular**.|`db.produtos.find({ nome: { $regex: /^camiseta/i } })`|

---

### **2. Operadores de Update (Atualização)**

Utilizados nos métodos `db.collection.updateOne()`, `updateMany()` e `replaceOne()` para modificar documentos.

|Categoria|Operador|Descrição|Exemplo de Uso|
|:--|:--|:--|:--|
|**Campo**|`$set`|Define o valor de um campo. Se o campo não existir, ele é criado.|`db.usuarios.updateOne({ _id: 1 }, { $set: { email: "novo@exemplo.com" } })`|
||`$unset`|Remove um campo específico do documento.|`db.usuarios.updateOne({ _id: 1 }, { $unset: { telefone: "" } })`|
||`$inc`|Incrementa (ou decrementa) o valor de um campo numérico.|`db.estoque.updateOne({ item: "caneta" }, { $inc: { quantidade: -5 } })`|
||`$rename`|Renomeia um campo.|`db.clientes.updateMany({}, { $rename: { "end.rua": "end.logradouro" } })`|
|**Array**|`$push`|Adiciona um elemento a um array.|`db.tarefas.updateOne({ _id: 1 }, { $push: { comentarios: "ótimo!" } })`|
||`$addToSet`|Adiciona um elemento a um array apenas se ele ainda não estiver presente (garante unicidade).|`db.usuarios.updateOne({ _id: 1 }, { $addToSet: { tags: "premium" } })`|
||`$pull`|Remove todos os elementos de um array que correspondem a uma condição.|`db.tarefas.updateOne({ _id: 1 }, { $pull: { comentarios: "ótimo!" } })`|
||`$pop`|Remove o primeiro (`-1`) ou o último (`1`) elemento de um array.|`db.fila.updateOne({ nome: "impressao" }, { $pop: { itens: 1 } })`|

---

### **3. Operadores de Agregação (Aggregation Pipeline)**

Utilizados dentro dos estágios do pipeline de agregação para transformar e processar dados.

| Estágio/Operador | Descrição                                                                        | Exemplo de Uso                                                                         |
| :--------------- | :------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- |
| `$match`         | Filtra documentos para passar para o próximo estágio (funciona como o `find()`). | `db.vendas.aggregate([{ $match: { data: { $gte: ISODate("2023-01-01") } } }])`         |
| `$group`         | Agrupa documentos por uma chave especificada e realiza operações de agregação.   | `db.vendas.aggregate([{ $group: { _id: "$produto", total: { $sum: "$quant" } } }])`    |
| `$project`       | Remodela cada documento no fluxo (inclui, exclui ou renomeia campos).            | `db.usuarios.aggregate([{ $project: { _id: 0, nome: 1, email: 1 } }])`                 |
| `$sort`          | Reordena os documentos do fluxo.                                                 | `db.produtos.aggregate([{ $sort: { preco: 1 } }])`                                     |
| `$limit`         | Passa o número especificado de documentos para o próximo estágio.                | `db.usuarios.aggregate([{ $limit: 10 }])`                                              |
| `$skip`          | Pula um número especificado de documentos.                                       | `db.usuarios.aggregate([{ $skip: 10 }])`                                               |
| `$unwind`        | Desconstrói um campo de array, criando um documento de saída para cada elemento. | `db.pedidos.aggregate([{ $unwind: "$itens" }])`                                        |
| `$addFields`     | Adiciona novos campos a documentos (disponível a partir do MongoDB 3.4).         | `db.produtos.aggregate([{ $addFields: { imposto: { $multiply: ["$preco", 0.1] } } }])` |

---

> [!NOTE]
> ### Campo `_id`
> 
> No MongoDB, cada documento armazenado em uma **collection** padrão requer um campo `_id` exclusivo que atua como uma chave primária. Se um documento inserido omitir o campo `_id`, o driver MongoDB gerará automaticamente um **ObjectId** para o campo `_id`.
>
> Isso também se aplica a documentos inseridos por meio de operações de atualização com `upsert: true`.

---
