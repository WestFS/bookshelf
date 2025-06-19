#tag: PT/React Native

### �� **1. Armazenamento Local (no próprio dispositivo)**

#### 📦 **AsyncStorage / MMKV (React Native)**

- Ideal para: **dados simples e chave-valor** (ex: token de login, preferências).
- Simples de usar, mas **não criptografado por padrão**.
- **MMKV** é mais rápido, mais eficiente e uma alternativa moderna ao AsyncStorage.

#### 🗃️ **SQLite / Room / WatermelonDB**

- Ideal para: **dados estruturados e relacionais** (ex: lista de produtos, usuários, tarefas).
- Armazena dados em **formato de banco de dados local**.
- Mais robusto e persistente que armazenamento chave-valor.

#### 📁 **Arquivos locais (FileSystem)**

- Ideal para: **armazenamento de arquivos** (ex: imagens, documentos).
- Usado com bibliotecas como `expo-file-system` ou `react-native-fs`.
---

### 🔸 **2. Armazenamento em Nuvem (remoto)**

#### ☁️ **APIs + Backend (Firebase, Node.js, etc.)**
- Dados enviados e buscados de um servidor (REST APIs ou GraphQL).
- Ideal para **sincronização entre dispositivos** e **persistência confiável**.
- Usado para listas, usuários, carrinhos, etc.

#### 🔐 **Firebase Realtime Database / Firestore**
- Soluções backend completas do Google.
- Ideal para apps com **autenticação**, **notificações** e **dados em tempo real**.
- Pode ser usado sem backend próprio.

#### 🛡️ **Auth + Armazenamento Seguro**
- Dados sensíveis (tokens, senhas, etc.) devem ser armazenados em **Secure Storage**:
  - `expo-secure-store`
  - `Keychain` (iOS)
  - `EncryptedSharedPreferences` (Android)

---

### 🔸 **3. Boas Práticas Gerais**

- 🔒 **Dados sensíveis → Secure Storage**
- 📶 **Dados sincronizáveis → API/Backend**
- 📴 **Funciona offline? → Use SQLite ou local storage**
---

## 📁 **Estrutura para projetos em React Native + TypeScript**
```
my-react-native-app/
├── android/
├── ios/
├── node_modules/
├── src/
│   │
│   ├── assets/
│   │   ├── fonts/
│   │   ├── icons/
│   │   ├── images/
│   │   └── lottie/
│   │
│   ├── components/             # Componentes globais reutilizáveis
│   │   ├── common/             # Ex: Button, Input
│   │   │   ├── Button.tsx
│   │   │   ├── Input.tsx
│   │   │   └── index.ts
│   │   ├── specific/           # Ex: ProductCard, UserAvatar
│   │   │   ├── ProductCard.tsx
│   │   │   └── UserAvatar.tsx
│   │   └── index.ts
│   │
│   ├── features/               # Organização por funcionalidade
│   │   ├── Auth/
│   │   │   ├── components/
│   │   │   │   └── LoginForm.tsx
│   │   │   ├── screens/
│   │   │   │   ├── LoginScreen.tsx
│   │   │   │   └── RegisterScreen.tsx
│   │   │   ├── services/
│   │   │   │   └── authService.ts
│   │   │   ├── hooks/
│   │   │   │   └── useAuth.ts
│   │   │   └── navigation/
│   │   │       └── AuthStack.tsx
│   │   ├── Products/
│   │   │   ├── components/
│   │   │   ├── screens/
│   │   │   │   ├── ProductListScreen.tsx
│   │   │   │   └── ProductDetailScreen.tsx
│   │   │   ├── services/
│   │   │   └── hooks/
│   │   └── Settings/
│   │       ├── screens/
│   │       └── components/
│   │
│   ├── navigation/
│   │   ├── AppNavigator.tsx
│   │   ├── TabNavigator.tsx
│   │   ├── AuthNavigator.tsx
│   │   └── index.ts
│   │
│   ├── services/               # APIs e integrações externas reutilizáveis
│   │   ├── api.ts              # Axios ou fetch config
│   │   ├── userService.ts
│   │   ├── productService.ts
│   │   └── ...
│   │
│   ├── contexts/               # Context API
│   │   ├── AuthContext.tsx
│   │   └── ThemeContext.tsx
│   │
│   ├── hooks/                  # Hooks reutilizáveis globais
│   │   ├── useDebounce.ts
│   │   └── useInternetConnection.ts
│   │
│   ├── utils/                  # Funções auxiliares genéricas
│   │   ├── dateUtils.ts
│   │   ├── validationUtils.ts
│   │   └── helpers.ts
│   │
│   ├── constants/              # Constantes reutilizadas em todo o app
│   │   ├── apiConstants.ts
│   │   ├── appConstants.ts
│   │   └── colors.ts
│   │
│   ├── store/                  # Estado global (Redux, Zustand, etc)
│   │   ├── actions/
│   │   ├── reducers/
│   │   ├── selectors/
│   │   └── index.ts
│   │
│   ├── types/                  # Tipos e interfaces globais
│   │   ├── authTypes.ts
│   │   ├── productTypes.ts
│   │   └── global.d.ts
│   │
│   └── App.tsx                 # Componente raiz da aplicação
│
├── App.tsx                     # Aponta para src/App.tsx
├── index.tsx                   # Ponto de entrada principal
├── package.json
├── tsconfig.json
├── app.json (ou app.config.js)
└── .gitignore
```

