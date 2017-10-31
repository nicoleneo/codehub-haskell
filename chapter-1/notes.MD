hapter 1
## What is functional programming?
* In functional programming, functions are *first-class*: they can be used as values or passed as arguments, or inputs, to yet more functions.
* The essence of functional programming is that programs are a combination of expressions. Expressions include concrete values, variables, and also functions. Functions have a more specific definition: they are expressions that are applied to an argument or input, and once applied, can be reduced or evaluated.
* Haskell is a *pure* functional language because it does not include language features that aren’t translatable into lambda expressions.
* The word purity in functional programming is sometimes also used to mean what is more properly called referential transparency. Referential transparency means that the *same function*, given the *same values* to evaluate, *will always return the same result* in pure functional programming, as they do in math.

## What is a function?
* A function is a relation between a set of possible inputs and a set of possible outputs.
$$f(1) = A \\
f(2) = B \\
 f(3) = C$$
 
* The input set (**domain**) is $\{1, 2, 3\}$ and the output set is $\{A, B, C\}$. A crucial point about how these relations are defined: our hypothetical function will always return the value $A$ given the input $1$ – no exceptions!
* A set of *unique* values that are possible outputs for the function is called the **codomain**. The set of *all* possible outputs related to different inputs is the **range**.  All domains and codomains are sets of unique values. Ranges are sets of values, but the values in range sets need not be unique, and in practice very often are *not unique*; that is, the *same value* can *appear multiple times* in that set. Every value in a range must be a member of the function's codomain.
* The following is not a valid function i.e. the same input must always return the same output.
$$
f(1) = X \\
f(1) = Y \\
 f(2) = Z
 $$
 
 * The following function is valid because different inputs can give the same output. E.g. a function testing whether a  `value < 10`. It will return `True` if  `value < 10` and `False` for all other cases. **Different inputs can lead to the same output.** 
 $$
 f(1) = A \\
f(2) = A \\
 f(3) = A
 $$
 
 * Example of mapping:

$$f(x) = x + 1 \\
f(1) = 1 + 1 \\
f(1) = 2
$$

## The structure of lambda terms
* The lambda calculus has three basic components, or lambda terms: expressions, variables, and abstractions. 
* The word expression refers to a superset of all those things: an expression can be a variable name, an abstraction, or a combination of those things. The simplest expression is a single variable. 
* Variables here have no meaning or value; they are just names for potential inputs to functions.
* An abstraction is a function. It is a lambda term that has a head (a lambda) and a body and is applied to an argument. An argument is an input value.
* Abstractions consist of two parts: the head and the body. The head ($\lambda x$) of the function is a $\lambda$ (lambda) followed by a variable name ($\lambda x$). The body of the function is another expression ($x$). So, a simple function might look like this:
$$
\lambda x.x
$$
* The dot ($.$) separates the parameters of the lambda from the function body.
* The variable named in the head ($x$) is the *parameter* and *binds* (substitutes) all instances of that same variable in the body of the function. That means, when we apply this function to an argument, each $x$ in the body of the function will have the value of that argument. All $x$ in the body will be replaced with the value given to $x$.
* In the previous section, we were talking about functions called $f$, but the lambda abstraction $\lambda x.x$ has no name. It is an **anonymous function**. A *named function* can be *called by name* by another function; an anonymous function *cannot*.

### Alpha equivalence
* The variable $x$ in $\lambda x.x$ s not semantically meaningful except in its role in that single expression. Because of this, there’s a form of equivalence between lambda terms called alpha equivalence. This is a way of saying that:
$$
\lambda x.x \\
\lambda d.d \\
\lambda z.z
$$

all mean the same thing – they’re all the same function.

## Beta reduction
When we apply a function to an argument, we substitute the input expression for all instances of bound variables within the body of the abstraction. You also eliminate the head of the abstraction, since its only purpose was to bind a variable. This process is called *beta reduction*.

$$
\lambda x.x \\
(\lambda x.x) \ 2 \\
2
$$

* The only bound variable is the single $x$, so applying this function to $2$ returns $2$. This function is the *identity function*.
* Let's use an example that mixes some arithmetic into our lambda calculus. We use the parentheses here to clarify that the body expression is $x+1$. In other words, we are not applying the function to the $1$:
$$
\lambda x.x+1 \\
\begin{align*}
(\lambda x.x+1) \  1+1\\
1
\end{align*}
$$

* Example with $x=2$:
$$
\lambda x.x+1 \\
\begin{align*}
(\lambda x.x+1) \  2+1\\
3
\end{align*}
$$

* Example with $x=10$:
$$
\lambda x.x+1 \\
\begin{align*}
(\lambda x.x+1) \  10+1\\
11
\end{align*}
$$

* Beta reduction is this process of 
1. applying a lambda term to an argument, 
2. replacing the bound variables with the value of the argument, and 
3. eliminating the head. 
* **Eliminating the head ($\lambda x$) tells you the function has been applied.**
*  We can also apply our identity function to another lambda ab- straction:

$$
(\lambda x.x)(\lambda y.y)
$$

In this case, we’d substitute the entire abstraction in for $x$. We’ll use a new syntax here, $[x ∶= z]$, to indicate that $z$ will be substituted for all occurrences of $x$ (here $z$ is the function $\lambda y.y$). We reduce this application like this:

$$
(\lambda x.x)(\lambda y.y) \\
\begin{align*}
[x ∶= (\lambda y.y)] \\
\lambda y.y
\end{align*}
$$

* Our final result is another identity function. There is no argument to apply it to, so we have nothing to reduce.
*  Adding a third argument, $(\lambda x.x)(\lambda y.y)z$.
* Applications in the lambda calculus are le  associative. That is, unless specific parentheses suggest otherwise, they associate, or group, to the left.
$$
(\lambda x.x)(\lambda y.y)z \\
((\lambda x.x)(\lambda y.y))z
$$
* Doing the reduction:
$$
(\lambda x.x)(\lambda y.y)z \\
\begin{align*}
[x := (\lambda y.y)] \\
(\lambda y.y)z \\
[y := z] \\
\lambda z.z \\
z
\end{align*}
$$
* We can’t reduce this any further as there is nothing le  to apply, and we know nothing about $z$.
