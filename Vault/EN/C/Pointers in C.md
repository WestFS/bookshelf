# Pointers in C

## What is a Pointer?
A pointer is a variable that stores the memory address of another variable.

## Declaration and Initialization
```c
int x = 10;
int *ptr = &x; // ptr holds the address of x
```

## Dereferencing
```c
printf("%d", *ptr); // Output: 10
```

## Pointer Arithmetic
```c
int arr[3] = {1, 2, 3};
int *p = arr;
p++;
printf("%d", *p); // Output: 2
```

## Pointers and Arrays
Arrays and pointers are closely related. The array name is a pointer to its first element.

## Pointers to Functions
```c
void greet() { printf("Hello"); }
void (*funcPtr)() = greet;
funcPtr(); // Output: Hello
```

## Common Pitfalls
- Dereferencing NULL or uninitialized pointers
- Memory leaks (forgetting to free memory)
- Pointer arithmetic errors

## Advanced Tips
- Use `const` with pointers for safety
- Double pointers for dynamic 2D arrays

## References
- [C Pointers - TutorialsPoint](https://www.tutorialspoint.com/cprogramming/c_pointers.htm) 