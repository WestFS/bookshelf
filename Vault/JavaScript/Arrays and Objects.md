Arrays and objects are both ways to group data types into collections in JavaScript.

# Arrays
How to Initialize an Array
``` JavaScript
var myArr =  [ ]
let myArry = [ ]
const myArray = [ ]
```

> [!NOTE]
> **Prefer using `let` or `const`** to initialize arrays. Avoid using `var` — it's outdated and can lead to unexpected behavior due to function-scoping and hoisting.

You can get and set members of an array using the square bracket notation. JavaScript arrays are zero-indexed. `myArr[0]` refers to the first element of the array.

``` JavaScript
let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

console.log(daysOfWeek[0]);
daysOfWeek[0] = "Mon";
```

JavaScript don't have array out-of-bound with Java oour other language, because if a index doesn't exist he is defined with undefined.
``` JavaScript
let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

console.log("The value of the 8th day is: " + daysOfWeek[8]); // undefined
```

In the JavaScript don't need use the same elements type in array, can you create anys typs in the same array 

``` JavaScript
let daysOfWeek = ["The Answer to Life, Universe and Everything", 42];
```

You can even create arrays of arrays, also known as multidimensional arrays. Unfortunately, there is no shorthand for creating these arrays: you have to initialize the child arrays by hand, using a loop if necessary. Also, the multidimensional array need not be rectangular: each row can have a different number of elements.

``` JavaScript
var ticTacToe= [
	["X", "O", "X"],
	[" ", "O", " "],
	[" ", " ", "X"],
];
```

If you wish to loop over an array, the common idiom is to use a `for` loop.

```
var daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                  "Saturday", "Sunday"];
for (var i = 0; i < daysOfWeek.length; i++) {
	console.log(daysOfWeek[i]);
}
```

In JavaScript 1.6, arrays get a forEach function. This is rarely used because it is not compatible with older browsers (e.g. IE6).

```
var daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                  "Saturday", "Sunday"];
daysOfWeek.forEach(function(x) { console.log(x) });
```

# Array Methods

## List insertion and removal:

Base: 
``` JavaScript
let arr = [1, 2, 3];
```

| Methods | Description                                                                                 | Command                     |
| ------- | ------------------------------------------------------------------------------------------- | --------------------------- |
| pop     | Removes the last element from an array and returns that element.                            | `console.log(arr.pop());`   |
| push    | Adds one or more elements to the end of an array and returns the new length of the array.   | `console.log(arry.push(4))` |
| shift   | Removes the first element from an array and returns that element.                           | `arr.shift();`              |
| unshift | Adds one or more elements to the front of an array and returns the new length of the array. | `arr.unshift(4)`            |

## Reordering elements:

Base: 
``` JavaScript
let primes = [5, 3, 7, 11, 2];
```

| Methods | Description                                                                                                  | Command                            |
| ------- | ------------------------------------------------------------------------------------------------------------ | ---------------------------------- |
| reverse | Reverses the order of the elements of an array – the first becomes the last, and the last becomes the first. | primes.reverse<br>[2, 11, 7, 3, 5] |
| sort    | Sorts the elements of an array.                                                                              | primes.sort()<br>[11, 2, 3, 5, 7]  |
| concat  | Returns a new array comprised of this array joined with other array(s) and/or value(s).                      |                                    |
| join    | Joins all elements of an array into a string.                                                                | primes.join()<br>'11,2,3,5,7'      |
| splice  | Adds and/or removes elements from an array.                                                                  | primes.splice()<br>[]              |
| slice   | Extracts a section of an array and returns a new array.                                                      |                                    |
