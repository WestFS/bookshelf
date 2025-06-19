## Diferença entre **Promise** e **Thread**

| Conceito                 | Promise (JavaScript)                       | Thread (Java, C#, etc.)                       |
| ------------------------ | ------------------------------------------ | --------------------------------------------- |
| **Tipo de execução**     | **Assíncrona**, mas **monothread**         | **Paralela**, com **múltiplas threads reais** |
| **Criação**              | Usa `Promise`, `async/await`, `setTimeout` | Usa `Thread`, `Runnable`, `Task`, etc.        |
| **Custo**                | **Leve**, usa o loop de eventos            | **Mais pesado**, usa mais memória/processador |
| **Concorrência real**    | Não (simula com o Event Loop)              | Sim (executa código **ao mesmo tempo**)       |
| **Bloqueia a execução?** | Não bloqueia (usa callbacks/eventos)       | Pode bloquear se não for bem gerenciado       |
| **Gerenciado por**       | **Event Loop**                             | **Sistema operacional (kernel)**              |
### **Diferença entre callback e async/await**

| Característica     | Callback                             | async/await              |
| ------------------ | ------------------------------------ | ------------------------ |
| Estilo de escrita  | Usa funções dentro de funções        | Parece código sequencial |
| Leitura            | Pode ficar confuso com muitos níveis | Muito mais claro         |
| Tratamento de erro | Feito dentro do callback             | Feito com `try...catch`  |
| Complexidade       | Maior quando tem várias operações    | Menor e mais elegante    |
