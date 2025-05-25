## ⚙️ Como o Lazydocker foi feito?

### 🧠 1. Linguagem principal: **Go (Golang)**

Lazydocker é todo escrito em **Go**, uma linguagem leve, rápida e muito usada para ferramentas de linha de comando. Go tem ótima performance e compila em binários pequenos, perfeitos para esse tipo de app.

---

### 🧰 2. Interface interativa (TUI)

A interface tipo "painel" do terminal foi feita com bibliotecas Go para TUI. As principais são:

#### 🔹 [`tcell`](https://github.com/gdamore/tcell)

- Biblioteca de baixo nível para manipular a tela no terminal (como uma engine gráfica pro terminal).
    
- Controla **cores, layout, entrada de teclado, redimensionamento**, etc.
    

#### 🔹 [`gocui`](https://github.com/jroimartin/gocui)

- Biblioteca minimalista para criar interfaces com **janelas móveis**, atalhos de teclado, áreas separadas.
    
- Usada para construir os **painéis visuais** (containers, logs, menus...).
    

Ou seja, com `tcell` ou `gocui`, eles criam essas "janelas" dentro do terminal que parecem uma UI gráfica.

---

### 🧩 3. Integração com Docker

O Lazydocker se comunica com o Docker da mesma forma que você usaria a CLI (`docker ps`, `docker logs`, etc.), mas via **Docker API**:

#### 🔸 Docker SDK for Go:

- Eles usam a biblioteca oficial do Docker para Go (`github.com/docker/docker/client`) para:
    
    - Listar containers, imagens, volumes.
        
    - Ver e seguir logs (`docker logs -f`).
        
    - Controlar os serviços (start, stop, restart).
        
    - Ler informações de `docker-compose`.
        

---

### 📁 4. Organização em arquivos Go

O código é modular:

- Cada painel (containers, imagens, logs...) é uma “view”.
    
- Cada ação (parar container, ver log...) é uma função separada.
    
- Eles usam **goroutines** (threads leves do Go) para manter tudo rápido e não travar a interface.
    

---

### 🎯 Por que isso é impressionante?

- Tudo roda **em tempo real**, no terminal.
    
- A navegação é rápida e intuitiva.
    
- Eles usam **apenas o terminal**, sem depender de GUI (como Electron, por exemplo).
    
- O projeto é **open source** e pode ser lido no GitHub:  
    👉 [https://github.com/jesseduffield/lazydocker](https://github.com/jesseduffield/lazydocker)
    

---

### 🧑‍💻 Curioso pra ver por dentro?

Se você quiser, posso te mostrar um exemplo simples de como criar **uma mini interface interativa em Go**, estilo Lazydocker. Assim você vê como funciona na prática. Quer?