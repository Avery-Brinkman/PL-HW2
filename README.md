# Assignment 2: Don't Haskell Me!

## Introduction

[Haskell](https://www.haskell.org/) is one of a few statically typed, pure functional programming languages in widespread use. [Even Facebook uses it!](https://www.youtube.com/watch?v=sl2zo7tzrO8) In Assignment 2 you will get an opportunity to practice programming in the functional paradigm using this interesting language. Your assignment is to implement four different functions:

1. `findFirst`
2. `palindrome`
3. `mergesort`
4. `runLengthEncode`

The Programming Task section gives an informal description of how the functions operate and several examples to get you warmed up. The Functional Specifications section describes, in detail, the data structures and function signatures for each of the functions. The Getting Started section describes the mechanics of actually writing the code.

Good luck and have fun!

## Programming Task

Your task is to implement the `findFirst`, `palindrome`, `mergesort` and `runLengthEncode` functions.

### findFirst

`findFirst` is a higher-order function that takes two parameters

1. a "needle" function that defines the "find" semantics, and
2. a "haystack" list

and returns a data structure whose value is either

1. the index of the "needle" in "haystack", or
2. a special sentinel value indicating that the "haystack" did not contain the "needle".

Let's look at an example for clarification. Assume that there is a function, `equals1`, that accepts an integer value as a parameter that returns `True` when that value is 1 and `False`. Furthermore, assume that there is a list, `haystack`, with the values [0, 4, 5, 1, 7]. Then

`findFirst equals1 haystack`

will evaluate to 3 because 1 is at index 3 in `haystack`. Using `haystack` again,

`findFirst (\x -> x == 4) haystack`

will evaluate to 1 because 4 is at index 1 in `haystack`. On the other hand,

`findFirst (\x -> x == 9) haystack`

will evaluate to the sentinel value because 9 is not an element in `haystack`.

### palindrome

`palindrome` is a function that takes a string (a list of characters) and returns true if the string is a palindrome (Links to an external site.) and false otherwise. A [palindrome](https://en.wikipedia.org/wiki/Palindrome) is a string that is the same forward and backward. "Never odd or even" is a palindrome. "Madam, I'm Adam" is a palindrome. "Will is awesome" is not a palindrome, but still true.

### mergesort

`mergesort` is a higher-order function that takes two parameters

1. a comparison function that determines the relative order of a pair of elements, and
2. a list

and returns the list sorted according to the comparison function using the [mergesort algorithm](https://en.wikipedia.org/wiki/Merge_sort). For example,

`mergesort (\x y -> x < y) [10,4,5,4,4,3,1]`

evaluates to

`[1,3,4,4,4,5,10]`

whereas

`mergesort (\x y -> x > y) [10,4,5,4,4,3,1]`

evaluates to

`[10,5,4,4,4,3,1]`

### runLengthEncode

`runLengthEncode` is a function that performs a [run-length encoding](https://en.wikipedia.org/wiki/Run-length_encoding) on a string. Run-length encoding is an algorithm that compresses a sequence of n identical values v into a simple pair (_n_, _v_). For instance, "aaaaaaa" is run-length encoded as (7, 'a'). Run-length encoding is used on data where sequences of the same values are common, especially images. [It was used as long ago as 1967 to compress analog television signals](https://ieeexplore-ieee-org.uc.idm.oclc.org/document/1447423).

The input to the `runLengthEncode` function is a string and the output of the function is a list of instances of a _span_, a data structure that holds a length and a value. For instance,

`runLengthEncode "aabbccaa"`

evaluates to

`[ <span of 2 as>, <span of 2 bs>, <span of 2 cs>, <span of 2 as>]`

See below for information on the exact definition of data structure to be used to represent spans.

## Specifications

### Functional

In the table below you will find the exact specifications for the functions you will implement in this assignment:

| Name              | Parameters                                                                                                                                                                                                                                                                                                   | Return Value                                                                                                                                                                                                | Description/Other                                                                                                                                                |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `findFirst`       | <ol><li>A function, _needle_, with one parameter of type _a_ that returns `True` if its argument is the item to find and `False` otherwise: `(a -> Bool)`</li><li>A list, _haystack_, of elements of type _a_.</li></ol>                                                                                     | A `Match` which contains the index of the first element (in left-to-right order) of _haystack_ that causes _needle_ to return `True`; `NoMatch` if no element of haystack causes _needle_ to return `True`. | `findFirst` returns `NoMatch` when _haystack_ is an empty list.                                                                                                  |
| `palindrome`      | A string, _candidate_.                                                                                                                                                                                                                                                                                       | True if _candidate_ is a palindrome; False, otherwise.                                                                                                                                                      | The empty string is a palindrome. Strings will contain only lowercase letters.                                                                                   |
| `mergesort`       | <ol><li>An ordering function, _comparator_, that takes two parameters, _left_ and _right_ both of type _a_, and returns `True` if _left_ should appear before _right_ in the final sorted list and `False` otherwise: `(a -> a -> Bool)`</li><li>A list, _to_sort_, of elements of tpye _a_: `[a]`</li></ol> | A list of elements of type _a_ sorted according to the _comparator_ ordering function using the mergesort algorithm: `[a]`                                                                                  |                                                                                                                                                                  |
| `runLengthEncode` | A string, _to_encode_.                                                                                                                                                                                                                                                                                       | A list of elements of type `RunLength` that represent the run-length encoding of _to_encode_: `[RunLength]`                                                                                                 | The run-length encoding of an empty string a list that contains no `RunLength`s. Strings to encode will contain only lower case letters but may contain numbers. |

### Data

The `Found` data type is the return value for the `findFirst` function. It has two variants/constructors: `Match` and `NoMatch`. The Match constructor takes a parameter that indicates at which index the match was found.

`findFirst (\x -> x == 1) [0, 2, 3, 1]`

evaluates to

`(Match 3)`

while

`findFirst (\x -> x == 7) [0, 2, 3, 1]`

evaluates to

`NoMatch`

The `RunLength` data type is the type of the elements of the list returned by the `runLengthEncode` function. Each entry in the list returned by `runLengthEncode` will be an instance of this type. The `Span` constructor creates a `RunLength` and takes two parameters: the length of the run and the value being encoded.

`runLengthEncode "aabbccdd"`

evaluates to

`[ (Span 2 'a'), (Span 2 'b'), (Span 2 'c'), (Span 2 'd') ]`

## Getting Started

To begin this assignment, make sure that you have a working installation of Haskell:

-   [Linux](https://www.haskell.org/downloads/) (and click on "Show linux distros")
-   Windows
-   Mac

Next, download the skeleton code from github:

`git clone https://github.com/hawkinsw/CS3003-Assignment2`

### Files

There are several files in the repository that you will want to explore:

#### src/Assignment2.hs

This file is the place where you will implement the functions specified above.

It also contains definitions and constructors for data types that you will you need to use to successfully complete this assignment.

#### src/Main.hs

This file contains unit tests that you can use to verify that your implementations are operating according to specification. There is no need to change any code in this file.

### Testing/Debugging

Haskell has a built-in REPL for testing/debugging. From the command line, you can run

`cabal new-repl`

from the directory that contains the `CS3003-Assignment2.cabal` file. If your code compiles, you will get a prompt that looks like

`\*Assignment2>`

at the prompt you can invoke the functions that you have defined and check whether their output is what you expect. There is plenty of documentation for the REPL available [online](https://downloads.haskell.org/~ghc/9.0.1/docs/html/users_guide/ghci.html).

To test whether your code passes all the unit tests, you can run

`cabal new-run`

and you should see

`Pass`

printed 27 times.

## Submission Requirement and Grading Rubric

This assignment is worth 100 points. There are 27 unit tests and you will receive 3.7 points for every passing test. All submissions must be done through Gradescope. Gradescope submissions must be named `Assignment2.hs` or they will not be autograded. Gradescope will score your submission "all or nothing". I will manually grade submissions that partially succeed -- don't worry!
