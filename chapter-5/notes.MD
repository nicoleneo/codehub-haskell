### Exercises: Type Matching
1.
a) `not` 2c) `not :: Bool -> Bool`
b) `length` 2d) ` _ :: [a] -> Int`
c) `concat` 2b) ` _ :: [[a]] -> [a]`
d) `head` 2a) `_ :: [a] -> a`
e) `(<)` 2e) `_ :: Ord a => a -> a -> Bool`

### Exercises: Type Arguments
1. a) `Char -> Char -> Char`
2. d) `Char`
3. d) `Num b => b`
4. c) `Double`
5. a) `[Char]`
6. e) `Eq b => b -> [Char]` because only the first param is provided
7. d) `(Num a, Ord a) => a` because `1` is not an `Ord`, the function has not been applied
8. a) `(Num a, Ord a) => a` because `1` is not an `Ord` and `(2 :: Integer)` is not a `Num`, the function has not been applied
9 c) `Integer`

### Exercises: Parametricity

### Exercises: Apply Yourself

## Chapter Exercises
### Multiple choice
1. c) a list whose elements are all of some type `a`
2. a) take a list of strings as an argument
3. b) returns one element of type 𝑎 from a list
4. c) takes a tuple argument and returns the first value

## Determine the type
1.
a) `54` `Num`
b) `(0, "doge")` `(a, Char)`
c) `(0, "doge")` `(Integer, [Char])`
d) `False` `Bool`
e) `5` `Int`
f) `False` `Bool`

2. `Num`
3.
```haskell
Prelude> :t z
z :: Num a => a -> a
```
4.
```haskell
Prelude> :t f
f :: Fractional a => a
```
5. `[Char]`

## Does it compile?
1. Doesn't compile
```haskell
Prelude> bigNum = (^) 5 $ 10
Prelude> wahoo = bigNum $ 10

<interactive>:82:1: error:
    • Non type-variable argument in the constraint: Num (t1 -> t2)
      (Use FlexibleContexts to permit this)
    • When checking the inferred type
        wahoo :: forall t1 t2. (Num (t1 -> t2), Num t1) => t2
Prelude> bigNum x = (^) x $ 10
Prelude> wahoo = bigNum $ 10
Prelude> wahoo  
```
2. Compiles.
```haskell
Prelude> x = print
Prelude> y = print "woohoo!"
Prelude> z = x "hello world"
Prelude> z
"hello world"
```
3. Does not compile
```haskell
Prelude> a = (+)
Prelude> b = 5
Prelude> c = b 10

<interactive>:132:1: error:
    • Non type-variable argument in the constraint: Num (t1 -> t2)
      (Use FlexibleContexts to permit this)
    • When checking the inferred type
        c :: forall t1 t2. (Num (t1 -> t2), Num t1) => t2
Prelude> d = c 200

<interactive>:133:1: error:
    • Non type-variable argument
        in the constraint: Num (t1 -> t2 -> t3)
      (Use FlexibleContexts to permit this)
    • When checking the inferred type
        d :: forall t2 t1 t3. (Num (t1 -> t2 -> t3), Num t1, Num t2) => t3
```
4. Need to rearrange for the dependencies
```haskell
Prelude> a = 12 + b

<interactive>:1:10: error: Variable not in scope: b
Prelude> b c = 10000 * c
Prelude> a b = 12 + b
```

## Type variable or specific type constructor?
1.
```haskell
f :: Num a => a -> b -> Int -> Int
--           [0]  [1]   [2]    [3]
[0] constrained polymorphic (Num)
[1] fully polymorphic
[2] concrete
[3] concrete
```
2.
```haskell
f :: zed -> Zed -> Blah
--          [0]     [1]
[0] concrete
[1] concrete
```
3.
```haskell
f :: Enum b => a -> b -> C
--             [0]  [1] [2]
[0] fully polymorphic
[1] constrained polymorphic (Enum)
[2] concrete
```

4.
```haskell
f :: f -> g -> C
--       [0]  [1]
[0] constrained polymorphic (function)
[1] concrete
```

### Write a type signature
1.
```haskell
Prelude> functionH (x:_) = x
Prelude> :t functionH
functionH :: [a] -> a
```
2.
```haskell
Prelude> functionC x y = if (x > y) then True else False
Prelude> :t functionC
functionC :: Ord a => a -> a -> Bool
```
3.
```haskell
Prelude> functionS (x, y) = y
Prelude> :t functionS
functionS :: (a, b) -> b
```

### Given a type, write the function
1.
```haskell
i :: a -> a
Prelude> i a = a
```
2.
```haskell
c :: a -> b -> a 
Prelude> c a b = a
```
3. Yes `c` and `c''` are the same
```haskell
c :: b -> a -> b 
Prelude> c'' b a = b
```
4.
```haskell
c' a b = b
Prelude> c' a b = b
```
5.
```haskell
r :: [a] -> [a]
Prelude> r [a] = (++) [a]
```