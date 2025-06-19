# While Loop

The `while` loop in Java is a control flow statement that allows code to be executed repeatedly based on a given boolean condition. The loop continues to execute as long as the condition remains true.

## Syntax

```java
while (condition) {
    // code to be executed
}
```

- `condition`: A boolean expression that is evaluated before each iteration. If `true`, the loop body executes. If `false`, the loop terminates.

## How it Works

1.  The `condition` is evaluated.
2.  If the `condition` is `true`, the statements inside the `while` loop's body are executed.
3.  After executing the loop body, the `condition` is evaluated again.
4.  This process repeats until the `condition` becomes `false`.

**Important:** Ensure that the condition eventually becomes `false` to avoid an infinite loop. This usually involves modifying a variable within the loop body that affects the condition.

## Example

```java
public class WhileExample {
    public static void main(String[] args) {
        int count = 0;
        System.out.println("Counting from 0 to 4 using a while loop:");
        while (count < 5) {
            System.out.println("Count is: " + count);
            count++; // Increment count to eventually make the condition false
        }

        System.out.println("\nLoop finished. Final count: " + count);
    }
}
```

## Do-While Loop (Variation)

A `do-while` loop is similar to a `while` loop, but it guarantees that the loop body will execute at least once, because the condition is evaluated *after* the loop body.

### Syntax

```java
do {
    // code to be executed
} while (condition);
```

## Related Concepts

- [[Conditional Statements If Else and Else If]]
- [[Foreach Loop]]
- [[Defining Methods and Returning Values]]
