# Unions in C

## What is a Union?
A union is a user-defined data type where all members share the same memory location. Only one member can hold a value at a time.

## Declaration and Initialization
```c
union Data {
    int i;
    float f;
    char str[20];
};
union Data data;
data.i = 10;
```

## Accessing Members
```c
printf("%d", data.i); // Output: 10
```

## Memory Sharing
The size of a union is the size of its largest member.

## Common Pitfalls
- Only the last assigned member is valid
- Reading from a member that wasn't last written is undefined

## Advanced Tips
- Useful for memory-efficient data storage
- Often used in embedded systems and low-level code

## References
- [C Unions - GeeksforGeeks](https://www.geeksforgeeks.org/union-c/) 