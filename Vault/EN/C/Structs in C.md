# Structs in C

## What is a Struct?
A struct (structure) is a user-defined data type that groups related variables of different types.

## Declaration and Initialization
```c
struct Point {
    int x;
    int y;
};
struct Point p1 = {3, 4};
```

## Accessing Members
```c
printf("%d", p1.x); // Output: 3
```

## Nested Structs
```c
struct Line {
    struct Point start;
    struct Point end;
};
```

## Memory Layout
Members are stored in the order declared, with possible padding for alignment.

## Common Pitfalls
- Uninitialized members
- Padding and alignment issues

## Advanced Tips
- Use `typedef` for simpler syntax
- Structs can be passed by value or by pointer

## References
- [C Structs - Programiz](https://www.programiz.com/c-programming/c-structures) 