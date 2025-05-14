> An algorithm is a set of instructions that a computer executes to perform a specific task

In data structures, there are many types of structures. In this topic, we’ll talk about **Binary Search** and **Simple (or Linear) Search**. In these cases, their respective time complexities are **O(log n)** for Binary Search and **O(n)** for Simple Search.

# Linear Search
Linear Search is one of the most basic methods in data structures. It works by checking each element in the list one by one until it finds the correct value. In the worst case, it has to check all **N** elements, which makes it slower as the list grows.

![[LinearSearch IMG.png]]

![[LinearSearch CODE.png]]

Result: Index 19 = 20
# Binary Search
> **Binary Search is an efficient way to find a value in a sorted list, using the concept of logarithmic time (log₂ n) to minimize the number of steps.**

How does it work? In a sorted list with **n** elements, the algorithm divides the list in half and checks whether the target value is to the left or right of the middle element. Based on this, it eliminates half of the list and repeats the process until the value is found or determined to be absent. This greatly reduces the number of comparisons, especially in large datasets.
![[BinarySearch IMG.png]]
![[BinarySearch CODE.png]]

![[BinarySearch RESULT.png]]


