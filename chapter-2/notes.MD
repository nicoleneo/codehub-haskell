# Chapter 2
## Exercises: Comprehension Check
1.
```haskell
Prelude> let half x = x / 2
Prelude> half 4
2.0
```

```haskell
Prelude> let square x = x * x
Prelude> square 6
36
```

2.
```haskell
Prelude> let circumference r = 3.14 * (r * r)
Prelude> circumference 5
78.5
```

3.
```haskell
Prelude> let circumference r = pi * (r * r)
Prelude> circumference 5
78.53981633974483
```

## Infix operators
* Functions in Haskell default to prefix syntax.
* Operators are functions that can be used infix style (in the middle).
```haskell
Prelude> 100 + 100
200
Prelude> 768395 * 21356345
16410108716275
Prelude> 123123 / 123
1001.0
```
* Functions can be used infix style by enclosing the function name in backticks.
```haskell

Prelude> 10 `div` 4
2
Prelude> div 10 4
2
```
* Infix operators can be used prefix style by wrapping them in parantheses.
```haskell
Prelude> (+) 100 100
200
Prelude> (*) 768395 21356345
16410108716275
Prelude> (/) 123123 123
1001.0
```

## Associativity and precedence
* BODMAS rules for operator precedence apply.
* Typing `:info` into the console gives information about an operator or function.
```haskell
Prelude> :info (/)
class Num a => Fractional a where
  (/) :: a -> a -> a
  ...
    -- Defined in ‘GHC.Real’
infixl 7 /
```
    - `infixl` means it's an infix operator, left associative.
    - `7` means it's 7th in operator precedence. Higher ones applied first, on a scale of 0-9.
    - `/` is the name of the operator, division.
* Examples of right associative operators.
```haskell
 Prelude> :info (^)
 infixr  8   ^
```
    - `infixl` means it's an infix operator, right associative.
    - `7` means it's 8th in operator precedence. Higher ones applied first, on a scale of 0-9.
    - `^` is the name of the operator, exponentiation.
```haskell
Prelude> 2 ^ 3 ^ 4
2417851639229258349412352
Prelude> 2 ^ (3 ^ 4)
2417851639229258349412352
Prelude> (2 ^ 3) ^ 4
4096
```
* Right associative means it starts from the right.

### Exercises: Parantheses and association
1. Multiplication is evaluated before addition.
```
Prelude> 8 + 7 * 9
71
Prelude> (8 + 7) * 9
135
```
2. Multiplication is evaluated before addition so brackets won't change the result
```haskell
Prelude> perimeter x y = (x * 2) + (y * 2)
Prelude> perimeter 10 20
60
Prelude> perimeter x y = x * 2 + y * 2
Prelude> perimeter 10 20
60
```
3. Division is evaluated first before addition.
```haskell
Prelude> f x = x / 2 + 9
Prelude> f 4
11.0
Prelude> f x = x / (2 + 9)
Prelude> f 4
0.36363636363636365
```

## Exercises: Heal the Sick
1.
```haskell
Prelude> let area x = 3.14 * (x * x)
Prelude> area 6
113.04
```
2.
```haskell
Prelude> let double x = b * 2

<interactive>:30:16: error: Variable not in scope: b
Prelude> let double x = x * 2
Prelude> double 9
18
```

3.
```haskell
x = 7
y = 10
f = x + y
```

## Arithmetic functions in Haskell

| Operator | Name | Purpose/Application |
|----------|------|---------------------|
| + | plus | addition |
| - | minus | subtraction |
| * |asterisk | multiplication |
| / | slash | fractional division |
| div | divide | integral division, round down |
| mod | modulo | like ‘rem’, but after modular division |
| quot | quotient | integral division, round towards zero |
| rem | remainder |remainder after division |

* Modulo does a wraparound for the remainders.
- Generally, `rem` and `mod` give the same number for positive values.
- E.g. To determine which day of the week it is `n` days from a given day. Using a scale of `0` to `6` where `0` is Sunday and `6` is Saturday. Using mod to wrap it around the 7 means it will return a number that corresponds to a day of the week in our numbering. And 5 days from Saturday will be Thursday:

```haskell
Prelude> mod (6 + 5) 7
4
Prelude> rem (1 + 23) 7
3

```
- However, if we want to subtract and find out what day of the week it was some number of days ago, then we’ll see a difference. Let’s try asking, if today is Wednesday (3), what day it was 12 days ago:
```haskell
Prelude> mod (3 - 12) 7
5
Prelude> rem (3 - 12) 7
-2
```
- `rem` gives the wrong answer for negative values since it doesn't wrap around.

