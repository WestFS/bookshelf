#tag: PT/React Native
# Componentes nativos do React Native
> [!NOTE]  
> ## O que são "componentes nativos"?
> Componente é uma parte **reutilizável** e **independente** da interface de uma aplicação. No **React Native**, a aplicação é dividida em vários componentes, onde cada um representa uma parte específica da interface — como botões, textos, formulários, imagens, etc.
> 
> Essa abordagem facilita a **organização**, **manutenção** e **escalabilidade** do projeto, permitindo que cada parte da aplicação seja desenvolvida de forma isolada, mas funcione de maneira integrada.

## Tabela de Componentes
A tabela a seguir apresenta os **componentes nativos do React Native**, que se comunicam com o **JavaScript Core** e com os elementos da interface nativa dos sistemas Android e iOS:

| **React Native** | **Android (Java/Kotlin)** | **iOS (Swift)** | **HTML**              |
| ---------------- | ------------------------- | --------------- | --------------------- |
| `<View>`         | `ViewGroup`               | `UIView`        | `<div>`               |
| `<Text>`         | `TextView`                | `UITextView`    | `<p>`                 |
| `<Image>`        | `ImageView`               | `UIImageView`   | `<img>`               |
| `<TextInput>`    | `EditText`                | `UITextField`   | `<input type="text">` |
| `<ScrollView>`   | `ScrollView`              | `UIScrollView`  | `<div>`               |

## Comando <View>. 
O <View> é o principal componente na construção de interfaces (UI) no React Native. Ele funciona como um container que pode agrupar e organizar outros componentes, como textos, imagens e botões.

Além disso, o <View> se integra com layouts flexíveis (Flexbox), estilos personalizados (style) e gestos de interface. E também pode ser aninhado, ou seja, você pode colocar uma <View> dentro de outra <View>, criando estruturas mais complexas.

