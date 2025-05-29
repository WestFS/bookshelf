# Modelo Relacional, SQL e SQLite no React Native

---

## 🧩 Modelo Relacional: o que é e como funciona

O **modelo relacional** é uma forma de organizar dados em **tabelas** (também chamadas de "relações"), onde cada tabela é formada por:

- **Linhas (tuplas)**: representam registros individuais.
- **Colunas (atributos)**: representam os campos ou características dos dados.

### 💡 Exemplo:

| id  | nome     | preco |
| --- | -------- | ----- |
| 1   | Camiseta | 29.90 |
| 2   | Boné     | 19.90 |
Esse modelo vem da **álgebra relacional** (com operações como **junção, projeção, seleção)** e do **cálculo relacional** (mais matemático, com lógica de predicados — "existe", "para todo").

É a base dos principais bancos de dados relacionais, como:
- MySQL
- PostgreSQL
- SQL Server
- **SQLite**

---

## 🧠 SQL – Linguagem de Manipulação de Dados Relacionais

SQL (**Structured Query Language**) é a linguagem usada para **criar, alterar e consultar** dados em bancos relacionais.

Ela se divide em:

### 🏗️ 1. DDL (Data Definition Language)  
Usada para definir a estrutura do banco:

- `CREATE TABLE`: cria uma nova tabela  
- `ALTER TABLE`: modifica uma tabela existente  
- `DROP TABLE`: remove uma tabela

```sql
CREATE TABLE produtos (
  id INTEGER PRIMARY KEY,
  nome TEXT,
  preco REAL
);
```

### 2. DML (Data Manipulation Language)

Usada para inserir, alterar ou excluir dados:
- `INSERT INTO`: adiciona dados
- `UPDATE`: altera dados existentes
- `DELETE FROM`: remove dados
  
```sql

INSERT INTO produtos (nome, preco) VALUES ('Camisa', 39.90);

UPDATE produtos SET preco = 29.90 WHERE id = 1;

DELETE FROM produtos WHERE id = 2;

```
---
### 3. SELECT – Consulta de dados
Permite buscar dados da tabela, com diversos filtros e opções:

```sql
SELECT nome, preco FROM produtos WHERE preco > 20 ORDER BY preco;
```

**Recursos usados no SELECT**:

- `WHERE`: filtra resultados
- `ORDER BY`: ordena resultados
- `GROUP BY`: agrupa por colunas
- `HAVING`: filtra os grupos
- Funções: `MAX()`, `MIN()`, `COUNT()`, `AVG()`, `SUM()`
- Operadores: `IN`, `LIKE`, `BETWEEN`, `EXISTS`

---
## SQLite no React Native – Banco local e leve

### O que é SQLite?

- Banco relacional **embutido**
- Usado para armazenar dados **localmente**
- Não requer servidor, ideal para apps mobile

### Características:

- Leve, rápido e confiável
- Suporta **transações ACID** (garantia de integridade)
- Armazena dados em **B-Trees**
- Tabelas especiais:
- `sqlite_master`: metadados das tabelas
- `sqlite_sequence`: controle de auto incremento


---
## Como usar SQLite no React Native
### 1. Instale o pacote

```bash
npm install react-native-sqlite-storage
```

### 2. Configure o banco
```js

import SQLite from 'react-native-sqlite-storage';

const db = SQLite.openDatabase({ name: 'meubanco.db', location: 'default' });

```

### 3. Crie um arquivo `DatabaseInstance.js`
```js

import SQLite from 'react-native-sqlite-storage';

const db = SQLite.openDatabase({ name: 'meubanco.db', location: 'default' });

export default db;

```

---

  

## Exemplo de uso com classe `GestorDados`

  

Você pode criar uma classe com os comandos básicos:

``` SQL
import db from "./DatabaseInstance";

class GestorDados {
  static criarTabela() {
    db.transaction((tx) => {
      tx.executeSql(`CREATE TABLE IF NOT EXISTS produtos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                nome TEXT,
                preco REAL
            );
        `);
    });
  }

  static inserirProduto(nome, preco) {
    db.transaction((tx) => {
      tx.executeSql("INSERT INTO produtos (nome, preco) VALUES (?, ?);", [
        nome,
        preco,
      ]);
    });
  }

  static listarProdutos(callback) {
    db.transaction((tx) => {
      tx.executeSql("SELECT * FROM produtos;", [], (_, { rows }) => {
        const resultados = [];
        for (let i = 0; i < rows.length; i++) {
          resultados.push(rows.item(i));
        }
        callback(resultados);
      });
    });
  }

  static removerProduto(id) {
    db.transaction((tx) => {
      tx.executeSql("DELETE FROM produtos WHERE id = ?;", [id]);
    });
  }
}

export default GestorDados;
```
