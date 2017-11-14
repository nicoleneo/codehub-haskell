# Chapter 4: Basic Datatypes
## Data declaration
```haskell
-- the definition of Bool
data Bool = False | True
--    [1]    [2] [3] [4]
```

1. Type constructor for datatype `Bool`. This is the name of the type and shows up in type signatures.
2. Data constructor for the value `False`.
3. Pipe | indicates a *sum type* or logical disjunction: "or". So, a `Bool`
value is `True` *or* `False`.
4. Data constructor for the value `True`.

* The whole thing is called a data declaration. Data declarations do not always follow precisely the same pattern – there are datatypes that use logical conjunction ("and") instead of disjunction, and some type constructors and data constructors may have arguments. 
* The thing they have in common is the keyword data followed by the type constructor (or name of the type that will appear in type signatures), the equals sign to denote a definition, and then data constructors (or names of values that inhabit your term-level code).

## Exercises: Mood Swing
```haskell
data Mood = Blah | Woot deriving Show
```
1. The constructor is `Mood`.
2. `Blah` or `Woot deriving Slow` are values that are valid.
3. `changeMood :: Mood -> Woot` The return type should be a `Mood`.
4. See file `changeMood.hs`. `_` is a **catch-all** for all other inputs.
```haskell
Prelude> :l changeMood.hs 
[1 of 1] Compiling Main             ( changeMood.hs, interpreted )
Ok, 1 module loaded.
*Main> changeMood Blah
Woot
*Main> changeMood Woot
Blah
```
5. See above.

## Numeric types
### Integral numbers (integers)
Whole numbers, positive or negative.
1. `Int` fixed-precision integer. It has a range, with a min and max so cannot be arbitrarily large or small.
2. `Integer` integers that supports arbitrarily large (or small) numbers.

### Fractional
1. `Float` single-precision floating point numbers. Fixed-point number representations have immutable numbers of digits assigned for the parts of the number before and after the decimal point. In contrast, floating point can shi  how many bits it uses to represent numbers before or a er the decimal point. This  exibility does, however, mean that  oating point arithmetic violates some common assumptions and should only be used with great care. Generally, **floating point numbers should not be used at all in business applications**.
2. `Double` double-precision floating point. Twice as many bits as a Float.
3. `Rational` a fractional number that represents a *ratio* of two integers. The value `1 / 2 :: Rational` will be a value carrying two `Integer` values, the numerator `1` and denominator `2`, representing a ratio of `1` to `2`. Rational is arbitrarily precise but not as efficient as scientific.


### Exercises: Find the mistakes
1.
```haskell
Prelude> not True && true

<interactive>:1:13: error:
    • Variable not in scope: true :: Bool
    • Perhaps you meant data constructor ‘True’ (imported from Prelude)
Prelude> not True && True
False
```
2. 
```haskell
Prelude> not (x == 6)

<interactive>:4:6: error: Variable not in scope: x :: Integer
Prelude> x = 7
Prelude> not (x == 6)
True
```
3. `(1 * 2) > 5` no mistakes
4.
```haskell
Prelude> [Merry] > [Happy]

<interactive>:8:2: error:
    Data constructor not in scope: Merry :: ()

<interactive>:8:12: error:
    Data constructor not in scope: Happy :: ()
Prelude> ["Merry"] > ["Happy"]
True
```
5.
```haskell
Prelude> [1, 2, 3] ++ "look at me!"

<interactive>:10:2: error:
    • No instance for (Num Char) arising from the literal ‘1’
    • In the expression: 1
      In the first argument of ‘(++)’, namely ‘[1, 2, 3]’
      In the expression: [1, 2, 3] ++ "look at me!"
Prelude> ["1, 2, 3"] ++ ["look at me!"]
["1, 2, 3","look at me!"]
```

## Conditionals with if-then-else
* Haskell doesn't have "if" statements but it does have *if expressions*. It's a built-in bit of syntax that works with the Bool datatype.
```haskell
Prelude> :l greetIfCool1.hs 
[1 of 1] Compiling GreetIfCool1     ( greetIfCool1.hs, interpreted )
Ok, 1 module loaded.
*GreetIfCool1> greetIfCool "downright frosty yo"
eyyyyy. What's shakin'?
*GreetIfCool1> greetIfCool "please love me"
pshhhh.
```

