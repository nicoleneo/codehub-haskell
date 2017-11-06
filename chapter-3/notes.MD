# Chapter 3: Strings
## Types
* Characters use a single quote and Strings use double quotes. The square brackets denote a list as a string is a list of Chars. String is a synonym for `Char[]`.
* `::` means 'has the type'
```haskell
Prelude> :type 'a'
'a' :: Char
Prelude> :type 'hello'

<interactive>:1:1: error:
    • Syntax error on 'hello'
      Perhaps you intended to use TemplateHaskell or TemplateHaskellQuotes
    • In the Template Haskell quotation 'hello'
Prelude> :type "Hello!"
"Hello!" :: [Char]
```

## Printing strings
* `putStrLn` will print a newline after the string but `putStr` doesn't (the prompt continues immediately after "hello world!". 
```haskell
Prelude> putStrLn "hello world!"
hello world!
Prelude>
Prelude> putStr "hello world!"
hello world!Prelude>
```
* Try `print1.hs`. `:m` unloads the module.
```haskell
Prelude> :l print1.hs 
[1 of 1] Compiling Print1           ( print1.hs, interpreted )
Ok, 1 module loaded.
*Print1> main
hello world!
*Print1> :m
Prelude>
```
* The prompt can also be changed by giving `Prelude> :set prompt "λ> "`.
* Loading `print2.hs`
```haskell
λ> :l print2.hs 
[1 of 1] Compiling Print2           ( print2.hs, interpreted )
Ok, 1 module loaded.
λ> main
Count to four for me:
one, two, three, and four!
λ> 
```

## Concatenation
* `var1 ++ var2` and `concat [hello, " ", world]` do concatenation. `concat` accepts a list of strings to concat as its arguments. `practice3.hs`
```haskell
Prelude> :l print3.hs 
[1 of 1] Compiling Print3           ( print3.hs, interpreted )
Ok, 1 module loaded.
*Print3> main
hello world!
hello world!
```

## Top-level vs. local definitions
* Top-level definitions (global) are not nested within anything else and are in scope throughout the whole module.
* Local definitions are nested within some expression or loop and are not visible outside the expression. 
```haskell
Prelude> :l TopOrLocal.hs 
[1 of 1] Compiling TopOrLocal       ( toporlocal.hs, interpreted )
Ok, 1 module loaded.
*TopOrLocal> topLevel
topLevelFunction  topLevelValue
*TopOrLocal> topLevel
topLevelFunction  topLevelValue
*TopOrLocal> topLevelFunction 80
95
*TopOrLocal> topLevelValue 
5
```

### Exercises: Scope
1. Yes, `y` is in scope for `z`
```haskell
Prelude> let x = 5
Prelude> let y = 7
Prelude> let z = x * y
```

2. `h` is not in scope for `g`
```haskell
Prelude> let f = 3
Prelude> let g = 6 * f + h
```

3. `d` is not in scope.
```haskell
area d = pi * (r * r) 
r = d / 2
```

4. `d` is in scope as it was provided in the `where` statement.
```haskell
area d = pi * (r * r)
  where r = d / 2
```

## Types of concatenation functions
* `++` is an infix operator and needs to be wrapped in parenthesis when used in a prefix position.
```haskell
Prelude> "hello" ++ "world"
"helloworld"
Prelude> (++) "hello" "world"
"helloworld"
```
* `concat` is a normal (prefix) function so it doesn't need ot be wrapped.
* `concat` accepts a list of lists (`String`s) as input and will return a list (`String`) thus flattening into one list structure. A `String` is a list of `Char`.
* Thus `concat` can also work for lists of other things.
```haskell
Prelude> concat [[1, 2], [3, 4, 5], [6, 7]]
[1,2,3,4,5,6,7]
Prelude> concat ["Iowa", "Melman", "Django"]
"IowaMelmanDjango"
 ```
* Concatenation of different types doesn't work.
```haskell
Prelude> "hello" ++ " Chris"
"hello Chris"
Prelude> "hello" ++ [1, 2, 3]

<interactive>:26:13: error:
    • No instance for (Num Char) arising from the literal ‘1’
    • In the expression: 1
      In the second argument of ‘(++)’, namely ‘[1, 2, 3]’
      In the expression: "hello" ++ [1, 2, 3]
```

### Exercises: Syntax errors
1. `++` is an infix operator and needs to be wrapped in paranthesis to be a prefix operator.
```haskell
Prelude> ++ [1, 2, 3] [4, 5, 6]

<interactive>:27:1: error: parse error on input ‘++’
Prelude> (++) [1, 2, 3] [4, 5, 6]
[1,2,3,4,5,6]
```
2. Strings need to be wrapped in double quotes.
```haskell
Prelude> '<3' ++ ' Haskell'
<interactive>:29:2: error: parse error on input ‘<’
Prelude> "<3" ++ " Haskell"
"<3 Haskell"
```

