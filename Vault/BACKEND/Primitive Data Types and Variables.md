---

---
## **Primitive Types and Variables**
- Numeric types: Double, Float, Integer, etc.
- Basics of primitive types: `int`, `float`, `double`
- Data type String
- Arrays


## Primitive Data Types
---
Table of all primitive data types in Java, with their respective information. Java has eight primitive data types.

| **Type**  |      **Contains**       | **Default Value** | **Size** |                  **Range**                  | Description                                                                     |
| :-------: | :---------------------: | :---------------: | :------: | :-----------------------------------------: | :------------------------------------------------------------------------------ |
| `boolean` |      True or False      |       false       |  1 bits  |                     N/A                     | Represents a logical value, used in conditions and control flow.                |
|  `char`   |    Unicode character    |      \u0000       | 16 bits  |              \u0000 to \uFFFF               | Represents a single character, stored as a 16-bit Unicode character.            |
|  `byte`   |     Signed Integer      |         0         |  8 bits  |                 -128 to 127                 | Stores small integers, useful for saving memory in large arrays                 |
|  `short`  |     Signed Integer      |         0         | 16 bits  |               -32768 to 32767               | Stores slightly larger integers than `byte`                                     |
|   `int`   |     Signed Integer      |         0         | 32 bits  |          –2147483648 to 2147483647          | Default type for integers, commonly used in loops and counters.                 |
|  `long`   |     Signed Integer      |         0         | 64 bits  | –9223372036854775808 to 9223372036854775807 | Stores large integers, suitable for when `int` is insufficient. Use with `L`.   |
|  `float`  | IEEE 754 floating point |        0.0        | 32 bits  |          1.4E–45 to 3.4028235E+38           | Stores decimal numbers, used for less precise floating-point calculations.      |
| `double`  | IEEE 754 floating point |        0.0        | 64 bits  |     4.9E–324 to 1.7976931348623157E+308     | Default type for decimals, used for high-precision floating-point calculations. |

**Signed Integer** -> Uses two's complement representation for bits, which allows encoding both negative and positive numbers. In this system:
- The **most significant bit (MSB)** is the **sign bit**:
    - `0` indicates a **positive number**.
    - `1` indicates a **negative number**.
- The value of negative numbers is calculated by inverting all the bits of the positive number and adding 1.

|   Sign   | MSB | Bit 3 | Bit 2 | Bit 1 | Value |
| :------: | :-: | :---: | :---: | :---: | :---: |
| Positive |  0  |   1   |   0   |   1   |   5   |
| Negative |  1  |   1   |   0   |   1   |  -5   |

**IEEE 754 floating point** -> The IEEE 754 standard defines a method for representing real (floating-point) numbers in a binary format.

| **Component**  | **Description**                                                                                  |
|-----------------|--------------------------------------------------------------------------------------------------|
| **Sign (S)**    | A single bit that determines the sign of the number: `0` for positive, `1` for negative.         |
| **Exponent (E)**| Encodes the exponent value, adjusted by a **bias** to allow representation of both positive and negative exponents. |
| **Mantissa (M)**| Represents the significant digits (or fraction) of the number.                                  |

---
## **Floating-Point Formats**
IEEE 754 specifies two common formats:

### **1. Single Precision (32 bits)**
- **Sign (1 bit):** Determines the sign of the number.
- **Exponent (8 bits):** Encodes the exponent value with a bias of \(127\).
- **Mantissa (23 bits):** Represents the fractional part.

| **Bit Layout** | S   | EEEE EEEE | MMMMMMMMMMMMMMMMMMMMMMM |
| -------------- | --- | --------- | ----------------------- |
| **Total Bits** | 1   | 8         | 23                      |

### **2. Double Precision (64 bits)**
- **Sign (1 bit):** Determines the sign of the number.
- **Exponent (11 bits):** Encodes the exponent value with a bias of \(1023\).
- **Mantissa (52 bits):** Represents the fractional part.

| **Bit Layout** | S   | EEEEEEEEEEE | MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM |
| -------------- | --- | ----------- | --------------------------------------------------- |
| **Total Bits** | 1   | 11          | 52                                                  |


---
# Why is `String` not a Primitive Data Type?

In Java, `String` is not a primitive data type but a class. This class represents a sequence of characters, which are stored internally as a `char` array. For example:

```java
String str = "HELLO";
```

This creates a `String` object. Alternatively, you can create a `String` from a `char` array:

```java
char[] foo = {'H', 'E', 'L', 'L', 'O'};
String str = new String(foo);
```
### Key Differences
- **Primitive Types**: Types like `int` and `char` are predefined in Java and store their values directly in memory.
- **Reference Type**: A `String` is a reference type, meaning it stores a reference to the object in memory rather than the actual data.
### Advantages of `String` as a Class
Being a class allows `String` to provide useful methods for text manipulation, such as:
- `.length()` — to get the length of the string.
- `.toUpperCase()` — to convert the string to uppercase.
- `.substring()` — to extract a portion of the string.

---
# 📚 **Arrays  in Java**

## 🔹What is an Array? 
> An array (also called a matrix when multidimensional) is a collection of data elements, usually of the same primitive data type, stored in contiguous memory locations. Each element is accessed through an index, starting at 0. Arrays are used to efficiently organize and manage data. In most programming languages, arrays have a fixed size, defined at the time of creation.
> 
> Arrays can also be multidimensional, such as ==**2D arrays (tables)**== or **==3D arrays (cubes)==**, allowing for more complex data structures.

### **Examples 

==Method 1: How to create an Array.==
```java 
// Creating an array and assigning values
String[] strArray = new String[3];
strArray[0] = "Jennie";
strArray[1] = "Lisa";
strArray[2] = "Rose";

// Printing each element
for(int i = 0; i < strArray.length; i++) {
	system.out.println("I'm " + strArray[i]);
}
```
Output:
``` shell
I'm Jennie
I'm Lisa
I'm Rose
```

Method 2: Other ways to create an array
```java 
//  Different forms of initializing an array
int[] arrayNumbers = new int[3]; // Empty array of size 3
int[] arrayNumbers2 = {1, 2, 3, 4, 5}; // Array initialized with values
int[] arrayNumbers3 = new int[]{1, 2, 3, 4, 5}; // Another way to initialize

// foreach to print date inside the Array
for (int num : arrayNumbers2) {  
    System.out.println(num);  
}
```
Output:
``` shell
1
2
3
4
5
```

Method 3: Multidimensional array
```java 
// Creating a 2D array (matrix)
int[][] multiArray = new int[2][2];

// base 1
multiArray[0][0] = 1;
multiArray[0][1] = 2;

// base 2
multiArray[1][0] = 3;
multiArray[1][1] = 4;

// Printing the 2D array
for(int i = 0; i < multiArray.length; i++){
	for(int y = 0; y < multiArray[i].length;y++) {
		System.out.println(multiArray[i][y] + " ");
	}
}
```
Output:
``` shell
1 2 
3 4 
```

