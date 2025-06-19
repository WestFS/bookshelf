# Data Types in C

## Table of Contents
1. [Categories of Data Types](#1-categories-of-data-types)
2. [Type Compatibility and Type Casting](#2-type-compatibility-and-type-casting)
3. [Format Specifiers for printf() and scanf()](#3-format-specifiers-for-printf-and-scanf)
4. [Data Size and Platform Differences](#4-data-size-and-platform-differences)
5. [Fixed-Width Integer Types](#5-fixed-width-integer-types-from-stdint-h)
6. [Derived Types in Detail](#6-derived-types-in-detail)
7. [Typedef: Custom Type Names](#7-typedef-custom-type-names)
8. [Enumerations (enum)](#8-enumerations-enum)
9. [Common Pitfalls](#9-common-pitfalls)
10. [Summary / Key Takeaways](#10-summary--key-takeaways)
11. [References](#11-references)

---

Understanding data types is fundamental in C programming. They define the kind of values a variable can store, the amount of memory it occupies, and the operations that can be performed on it.

## 1. Categories of Data Types

C has several built-in data types, categorized as follows:

- **Primary (Basic) Data Types:** Fundamental types for integers, floating-point numbers, and characters.
    - **Integers:** `int`, `short`, `long`, `long long` (and their `unsigned` versions). Used for whole numbers.
    - **Floating Point:** `float`, `double`, `long double`. Used for real numbers with decimals.
    - **Characters:** `char`. Used for single characters.
    - **Boolean (since C99):** `_Bool` or `bool` (from `<stdbool.h>`). Represents true (1) or false (0).
- **Derived Data Types:** Built from primary types.
    - Arrays
    - Pointers
    - Structures (`struct`)
    - Unions (`union`)
    - Enumerations (`enum`)
- **Void Type:** `void`. An incomplete type meaning "no type" or "any type" (when used with pointers).

## 2. Type Compatibility and Type Casting

**Type compatibility** refers to how different data types interact, especially in expressions or assignments. C is strongly but flexibly typed, often performing automatic conversions.

- **Implicit Type Conversion (Coercion):** When an operation involves different data types, C automatically converts the "smaller" type to the "larger" type to avoid data loss. This follows the "usual arithmetic conversions."

    **Example:**
    ```c
    int a = 5;
    float b = 2.5;
    float result = a + b; // 'a' is implicitly converted to 5.0f
    ```

- **Explicit Type Conversion (Type Casting):** You can force a conversion from one type to another using the cast operator `(type_name)`. This is useful for controlling conversions or avoiding unexpected results.

    **Example:**
    ```c
    int total_students = 30;
    int passed_students = 22;
    float percentage = (float)passed_students / total_students; // Ensures 22.0 / 30.0
    ```

## 3. Format Specifiers for printf() and scanf()

Format specifiers are used with input/output functions like `printf()` and `scanf()` to tell the compiler what type of data to expect or print. They start with a percent sign (`%`).

| Category         | Data Type                | printf() | scanf() | Example |
|------------------|-------------------------|----------|---------|---------|
| Integers         | `int`                   | `%d`/`%i`| `%d`/`%i`| `int age = 30; printf("%d", age);` |
|                  | `unsigned int`          | `%u`     | `%u`    | `unsigned int count = 100; printf("%u", count);` |
|                  | `short`                 | `%hd`    | `%hd`   | `short value = 10; scanf("%hd", &value);` |
|                  | `unsigned short`        | `%hu`    | `%hu`   | `unsigned short uvalue = 20;` |
|                  | `long`                  | `%ld`    | `%ld`   | `long distance = 100000L;` |
|                  | `unsigned long`         | `%lu`    | `%lu`   | `unsigned long big_num = 4294967295UL;` |
|                  | `long long`             | `%lld`   | `%lld`  | `long long very_big = 1234567890123LL;` |
|                  | `unsigned long long`    | `%llu`   | `%llu`  | `unsigned long long u_very_big = 98765432109ULL;` |
| Floating Point   | `float`                 | `%f`     | `%f`    | `float price = 19.99f;` |
|                  | `double`                | `%f` (printf), `%lf` (scanf) | `%lf` | `double pi = 3.14159265;` |
|                  | `long double`           | `%Lf`    | `%Lf`   | `long double precise = 1.23456789L;` |
| Characters       | `char`                  | `%c`     | `%c`    | `char initial = 'J';` |
|                  | `char[]` (string)       | `%s`     | `%s`    | `char name[] = "Alice";` |
| Pointers         | `void*`                 | `%p`     | `%p`    | `int *ptr = &age;` |

**Note:** For `double` with `printf`, use `%f`, but for `scanf`, use `%lf`. This is a common source of confusion.

## 4. Data Size and Platform Differences

The **size** (memory usage) of basic data types is **not fixed** by the C standard, except for `char` (always 1 byte). Instead, the standard specifies **minimum ranges** and **relationships** between sizes:

- `sizeof(char) <= sizeof(short) <= sizeof(int) <= sizeof(long) <= sizeof(long long)`
- `sizeof(float) <= sizeof(double) <= sizeof(long double)`

This means the exact size of an `int`, `long`, or `float` can vary depending on the **platform** (CPU architecture and OS).

| Data Type              | Typical Size (Bytes) | Minimum Range (C Standard) |
|------------------------|---------------------|----------------------------|
| `char`                 | 1                   | -127 to +127               |
| `unsigned char`        | 1                   | 0 to 255                   |
| `short`                | 2                   | -32,767 to +32,767         |
| `unsigned short`       | 2                   | 0 to 65,535                |
| `int`                  | 2 or 4 (usually 4)  | -32,767 to +32,767 (often larger) |
| `unsigned int`         | 2 or 4 (usually 4)  | 0 to 65,535 (often larger) |
| `long`                 | 4 or 8              | -2,147,483,647 to +2,147,483,647 |
| `unsigned long`        | 4 or 8              | 0 to 4,294,967,295         |
| `long long`            | 8                   | ~-9e18 to +9e18            |
| `unsigned long long`   | 8                   | 0 to ~1.8e19               |
| `float`                | 4                   | ~±3.4e-38 to ±3.4e+38 (6-7 decimal digits) |
| `double`               | 8                   | ~±1.7e-308 to ±1.7e+308 (15-17 decimal digits) |
| `long double`          | 8, 10, 12, or 16    | At least as wide as `double` |

### Platform Differences

- **32-bit vs. 64-bit systems:**
    - On **32-bit systems**, `int` and `long` are typically 4 bytes. Pointers are 4 bytes.
    - On **64-bit systems**, `int` remains 4 bytes, but `long` is often 8 bytes. Pointers are 8 bytes. `long long` is always 8 bytes.
- **Compiler Implementation:** Different compilers (GCC, Clang, MSVC) may have small variations, but generally follow platform conventions.
- **CPU Architecture:** The underlying CPU (x86, ARM) can influence type handling, but modern compilers abstract most of this.

**To determine the exact sizes on your system, use the `sizeof` operator:**

```c
#include <stdio.h>

int main() {
    printf("Size of char: %zu bytes\n", sizeof(char));
    printf("Size of int: %zu bytes\n", sizeof(int));
    printf("Size of long: %zu bytes\n", sizeof(long));
    printf("Size of long long: %zu bytes\n", sizeof(long long));
    printf("Size of float: %zu bytes\n", sizeof(float));
    printf("Size of double: %zu bytes\n", sizeof(double));
    printf("Size of long double: %zu bytes\n", sizeof(long double));
    printf("Size of unsigned long int: %zu bytes\n", sizeof(unsigned long int));
    return 0;
}
```

## 5. Fixed-Width Integer Types (from <stdint.h>)

C99 introduced fixed-width integer types for guaranteed sizes, useful for portability:

- `int8_t`, `uint8_t`   // 8 bits
- `int16_t`, `uint16_t` // 16 bits
- `int32_t`, `uint32_t` // 32 bits
- `int64_t`, `uint64_t` // 64 bits

**Example:**
```c
#include <stdint.h>
int8_t small = -100;
uint32_t big = 4000000000U;
```

## 6. Derived Types in Detail

### Arrays
[See more: Arrays in C](Arrays in C.md)

### Pointers
[See more: Pointers in C](Pointers in C.md)

### Structures
[See more: Structs in C](Structs in C.md)

### Unions
[See more: Unions in C](Unions in C.md)

## 7. Typedef: Custom Type Names

```c
typedef unsigned long ulong;
ulong bigNumber = 123456789UL;
```

## 8. Enumerations (enum)

[See more: Enums in C](Enums in C.md)

## 9. Common Pitfalls

- **Signed vs. Unsigned Confusion:** Mixing signed and unsigned types can lead to unexpected results, especially in comparisons and arithmetic.
- **Integer Overflow:** Exceeding the maximum value of an integer type causes overflow, which is undefined for signed types.
- **Precision Loss:** Assigning a floating-point value to an integer truncates the decimal part.
- **Platform Differences:** Code that assumes specific type sizes may not be portable.
- **Format Specifier Mismatches:** Using the wrong format specifier in `printf`/`scanf` can cause bugs or crashes.

## 10. Summary / Key Takeaways

- Always choose the smallest type that fits your data.
- Use fixed-width types for portability.
- Be careful with type conversions and format specifiers.
- Check type sizes with `sizeof` if portability is important.
- Understand your platform/compiler for best results.

## 11. References

- [ISO C Standard (C99)](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf)
- [cplusplus.com - C Data Types](https://cplusplus.com/doc/tutorial/variables/)

## 2. Type Compatibility and Type Casting

[See more: Type Casting in C]([[Type Casting in C]])

## 3. Format Specifiers for printf() and scanf()

[See more: Format Specifiers in C](Format Specifiers in C.md)