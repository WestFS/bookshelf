#tag: PT/React Native
# Persistência Relacional em React Native

## Sumário
1. [Introdução ao Modelo Relacional](#introducao-ao-modelo-relacional)
2. [SQL: Linguagem de Consulta Estruturada](#sql-linguagem-de-consulta-estruturada)
    - [DDL: Linguagem de Definição de Dados](#ddl-linguagem-de-definicao-de-dados)
    - [DML: Linguagem de Manipulação de Dados](#dml-linguagem-de-manipulacao-de-dados)
    - [SELECT: Consulta de Dados](#select-consulta-de-dados)
3. [SQLite no React Native](#sqlite-no-react-native)
    - [O que é SQLite?](#o-que-e-sqlite)
    - [Principais Características](#principais-caracteristicas)
    - [Como Usar SQLite no React Native](#como-usar-sqlite-no-react-native)
4. [Exemplo: Classe DataManager](#exemplo-classe-datamanager)
5. [Integração com TanStack Query](#integracao-com-tanstack-query)
6. [Padronização, RFCs e Boas Práticas](#padronizacao-rfcs-e-boas-praticas)
7. [Dicas de Otimização](#dicas-de-otimizacao)
8. [Referências e Leituras Sugeridas](#referencias-e-leituras-sugeridas)

---

## Introdução ao Modelo Relacional

O **modelo relacional** organiza dados em **tabelas** (relações), onde:
- **Linhas (tuplas):** representam registros individuais
- **Colunas (atributos):** representam campos ou propriedades

Esse modelo é baseado em **álgebra relacional** (operações como junção, projeção, seleção) e **cálculo relacional** (lógica de predicados: "existe", "para todo").

**Principais bancos relacionais:**
- MySQL
- PostgreSQL
- SQL Server
- **SQLite** (embutido, ideal para mobile)

---

## SQL: Linguagem de Consulta Estruturada

SQL é o padrão para criar, modificar e consultar bancos relacionais. É regida pelo padrão ISO/IEC 9075 e influenciada por RFCs e normas ANSI/ISO.

### DDL: Linguagem de Definição de Dados
Define a estrutura do banco de dados.

```sql
CREATE TABLE produtos (
  id INTEGER PRIMARY KEY,
  nome TEXT,
  preco REAL
);
```
- `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`

### DML: Linguagem de Manipulação de Dados
Para inserir, atualizar e deletar dados.

```sql
INSERT INTO produtos (nome, preco) VALUES ('Camisa', 39.90);
UPDATE produtos SET preco = 29.90 WHERE id = 1;
DELETE FROM produtos WHERE id = 2;
```
- `INSERT INTO`, `UPDATE`, `DELETE FROM`

### SELECT: Consulta de Dados
Recupera dados com filtros, ordenação, agrupamento e agregação.

```sql
SELECT nome, preco FROM produtos WHERE preco > 20 ORDER BY preco;
```
- `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, `IN`, `LIKE`, `BETWEEN`, `EXISTS`
- Funções: `MAX()`, `MIN()`, `COUNT()`, `AVG()`, `SUM()`

---

## SQLite no React Native

### O que é SQLite?
- Banco relacional embutido
- Armazena dados **localmente** (sem servidor)
- Leve, rápido e confiável
- Suporta transações **ACID** (Atomicidade, Consistência, Isolamento, Durabilidade)
- Dados armazenados em **B-Trees**
- Tabelas especiais: `sqlite_master` (metadados), `sqlite_sequence` (controle de autoincremento)

### Principais Características
- Zero-configuração, multiplataforma
- Usado por grandes apps (WhatsApp, Firefox, Skype)
- Domínio público, amplamente adotado em mobile e IoT

### Como Usar SQLite no React Native

1. **Instale o pacote:**
```bash
npm install react-native-sqlite-storage
```

2. **Configure o banco:**
```js
import SQLite from 'react-native-sqlite-storage';
const db = SQLite.openDatabase({ name: 'meubanco.db', location: 'default' });
```

3. **Crie uma instância do banco:**
```js
// src/services/DatabaseInstance.js
import SQLite from 'react-native-sqlite-storage';
const db = SQLite.openDatabase({ name: 'meubanco.db', location: 'default' });
export default db;
```

---

## Exemplo: Classe DataManager

Classe para encapsular operações CRUD:

```js
import db from './DatabaseInstance';

class DataManager {
  static criarTabela() {
    db.transaction((tx) => {
      tx.executeSql(`CREATE TABLE IF NOT EXISTS produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        preco REAL
      );`);
    });
  }

  static inserirProduto(nome, preco) {
    db.transaction((tx) => {
      tx.executeSql('INSERT INTO produtos (nome, preco) VALUES (?, ?);', [nome, preco]);
    });
  }

  static listarProdutos(callback) {
    db.transaction((tx) => {
      tx.executeSql('SELECT * FROM produtos;', [], (_, { rows }) => {
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
      tx.executeSql('DELETE FROM produtos WHERE id = ?;', [id]);
    });
  }
}

export default DataManager;
```

---

## Integração com TanStack Query

**TanStack Query** (React Query) é uma biblioteca poderosa para busca, cache e sincronização de dados em React e React Native. Embora seja mais usada com APIs remotas, pode ser usada para gerenciar dados locais (ex: SQLite) e sincronizar com backend.

### Exemplo: Usando TanStack Query com SQLite

```tsx
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import DataManager from './DataManager';

export function useProdutos() {
  return useQuery(['produtos'], () =>
    new Promise((resolve) => DataManager.listarProdutos(resolve))
  );
}

export function useAdicionarProduto() {
  const queryClient = useQueryClient();
  return useMutation(
    ({ nome, preco }) => DataManager.inserirProduto(nome, preco),
    {
      onSuccess: () => queryClient.invalidateQueries(['produtos']),
    }
  );
}
```

- **Boas práticas:** Use TanStack Query para manter a UI sincronizada com dados locais e remotos, além de lidar com refetch em background, cache e updates otimistas.
- **Dica:** Para sincronização remota, combine SQLite para armazenamento offline/local e TanStack Query para sync em background com sua API.

---

## Padronização, RFCs e Boas Práticas

- **Padrão SQL:** ISO/IEC 9075 (SQL:2016 e posteriores)
- **SQLite:** Segue grande parte do padrão SQL, com algumas extensões e limitações ([veja docs](https://sqlite.org/lang.html))
- **Boas práticas web:**
    - Use queries parametrizadas para evitar SQL injection
    - Normalize dados quando apropriado, mas desnormalize para performance se necessário
    - Use transações para operações em lote
    - Siga [RFC 8259](https://tools.ietf.org/html/rfc8259) para troca de dados JSON
    - Use [RFC 3339](https://tools.ietf.org/html/rfc3339) para formatos de data/hora
- **React Native:**
    - Use hooks e context para gerenciamento de estado
    - Mantenha lógica de negócio fora dos componentes de UI
    - Use TypeScript para segurança de tipos

---

## Dicas de Otimização
- **Indexe colunas** frequentemente consultadas
- **Agrupe escritas** em transações para performance
- **Limite resultados** com `LIMIT` e paginação
- **Profile queries** usando `EXPLAIN` do SQLite
- **Proteja seus dados:** criptografe o banco se armazenar informações sensíveis
- **Estratégias de sync:** Use sync em background e resolução de conflitos para apps offline-first

---

## Referências e Leituras Sugeridas
- [Documentação Oficial do SQLite](https://sqlite.org/docs.html)
- [ISO/IEC 9075: SQL Standard](https://en.wikipedia.org/wiki/SQL:2016)
- [TanStack Query Documentation](https://tanstack.com/query/latest)
- [RFC 8259: JSON](https://tools.ietf.org/html/rfc8259)
- [RFC 3339: Data e Hora na Internet](https://tools.ietf.org/html/rfc3339)