### Detalhes e Racionalização (estrutura atualizada)

1. **`src/` (ou `app/`)**  
    Diretório principal para todo o código-fonte da aplicação. Mantém a raiz do projeto limpa e organizada.
    
    > Sugestão: use `src/` por ser padrão mais comum em projetos TypeScript.
    

---

2. **`assets/`**  
    Armazena recursos estáticos:
    
    - `images/`: ícones, ilustrações, logos etc.
        
    - `fonts/`: arquivos de fonte customizada.
        
    - `animations/`: arquivos Lottie, se usados.
        
    
    ➕ Facilita a organização visual e reutilização dos arquivos estáticos.
    

---

3. **`components/`**  
    Componentes reutilizáveis de UI que **não pertencem a uma feature específica**:
    
    - `common/`: componentes "burros", sem lógica de negócio. Ex: `Button`, `TextInput`, `Spacer`.
        
    - `specific/`: componentes reutilizáveis mais complexos. Ex: `ProductCard`, `UserAvatar`.
        
    

Cada componente pode conter:
```
ComponentName/
  ├── index.tsx
  ├── styles.ts
  └── types.ts (se necessário)
```
---

4. **`features/`** (também conhecido como `modules/` ou `domains/`)  
	Aqui você agrupa todo o código relacionado a uma **funcionalidade específica**, como `Auth`, `Products`, `Cart`, etc.  
	
	
Cada feature pode conter:
```
features/
  └── Product/
      ├── components/
      ├── screens/
      ├── services/
      ├── hooks/
      ├── navigation/
      └── types/
```
✅ **Vantagens**:

- Escalável: ideal para apps médios e grandes.
    
- Isolamento por domínio: você sabe onde mexer quando alterar uma funcionalidade.
    
- Ajudaria equipes a colaborarem de forma independente.

--- 
5. **`navigation/`**  
    Gerencia o sistema de rotas do app.
    
    - `AppNavigator.tsx`, `AuthNavigator.tsx`, `TabNavigator.tsx`, etc.
        
    - Pode importar stacks específicos das features.
        
    
    ➕ Deixa claro o fluxo de navegação da aplicação.
    

---

6. **`services/`**  
    Para lógica de acesso a dados e APIs externas:
    
    - Requisições HTTP
        
    - Integração com SQLite, Realm, Firebase, etc.
        
    - AsyncStorage
        
    
    ➕ Centraliza e reutiliza chamadas externas com clareza.
    

---

7. **`contexts/` e `hooks/`**
    
    - `contexts/`: estados globais via Context API. Ex: `AuthContext`, `ThemeContext`.
        
    - `hooks/`: hooks reutilizáveis. Ex: `useDebounce`, `useNetwork`, `useAuth`.
        
    
    ➕ Promove separação de lógica de estado e facilita testes/reutilização.
    

---

8. **`utils/`**  
    Funções auxiliares genéricas:
    
    - Formatação de datas/valores
        
    - Validações
        
    - Conversões
        
    
    ➕ Evita duplicação de lógica e facilita manutenção.
    

---

9. **`constants/`**
    
    - Cores (`colors.ts`)
        
    - Tamanhos (`sizes.ts`)
        
    - Strings fixas (`labels.ts`, `messages.ts`)
        
    - Rotas (`routes.ts`)
        
    
    ➕ Evita "magic strings" e centraliza configurações.
    

---

10. **`store/`**  
    Se estiver usando Redux, Zustand ou outra lib global de estado, toda configuração (actions, reducers, slices, atoms, etc.) deve ficar aqui.
    

➕ Isola o estado global de forma previsível e organizada.

---

11. **`types/`**  
    Armazena tipos TypeScript globais, interfaces, e enums:
    

- `Product.ts`
    
- `User.ts`
    
- `ApiResponse.ts`
    

➕ Centraliza a tipagem, evitando duplicidade e facilitando o autocomplete.