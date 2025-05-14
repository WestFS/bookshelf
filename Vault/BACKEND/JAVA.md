### [[Beginner Developer]]
A beginner developer must master the very basics:
- Basic OOP:
    - Getters, setters, and constructors (Guanabara: [https://youtu.be/6i-_R5cAcEc](https://youtu.be/6i-_R5cAcEc))
    - At least understand how to create a `Fish extends Animal`, the basics of inheritance.
    - Final classes, methods, and fields (Carlos Henrique Java: [https://youtu.be/Uhph07-JfZs](https://youtu.be/Uhph07-JfZs))
    - Access modifiers: `protected`, `public`, and `private`
- Static methods, classes, and fields
- If, else, and else if
- Foreach (for)
- While
- Numeric types like Double, Float, Integer
- Arrays
- Throwing exceptions
- Try, catch, and finally

Also, understand:

- Method parameters
- Primitive types basics (`int`, `float`, `double`)
- Return statements: `return null;`, `return value;`, `return;`

**NEVER** create fields without an explicit access modifier, such as:

``` java
String text = "";
```

Always prefer using an access modifier:

``` java
private String text = "";
```

_Don’t forget to use `final` whenever possible._

---

### Intermediate Developer

[Intermediate Developer](https://www.notion.so/Desenvolvedor-Intermedi-rio-d3c6678d797d477881c47ff9b1538b11?pvs=21)

_This is where many give up._

**Note:** The more advanced you become, the less `static` you use in your code. Top Java developers aim to use ZERO `static`—you don’t need it.

If you’ve reached this level, you’re more advanced. But you must learn these to earn a seat at the adult table:

- Knowledge of Git/GitHub
- Familiarity with a build tool:
    - Maven or Gradle (I recommend Maven, but it’s personal preference)
- Advanced OOP:
    - Interfaces and their utilities (far more useful than they seem)
    - `record` classes and their lack of utility
    - Final method parameters
    - Sealed classes
    - Abstract methods in abstract classes
    - Utility classes (helper classes)
    - `import static`
- Annotations:
    - @Deprecated
    - Mastering @Override
    - At this level, stop suppressing warnings with @SuppressWarnings or similar hacks
- Clean code:
    - Basic JetBrains annotations ([https://github.com/JetBrains/java-annotations](https://github.com/JetBrains/java-annotations)):
        - @NotNull
        - @Nullable
        - @Range
        - @Internal and @Experimental
    - Early return technique (examples below)
- Creating custom `Exception` classes:
    - Understand the concepts of `Error`, `Throwable`, `RuntimeException`
    - Study existing exceptions, like `NullPointerException` and `IllegalStateException`
- Java Reflection:
    - Learn how to access private methods or fields and related concepts
- Intermediate knowledge of MySQL and SQLite (SQL in general)
- Libraries (native or third-party):
    - Master native Java classes to avoid reinventing the wheel
    - EVERYTHING about Generic Types (more complex than it seems)
        - Generic methods like `public final <T> T getValue()`
        - Unknown generic type `?`
    - Date classes: Date, OffsetDateTime, Duration, Instant, ZonedDateTime, LocalDateTime, etc.
    - JSON (Google's GSON recommended)
    - File handling
    - Learn `java.util.Optional`
    - Use `java.util.function.Consumer`, `Predicate`, and `Supplier`
    - Understand the difference between `Set<T>` and `List<T>`
    - Use `Map<K, V>`
    - Code optimization:
        - Streams:
            - `Stream#filter`
            - `Stream#map`
            - `Stream#anyMatch`
    - Serializable:
        - Many native exceptions implement this interface—understand why
    - InputStream and OutputStream (study thoroughly)
    - Basics of Socket and Channel ([Netty.io](http://netty.io)):
        - Establishing connections and sending/receiving packets
    - UUIDs
- Overriding `equals()` and `hashCode()`:
    - Crucial for object behavior—don’t ignore these methods
- Basics of cryptography (`MD5`, `SHA-256`, etc.)
- Intermediate/advanced mathematics:
    - Sine, cosine, tangent
    - Creating formulas for your projects
- Basic knowledge of regex
- Practice, lots of practice.

---

### Advanced Developer

[Advanced Developer](https://www.notion.so/Desenvolvedor-Avan-ado-13bbf3dcca8580ecb370f3ede2c86e97?pvs=21)

_If you’ve made it here, congratulations! Your knowledge is IMPRESSIVE and rare._

**Welcome to the final boss! But if you think you’re ready...you’re probably not! 😆**

- Total mastery of testing environments:
    - Master the `org.junit.Test` annotation
- Total control over byte manipulation:
    - Work with operators like `|`, `&`, `~`, etc.
- Advanced cryptography:
    - AES/ECB
    - AES/CBC, AES/GCM, and related concepts (understand Initialization Vectors)
- Create your own Maven repository
- Annotations:
    - Master all JetBrains annotations (e.g., @Contract)
    - Create custom annotations
        - Build your own Annotation Processor
    - Use @FunctionalInterface
- Master `volatile`
- Multi-threading:
    - Learn `Thread` and `Runnable`
    - Advanced knowledge of `AtomicInteger`, `AtomicBoolean`, etc.
    - Use of `synchronized`
    - CompletableFuture and ExecutorService
- Advanced math knowledge
- Mastery of rendering and related libraries:
    - JPanel, JFrame, Graphics, Graphics2D
    - Render complex 3D objects on a 2D screen
    - Tree rendering and responsive rendering
- Mastery of external APIs:
    - Rest APIs
    - Socket APIs
    - Integrating any API into your code
- Basic web development with Java
- More interfaces than classes in your code
- ZERO `static` usage (optional but common in advanced projects)
- Cleanest code using the best practices
- Runtime library loading/unloading
- Knowledge of the `native` keyword in Java
- Build code outside Java but compatible with the JVM (e.g., like Scala)
- Advanced data knowledge:
    - Data types and transfer protocols (FTP, Sockets, HTTP, RMI)
    - Data security and storage (e.g., RAID10)
- Email systems:
    - Understand SMTP basics