## Tuples
* Tuples are a type allowing you to store and pass around multiple values within a single value. 
* Tuples are named after the number `n` (also known as its arity) of constituents in them e.g. two-tuple/pair has two values (x, y), the three-tuple/triple has three (x, y, z) and so on.
* Tuples can contain values of different types and need to have at least two elements (otherwise it's not a tuple!).
```haskell
Prelude> set prompt "λ> "
λ> (,) 8 10
(8,10)
λ> (,) 8 "Julie"
(8,"Julie")
λ> (,) True 'c'
(True,'c')
λ> (,) 9

<interactive>:29:1: error:
    • No instance for (Show (b0 -> (Integer, b0)))
        arising from a use of ‘print’
        (maybe you haven't applied a function to enough arguments?)
    • In a stmt of an interactive GHCi command: print it
```
* The two-tuple in Haskell has some default convenience functions for getting the first (`fst`) or second (`snd`) value.
```haskell
fst :: (a, b) -> a
snd :: (a, b) -> b
```
* Manipulating tuples, specifically the two-tuple: We had to import Data.Tuple because `swap` isn’t included in the Prelude.
```haskell
Prelude> let myTup = (1 :: Integer, "blah")
Prelude> :t myTup
myTup :: (Integer, [Char])
Prelude> fst myTup
1
Prelude> snd myTup
"blah"
Prelude> import Data.Tuple
Prelude Data.Tuple> swap myTup
("blah",1)
```
* Tuples can also be combined with other expressions.
```haskell
Prelude> 2 + fst (1, 2)
3
Prelude> 2 + snd (1, 2)
4
```
* The `(x, y)` syntax of the tuple is special.  The constructors you use in the type signatures and in your code (terms) are syntactically identical even though they're different things. Sometimes that type constructor is referred to without the type variables explicitly inside of it such as `(,)` (prefix). Other times, you’ll see `(a, b)` (infix) – particularly in type signatures.
* You can use that syntax to *pattern match*.
* It's generally unwise to use overly large tuples, both for efficiency and sanity reasons. Most tuples used will be `( , , , , )` or smaller.

## Lists
* Lists in Haskell are another type used to contain multiple values within a single value.
* However, they differ from tuples in three important ways:
    1. All constituents of a list must be of the **same type**. 
    2. Lists have their own distinct `[]` syntax. Like the tuple syntax, it is used for both the type constructor in type signatures and at the term level to express list values. 
    3. The number of constituents within a list can change as you operate on the list, unlike tuples where the arity is set in the type and immutable.
```
Prelude> let awesome = ["Papuchon", "curry", ":)"]
Prelude> awesome
["Papuchon","curry",":)"]
Prelude> :t awesome
awesome :: [[Char]]
```
* `awesome` is a list of lists of `Char` values because it is a list of strings, and a string is itself just a type *alias* for `[Char]`.
* This means all the functions and operations valid for lists of any value, usually expressed as `[a]`, are valid for String because `[Char]` is more specific than `[a]`.

```haskell
Prelude> let awesome = ["Papuchon", "curry", ":)"]
Prelude> awesome
["Papuchon","curry",":)"]
Prelude> :t awesome
awesome :: [[Char]]
Prelude> let alsoAwesome = ["Quake", "The Simons"]
Prelude> :t (++)
(++) :: [a] -> [a] -> [a]
Prelude> let allAwesome = [awesome, alsoAwesome]
Prelude> allAwesome
[["Papuchon","curry",":)"],["Quake","The Simons"]]
Prelude> :t allAwesome
allAwesome :: [[[Char]]]
Prelude> :t concat
concat :: Foldable t => t [a] -> [a]
Prelude> concat allAwesome
["Papuchon","curry",":)","Quake","The Simons"]
```

## Chapter Exercises
1.
```haskell
Prelude> :t length
length :: Foldable t => t a -> Int
```
2.
    a) 5
    b) 3
    c) 2
    d) 5
