#tag: PT/React Native
## 🧩 Realm Database – Conceito e Estrutura
### Conceito

**Realm** é um **DBMS orientado a objetos** de código aberto, projetado principalmente para aplicações mobile. Foi posteriormente adquirido pela **MongoDB**. É conhecido por sua **performance, modelo reativo** e facilidade de uso com linguagens modernas como TypeScript.

### 🔍 Principais Vantagens e Características

#### ✅ **Compression**

Realm otimiza o uso de memória convertendo listas de strings repetidas em enums, reduzindo redundância de dados.

#### ✅ **Controle de Concorrência (MVCC)**

Realm utiliza **Multi-Version Concurrency Control (MVCC)** com **Copy-On-Write**, permitindo múltiplas leituras e escritas concorrentes. Cada nova transação cria um **snapshot** do banco, garantindo **atomicidade** e isolamento durante a execução.

#### ✅ **Modelo de Dados**

Baseado em **classes orientadas a objetos**, o Realm permite que desenvolvedores definam o esquema do banco diretamente via código, semelhante a ORMs modernos.

#### ✅ **Índices**

Realm usa uma estrutura interna baseada em **B+ Trees**, otimizando buscas e leituras sequenciais.

#### ✅ **Execução de Consultas**

Usa o modelo **tuple-at-a-time** com **lazy-loading**: apenas as propriedades acessadas são carregadas da memória/disco, reduzindo uso de I/O.

#### ✅ **Interface de Consulta**

Possui uma **API personalizada** que permite buscar objetos por propriedades, com suporte a **filtros (`filter`)** e **ordenação (`sort`)**.

#### ✅ **Arquitetura de Armazenamento**

Realm funciona tanto em **modo disco** quanto **em memória**, sem a necessidade de serialização/desserialização: o acesso é direto ao mapeamento da memória.

#### ✅ **Modelo de Armazenamento**

Usa o modelo **Decomposition Storage (colunar)**: cada propriedade é armazenada em blocos contínuos. Isso permite acesso direto a uma propriedade sem carregar a "linha inteira" do objeto.

#### ✅ **Organização de Armazenamento**

Implementa **copy-on-write** com **shadow paging**: uma nova transação opera em uma cópia do banco e, após verificação (two-phase commit), os dados são gravados no disco de forma atômica.

#### ✅ **Views (Visões)**

Realm oferece suporte a:

- **Virtual Views (imperativas)** – resultados são fixos no início da transação.
    
- **Materialized Views (reflexivas)** – os dados mudam automaticamente conforme o banco muda.
    

---

### ⚠️ Desvantagens

- ❌ **Logging**: Não possui suporte a logs detalhados de transações.
    
- ❌ **Joins**: Não há suporte a operações de `JOIN` como em bancos relacionais.
    
- ❌ **Chaves estrangeiras**: Não há suporte a `foreign keys`.
    

---

## 🛠️ Exemplo de Implementação com React Native + TypeScript

### 📦 Instalação
```bash
npm install realm @realm/react
```
ou, com Expo:
```bash
npx expo-cli init ReactRealmTSTemplateApp -t @realm/expo-template-js
```

👤 Modelo `Person`
```tsx
import { Realm } from 'realm';

export class Person extends Realm.Object {
  static schema = {
    name: 'Person',
    primaryKey: '_id',
    properties: {
      _id: 'objectId',
      name: 'string',
      age: 'int?',
      date: {
        type: 'date',
        default: () => new Date(),
      },
      cars: {
        type: 'list',
        objectType: 'Car',
      },
      address: 'Address',
    },
  };
}

```

🚗 Modelo `Car`
```tsx
import { Realm } from 'realm';

export class Car extends Realm.Object {
  static schema = {
    name: 'Car',
    primaryKey: '_id',
    properties: {
      _id: 'objectId',
      c_name: 'string',
      c_color: 'string',
      date: {
        type: 'date',
        default: () => new Date(),
      },
    },
  };
}
```

🏠 Modelo `Address` (Embedded)
```tsx
import { Realm } from 'realm';

export class Address extends Realm.Object {
  static schema = {
    name: 'Address',
    embedded: true,
    properties: {
      country: 'string?',
    },
  };
}
```

### 🔗 Relacionamentos no Realm

- **`Person` → `Car`**: relação **one-to-many** (lista de carros).
- **`Person` → `Address`**: relação **one-to-one** com objeto embutido (embedded).
- Objetos `embedded` (como `Address`) são **armazenados dentro do objeto pai**, sem ocupar uma linha separada no banco.


### 🧪 Criando Objetos Relacionados
```ts
realm.write(() => {
  const car1 = realm.create('Car', {
    _id: new Realm.BSON.ObjectID(),
    c_name: 'Toyota Camry',
    c_color: 'Red',
  });

  const car2 = realm.create('Car', {
    _id: new Realm.BSON.ObjectID(),
    c_name: 'Honda Accord',
    c_color: 'Blue',
  });

  realm.create('Person', {
    _id: new Realm.BSON.ObjectID(),
    name: 'John Doe',
    age: 30,
    cars: [car1, car2],
    address: { country: 'USA' },
  });
});
```