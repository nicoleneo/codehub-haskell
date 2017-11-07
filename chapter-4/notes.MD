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
4. 

