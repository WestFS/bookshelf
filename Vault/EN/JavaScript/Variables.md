# Numbers
Number is a data primitives in java script has only one integer for double and float 
``` JavaScript
console.log(1 + 2);  // 3
console.log(3 - 4);  // 1
console.log(5 * 6);  // 30
console.log(7 / 8);  // 0.875

console.log(1 / 0);   // Infinity
console.log(-1 / 0);  // -Infinity
console.log(0 / 0);   // NaN

console.log(Infinity);
console.log(-Infinity);
console.log(NaN);

Methods for convert integer in float 
console.log(parseInt("42", 10));
console.log(parseInt("137", 10));
console.log(parseFloat("0.1"));
console.log(parseFloat("1e-3"));

```

# The Math Library

| Math Commands | Description                                                                    | Command                                               |
| ------------- | ------------------------------------------------------------------------------ | ----------------------------------------------------- |
| Math.E        | Euler’s constant and the base of natural logarithms, approximately 2.718.      | `console.log(Math.E)`                                 |
| Math.PI       | Ratio of the circumference of a circle to its diameter, approximately 3.14159. | `console.log(Math.PI)`                                |
| Math.ceil     | Returns the smallest integer greater than or equal to a number.                | `console.log(Math.ceil(1.1));   // 2)`                |
| Math.floor    | Returns the largest integer less than or equal to a number.                    | `console.log(Math.floor(1.1));  // 1`                 |
| Math.round    | Returns the value of a number rounded to the nearest integer.                  | `console.log(Math.round(1.1));  // 1`                 |
| Math.cos      | Returns the cosine of a number.                                                | `console.log(Math.cos(Math.PI / 3));`                 |
| Math.sin      | Returns the sine of a number.                                                  | `console.log(Math.sin(Math.PI / 3));`                 |
| Math.tan      | Returns the tangent of a number.                                               | `console.log(Math.tan(Math.PI / 3));`                 |
| Math.acos     | Returns the arccosine of a number.                                             | `console.log(Math.acos(0.500));`                      |
| Math.asin     | Returns the arcsine of a number.                                               | `console.log(Math.asin(0.866));`                      |
| Math.atan     | Returns the arctangent of a number.                                            | `console.log(Math.atan(1.732));`                      |
| Math.exp      | Computes eⁿ, where e ≈ 2.718 and n is the input argument the exp               | `console.log(Math.exp(1));       // Exp of 1<br>`     |
| Math.log      | Returns the natural logarithm (loge, also ln) of a number.                     | `console.log(Math.log(Math.E));  // Log of e`         |
| Math.pow      | Returns base to the exponent power, that is, baseexponent.                     | `console.log(Math.pow(3, 2));    // Square of 3`      |
| Math.sqrt     | Returns the positive square root of a number.                                  | `console.log(Math.sqrt(9));      // Square root of 9` |
|               |                                                                                |                                                       |

---
# Strings

Strings are the second kind of primitive in JavaScript. A string is a sequence of characters. Strings are usually used to contain text input by the user, or messages to output to the user. Strings are immutable and cannot be modified, though new strings can be created out of old ones.

String values can be specified using single quotes `''` or double quotes `""`. There is no functional difference between single and double quotes.

``` JavaScript
console.log("I am a string!");
console.log('So am I!');
```

``` JavaScript
console.log("Hello world!"[0]); // Result H
```

Strings support a number of operators. Strings can be concatenated using the `+` operator. Strings can be concantenated with other non-string values, which will be first converted to strings.

``` JavaScript
console.log("Hello" + "Dave");
console.log("The answer to Life, The Universe and Everything is " + 42);
```

The length of a string can be obtained by getting the value of the `length` property. Note that length is not a function and should not be invoked. `length` is automatically updates whenever the string is modified, and cannot be modified directly.

Substrings search methods:

`contains` Determines whether one string may be found within another string.

`indexOf` Returns the index within the calling String object of the first occurrence of the specified value, or -1 if not found.

`lastIndexOf` Returns the index within the calling String object of the last occurrence of the specified value, or -1 if not found.

Case conversion methods:

`toLowerCase`

Returns the calling string value converted to lower case.

`toUpperCase`

Returns the calling string value converted to uppercase.

``` JavaScript
console.log("I'm in lowercase".toLowerCase());
console.log("I'm in uppercase".toUpperCase());
```

Substring methods:

`slice`

Extracts a section of a string and returns a new string.

`split`

Splits a String object into an array of strings by separating the string into substrings.

`substr`

Returns the characters in a string beginning at the specified location through the specified number of characters.

`substring`

Returns the characters in a string between two indexes into the string.

``` JavaScript
console.log("one two three four".split()[0]);
console.log("H")
```

---
# Undefined and Null

In JavaScript, both `undefined` and `null` represent the absence of a value, but they are used in different situations and have different meanings.

- **`undefined`** means a variable has been declared but has not yet been assigned a value. It is automatically set by JavaScript.
    
- **`null`** is an assignment value. It represents the intentional absence of any object value and is explicitly set by the programmer.
    

| Concept         | `undefined`                                                                 | `null`                                       |
| --------------- | --------------------------------------------------------------------------- | -------------------------------------------- |
| **Who sets it** | JavaScript automatically                                                    | The programmer explicitly                    |
| **Meaning**     | “Not yet assigned”                                                          | “Deliberate absence of value”                |
| **Type**        | `undefined` (primitive type)                                                | `object` (due to a legacy bug in JavaScript) |
| **Typical use** | Uninitialized variables, missing arguments, or non-existent object property | Used to clear a variable or signal no value  |
### Example

``` JavaScript
let a; 
console.log(a);    // undefined  
let b = null; 
console.log(b);    // null
```