3.
```haskell
Prelude> concat ["<3", " Haskell"]
"<3 Haskell"
```

## Concatenation and scoping
```haskell
Prelude> :l print3flipped.hs 
[1 of 1] Compiling Print3Flipped    ( print3flipped.hs, interpreted )
Ok, 1 module loaded.
*Print3Flipped> main
hello world!
hello world!
```

* File `print3broken.hs`
```haskell
Prelude> :l print3broken.hs 
[1 of 1] Compiling Print3Broken     ( print3broken.hs, interpreted )
Ok, 1 module loaded.
*Print3Broken> main
Yarrrrr
Yarrrrr
```

## More list functions
* `'c'` is a `Char` and `"c"` is a `[Char]` or `String`.
```haskell
Prelude> :t 'c'
'c' :: Char
Prelude> :t "c"
"c" :: [Char] -- List of Char is String, same thing.
```
* The `:` operator called *cons*, builds a list.
```haskell
Prelude> 'c' : "hris"
"chris"
Prelude> 'P' : ""
"P"
```
* `head` returns the head (first element)
```haskell
Prelude> head "Papuchon"
'P'
```
* `tail` returns the list with the head chopped off.
```haskell
Prelude> tail "Papuchon"
"apuchon"
```
* `take` returns the specified number of elements from the list, starting from the left.
```haskell
Prelude> take 1 "Papuchon"
"P"
Prelude> take 0 "Papuchon"
""
Prelude> take 6 "Papuchon"
"Papuch"
```
* `drop` returns the remainder of the list after the specified number of elements has been dropped.
```haskell
Prelude> drop 4 "Papuchon"
"chon"
Prelude> drop 9001 "Papuchon"
""
Prelude> drop 1 "Papuchon"
"apuchon"
```
* `!!` (infix) returns the element that is in the specified index a.k.a. get.
```haskell
Prelude> "Papuchon" !! 0
'P'
Prelude> "Papuchon" !! 4
'c'
```

## Chapter Exercises
### Reading syntax
1.
    a) 
    ```haskell
    Prelude> concat [[1, 2, 3], [4, 5, 6]]
    [1,2,3,4,5,6]
    ```
    b)
    ```haskell
    Prelude> ++ [1, 2, 3] [4, 5, 6]

    <interactive>:81:1: error: parse error on input ‘++’
    Prelude> (++) [1, 2, 3] [4, 5, 6]
    [1,2,3,4,5,6]
    ```
    c) 
    ```haskell
    Prelude> (++) "hello" " world"
    "hello world"
    ```
    d) Wraps the string in a list
    ```haskell
    Prelude> ["hello" ++ " world]

    <interactive>:84:21: error:
        lexical error in string/character literal at end of input
    Prelude> ["hello" ++ " world"]
    ["hello world"]
    ```
    e) 
    ```haskell
    Prelude> 4 !! "hello"

    <interactive>:86:6: error:
        • Couldn't match expected type ‘Int’ with actual type ‘[Char]’
        • In the second argument of ‘(!!)’, namely ‘"hello"’
          In the expression: 4 !! "hello"
          In an equation for ‘it’: it = 4 !! "hello"
    Prelude> "hello" !! 4
    'o'
    ```
    f)
    ```haskell
    Prelude> (!!) "hello" 4
    'o'
    ```
    g)
    ```haskell
    Prelude> take "4 lovely"

    <interactive>:89:6: error:
        • Couldn't match expected type ‘Int’ with actual type ‘[Char]’
        • In the first argument of ‘take’, namely ‘"4 lovely"’
          In the expression: take "4 lovely"
          In an equation for ‘it’: it = take "4 lovely"
    Prelude> take 4 "lovely"
    "love"
    ```
    h)
    ```haskell
    Prelude> take 3 "awesome"
    "awe"
    ```

2.
    a) `concat [[1 * 6], [2 * 6], [3 * 6]]` gives a) `[6,12,18]`
    b) `"rain" ++ drop 2 "elbow"` gives c) `"rainbow"`
    c) `10 * head [1, 2, 3]` gives e) `10`
    d) `(take 3 "Julie") ++ (tail "yes")` gives a) `"Jules"`
    e) 
    ```haskell
     concat [tail [1, 2, 3],
             tail [4, 5, 6],
             tail [7, 8, 9]]
     ```
     gives b) `[2,3,5,6,8,9]`