# Type Casting in C

## What is Type Casting?
Type casting is converting a variable from one data type to another.

## Implicit Casting (Type Promotion)
Occurs automatically when assigning a smaller type to a larger type.
```c
int a = 5;
double b = a; // a is promoted to double
```

## Explicit Casting
You specify the target type using the cast operator.
```c
int a = 5;
double b = (double)a / 2; // Ensures floating-point division
```

## Common Pitfalls
- Loss of data when casting from larger to smaller types
- Integer division when expecting floating-point results

## Advanced Tips
- Use casting to control arithmetic operations
- Be careful with pointer casting (can cause undefined behavior)

## References
- [C Type Casting - GeeksforGeeks](https://www.geeksforgeeks.org/type-conversion-c/) 