### Best Practice
> Use `undefined` to represent uninitialized or missing values (usually done by JavaScript), and use `null` when you want to intentionally signal that a variable should have "no value".

--- 
## Booleans

Boolean is a primitive data type that represents **only two values**: `true` and `false`.
``` JavaScript
console.log(true);   // true console.log(false);  // false
```

### Boolean Contexts

In JavaScript, non-boolean values can also behave like booleans in conditional expressions (such as in `if` or `while` statements). This is known as **type coercion**, where values are converted to a boolean automatically.

#### Falsy values

These values are treated as `false` in boolean contexts:

- `false`
    
- `0`
    
- `NaN`
    
- `""` (empty string)
    
- `null`
    
- `undefined`
    

#### Truthy values

Any value **not listed above** is treated as `true`. For example:

- Non-zero numbers (`1`, `-1`, `3.14`, etc.)
    
- Non-empty strings (`"hello"`)
    
- Arrays (`[]`)
    
- Objects (`{}`)
    

> Note: Even empty arrays and objects are considered truthy, which can sometimes be unintuitive.


``` JavaScript
if ([]) {   
	console.log("Empty array is truthy"); 
}  

if ({}) {   
	console.log("Empty object is truthy"); 
}
```

---- 
#  Variables

Variables in JavaScript allow you to store values for later use or computation. They are declared using the `var`, `let`, or `const` keywords. However, the use of `var` is being deprecated in favor of `let` and `const` for block-scoped variables.

### Declaring Variables

You can declare a variable and assign it a value on the same line:

`var myNum = 1;`

It’s recommended to declare variables as close as possible to their use to improve code readability.

### Global Variables

If you declare a variable **without using `var`, `let`, or `const`**, it will automatically be assigned to the **global scope**, which is considered bad practice.

### ReferenceError

Using a variable before declaring it will result in a **ReferenceError**.

``` JavaScript
console.log(myNum);  // ReferenceError: myNum is not defined
```

### Checking a Variable's Type

To check the type of a variable, you can use the `typeof` operator. If the variable has not been assigned a value, `typeof` will return `undefined`.

``` JavaScript
var myNum = 1; 
console.log(typeof myNum);       // number  

var myBool = true; 
console.log(typeof myBool);      // boolean  

var myString = "Hello world"; 
console.log(typeof myString);    // string  

var myNull = null; 
console.log(typeof myNull);      // object (this is a JavaScript quirk)  
var myUndefined; 
console.log(typeof myUndefined);  // undefined  

console.log(typeof myMissing);    // undefined
```

### Key Points

- **Uninitialized variables** default to `undefined`.
    
- **`null`** is considered an object due to an old JavaScript quirk, though it represents "no value."
    
- **`typeof`** is a helpful operator to check if a variable exists and determine its type.

---

# Control Structures

JavaScript inherits control structures from languages like C++ and Java, with some quirks and behavior to be aware of. These structures help in controlling the flow of the program.

### **`if` Statement**

The `if` statement evaluates a condition and executes a block of code if the condition is true.

javascript

Copy code

``` JavaScript
var x = 2; 
if (x % 2 == 0) {     
	console.log("x is even"); 
}
```

You can chain multiple conditions using `else if` and `else`:

- **`else if`**: Checks an additional condition if the previous conditions were false.
    
- **`else`**: Executes when all previous conditions are false.
    

``` JavaScript
var x = 11; 
if (x < 10) {     
	console.log("x is less than 10."); 
} else if (x >= 10 && x <= 20) {     
	console.log("x is between 10 and 20."); 
} else {     
	console.log("x is more than 20."); 
}
```

### **`while` Loop**

The `while` loop runs a block of code as long as the condition evaluates to true. The condition is checked before the block runs.

``` JavaScript
var numNyan = 10; 
var i = 0; 
while (i < numNyan) {     
	console.log("nyan");     
	i++; 
}
```

### **`for` Loop**

The `for` loop is typically used when you know the number of iterations. It takes three expressions: **initialization**, **condition**, and **increment**.

``` JavaScript
var n = 3; 
var d = 10; 
console.log("First " + n + " multiples of " + d); 

for (var i = 1; i <= n; i++) {     
	console.log(i * d);
}
```

This example can also be written with a `while` loop, but the `for` loop provides a more compact and readable form when dealing with a fixed number of iterations.

### **`switch` Statement**

The `switch` statement is used to evaluate an expression and match it against multiple cases. When a match is found, the corresponding block is executed. It is often used as an alternative to multiple `if-else` statements.

``` JavaScript
var n = 1; 
switch (n) {
	case 1:         
		console.log("Ichi");         
		break;     
	case 2:         
		console.log("Ni");
		break; 
    case 3:       
	    console.log("San");         
	    break; 
}
```

**Fall-through Behavior**: One quirk of the `switch` statement is that it doesn't automatically stop after matching a case. If you forget to add a `break` statement, the program will "fall through" and execute the code for the following cases.

**Example of Fall-Through**:

``` JavaScript
var n = 1;
switch (n) {     
	case 1:         
	console.log("Ichi");    
	case 2:         
	console.log("Ni");         
	break;     
	case 3:         
	console.log("San"); 
}
```

In the example above, even though `n` is 1, it will log **"Ichi"** and **"Ni"**, because there's no `break` after the first case.

This fall-through behavior can be useful in some situations, but it can also lead to bugs if not handled carefully.

---
### **Summary**

- **`if`, `else if`, and `else`** allow conditional execution based on boolean conditions.
    
- **`while`** and **`for`** are used for loops, where `while` is condition-driven and `for` is typically used when the number of iterations is known.
    
- **`switch`** allows matching a variable against multiple cases, but you need to be mindful of the fall-through behavior.