## Parenthesisation
* The `$` operator allows operators to be done without parameterisation.
```haskell
Prelude> :info $
($) ::
  forall (r :: GHC.Types.RuntimeRep) a (b :: TYPE r).
  (a -> b) -> a -> b
    -- Defined in ‘GHC.Base’
infixr 0 $
```
* E.g. using the `$` instead of an extra pair of parentheses.
```
 Prelude> (2^) (2 + 2)
16
-- can replace those parentheses
 Prelude> (2^) $ 2 + 2
16
-- without either parentheses or $
 Prelude> (2^) 2 + 2
 6
```

## Parenthesising infix operations
* `(+)` is the addition infix function without any arguments applied yet and `(+1)` is the same addition function but with one argument applied, making it return the next argument it's applied to plus one.
```haskell
Prelude> 1 + 2
3
Prelude> (+) 1 2
3
Prelude> (+1) 2
3
Prelude> (1+) 2
3
```
* The last case is known as sectioning and allows you to pass around `partially applied functions`. With commutative functions, such as addition, it makes no difference if you use `(+1)` or `(1+)` because the order of the arguments won’t change the result. E.g. `2 + 1` and `1 + 2` are commutative.
* If you use sectioning with a function that is not commutative, the order matters:
```haskell
Prelude> (1/) 2
0.5
Prelude> (/1) 2
2.0
```
* Subtraction, (-), is a special case. These will work:
```haskell
Prelude> 2 - 1
1
Prelude> (-) 2 1
1
Prelude> (1-) 4
-3
```
* The following, however, won’t work: `-2` is a negation function. Here, `-` is a case of syntactic overloading disambiguated by how it is used. Use `subtract` instead to avoid ambiguity.
```haskell
Prelude> (-2) 1
Prelude> (subtract 2) 3
1
```

## Let and where
* You will often see `let` and `where` used to introduce components of expressions, and they seem similar. It takes some practice to get used to the appropriate times to use each, but they are fundamentally different.
* The contrast here is that `let` introduces an expression, so it can be used wherever you can have an expression, but `where` is a declaration and is bound to a surrounding syntactic construct.
* `where` gives the function first, then the variables
```haskell
module FunctionWithWhere where
printInc n = print plusTwo
 where plusTwo = n + 2
```
* `let` defines the variables first before the function
```haskell
printInc2 n = let plusTwo = n + 2
    in print plusTwo
```

### Exercises: A Head Code
```haskell
Prelude> let x = 5 in x
5
Prelude> let x = 5 in x * x
25
Prelude> let x = 5; y = 6 in x * y
30
Prelude> let x = 3; y = 1000 in x + 3
6
```

## Chapter Exercises
### Parenthesisation
1. `2 + 2 * 3 - 1` `2 + (2 * 3) - 1`
2. `(^) 10 $ 1 + 1` `(^) 10 (1 + 1)`
3. `2 ^ 2 * 4 ^ 5 + 1` `(2 ^ 2) * (4 ^ 5) + 1`

### Equivalent Expressions
1. `1 + 1` 
`2` Yes
2. `10 ^ 2`
`10 + 9 * 10` Yes
3. `400 - 37` 
`(-) 37 400` No, because they are not commutative
4. `100 `div` 3` 
`100 / 3` No, because div returns the quotient only
5. `2 * 5 + 18`
`2 * (5 + 18)` No, because of operator precedence

### More fun with functions
In the ghci prompt, vars are defined with the dependencies *before* and in the source file, the dependencies are defined *after*.
```haskell
Prelude> let z = 7
Prelude> let y = z + 8
Prelude> let x = y ^ 2
Prelude> let waxOn = x * 5
```
1. 
```haskell
Prelude> 10 + waxOn
1135
Prelude> (+10) waxOn
1135
Prelude> (-) 15 waxOn
-1110
Prelude> (-) waxOn 15
1110
```
2.
```haskell
Prelude> let triple x = x * 3
```

3. The result of `waxOn` is tripled.
```haskell
Prelude> waxOn
1125
Prelude> triple waxOn
3375
```

4. See file `exercises/more-fun-with-functions/practice_4.hs`
5. See file `exercises/more-fun-with-functions/practice_5.hs`
6. See file `exercises/more-fun-with-functions/practice_6.hs`
7. See file `exercises/more-fun-with-functions/practice_7.hs`