3.
```haskell
Prelude> 6 / 3
2.0
Prelude> 6 / length [1, 2, 3]

<interactive>:56:1: error:
    • No instance for (Fractional Int) arising from a use of ‘/’
    • In the expression: 6 / length [1, 2, 3]
      In an equation for ‘it’: it = 6 / length [1, 2, 3]
```
4.
```haskell
Prelude> 6 `div` length [1, 2, 3]
2
```
5. Bool, `True`
```haskell
Prelude> 2 + 3 == 5
True
```
6.
```haskell
Prelude> let x = 5
Prelude> :t x
x :: Num p => p
Prelude> x + 3 == 5
False
Prelude> :t x + 3 == 5
x + 3 == 5 :: Bool
```
7.
Lists can only contain one type. Use tuples if using mixed types.
9 is an Int, and the `&&` operation cannot be applied to it.
```haskell
Prelude> length allAwesome == 2
True
Prelude> length [1, 'a', 3, 'b']

<interactive>:67:9: error:
    • No instance for (Num Char) arising from the literal ‘1’
    • In the expression: 1
      In the first argument of ‘length’, namely ‘[1, 'a', 3, 'b']’
      In the expression: length [1, 'a', 3, 'b']
Prelude> length allAwesome + length awesome
5
Prelude> (9 == 8) && ('b' < 'a')
False
Prelude> (8 == 8) && 9

<interactive>:70:13: error:
    • No instance for (Num Bool) arising from the literal ‘9’
    • In the second argument of ‘(&&)’, namely ‘9’
      In the expression: (8 == 8) && 9
      In an equation for ‘it’: it = (8 == 8) && 9
```
8. See file `exercises/isPalindrome.hs`
```haskell
Prelude> :l isPalindrome.hs 
[1 of 1] Compiling IsPalindrome     ( isPalindrome.hs, interpreted )
Ok, 1 module loaded.
*IsPalindrome> isPalindrome "racecar"
True
```
9. See file `exercises/absoluteValue.hs`
```haskell
Prelude> :l absoluteValue.hs 
[1 of 1] Compiling AbsoluteValue    ( absoluteValue.hs, interpreted )
Ok, 1 module loaded.
*AbsoluteValue> myAbs 983.6

<interactive>:2:7: error:
    • No instance for (Fractional Integer)
        arising from the literal ‘983.6’
    • In the first argument of ‘myAbs’, namely ‘983.6’
      In the expression: myAbs 983.6
      In an equation for ‘it’: it = myAbs 983.6
*AbsoluteValue> myAbs 983
983
```
10. See file `exercises/combine.hs`
```haskell
Prelude> :l combine.hs 
[1 of 1] Compiling Combine          ( combine.hs, interpreted )
Ok, 1 module loaded.
*Combine> f (1, 2) (3, 4)
((2,4),(1,3))
```

### Correcting syntax
1. See file `exercises/correcting-syntax/practice1.hs`
```haskell
Prelude> :l practice1.hs 
[1 of 1] Compiling Practice1        ( practice1.hs, interpreted )
Ok, 1 module loaded.
*Practice1> f "aaa"
4
```
2.
```haskell
Prelude> \ X = x

<interactive>:27:5: error:
    parse error on input ‘=’
    Perhaps you need a 'let' in a 'do' block?
    e.g. 'let x = 5' instead of 'x = 5'
Prelude> (\x -> x) 2
2
```
3.
```haskell
Prelude> \ x : xs -> x

<interactive>:39:5: error: parse error on input ‘:’
Prelude> (\(x : xs) -> x) [1, 2, 3]
1
```
4.
```haskell
Prelude> f (a b) = A

<interactive>:52:4: error: Parse error in pattern: a
Prelude> f (a, b) = fst (a, b)
Prelude> f (a, b) = a
Prelude> f (4884, 123)
4884
```

### Match the function names to their types
```haskell
Prelude> :t show
show :: Show a => a -> String
Prelude> :t (==)
(==) :: Eq a => a -> a -> Bool
Prelude> :t fst
fst :: (a, b) -> a
Prelude> :t (+)
(+) :: Num a => a -> a -> a
```
1. c)
2. b)
3. a)
4. d)
