# Foreach Loop

The `foreach` loop (also known as enhanced for loop) in Java provides a simpler way to iterate over elements in arrays and collections. It's particularly useful when you need to process each element without needing its index.

## Syntax

```java
for (DataType item : collection) {
    // code to be executed for each item
}
```

- `DataType`: The data type of the elements in the collection.
- `item`: A variable that will hold the current element in each iteration.
- `collection`: The array or collection (e.g., `ArrayList`, `HashSet`) to iterate over.

## Example

```java
import java.util.ArrayList;
import java.util.List;

public class ForeachExample {
    public static void main(String[] args) {
        List<String> fruits = new ArrayList<>();
        fruits.add("Apple");
        fruits.add("Banana");
        fruits.add("Cherry");

        System.out.println("Iterating through fruits using foreach loop:");
        for (String fruit : fruits) {
            System.out.println(fruit);
        }

        int[] numbers = {1, 2, 3, 4, 5};
        System.out.println("\nIterating through numbers using foreach loop:");
        for (int number : numbers) {
            System.out.println(number);
        }
    }
}
```

## Comparison with Traditional For Loop

| Feature           | Foreach Loop                               | Traditional For Loop                               |
| :---------------- | :----------------------------------------- | :------------------------------------------------- |
| **Simplicity**    | Simpler syntax, less prone to off-by-one errors. | More complex syntax, requires managing index.      |
| **Index Access**  | No direct access to the index of the element. | Provides direct access to the index.               |
| **Modification**  | Cannot modify the collection during iteration (can lead to `ConcurrentModificationException`). | Can modify the collection (with caution).          |
| **Use Case**      | Best for iterating over all elements when the index is not needed. | Best when you need to manipulate elements by index, iterate backwards, or modify the collection. |

## Related Concepts

- [[Conditional Statements If Else and Else If]]
- [[While Loop]]
- [[Arrays and Objects]] (JavaScript, but concept of collections is related)
