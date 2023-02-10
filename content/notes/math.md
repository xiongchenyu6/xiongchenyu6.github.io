+++
title = "Math"
date = 2021-11-20T16:11:00+08:00
draft = false
+++

## Algorithm Theory {#algorithm-theory}


### 算法导论 {#算法导论}


#### Optimal binary tree {#optimal-binary-tree}

In the range(i,j), if pick i as the root, then the left subtree will become
(i,i-1) so have the dummy leaf di-1, so if pick j as the root, the right subtree
become (j,j+1) have the dummy leaf dj.


## Category theory {#category-theory}

A category consists of objects and arrows that go between them.

```haskell
-- A function can never be called
absurd :: Void -> a

```


### Basic {#basic}

Primitive : No property
Abstraction
`Composition`

{{< figure src="/ox-hugo/composition.png" >}}

`Identity`
f . id_a  = f
id_a . f = f

{{< figure src="/ox-hugo/identity.png" >}}

`Associativity`
h . (g . f) = (h . g) . f

{{< figure src="/ox-hugo/Associativity.png" >}}

`Function` :  A mapping of values to values


### Set {#set}

Type are sets.
In Set, objects are sets and morphisms (arrows) are functions.
A set of morphisms between two objects in any category is called a hom-set.


### \_|_(Buttom) {#buttom}

Unicode ⊥. This “value” corresponds to a non-terminating computation.

```haskell
f :: Bool -> Bool
```

Functions that may return bottom are called partial, as opposed to total functions, which return valid results for every possible argument.


### Order {#order}

preorder partial order
A set of morphisms from object a to object b in a category C is called a
hom-set and is written as C(a, b) (or, sometimes, HomC(a, b)). So every
hom-set in a preorder is either empty or a singleton.


### Monoid {#monoid}

mappend maps an element of a monoid set to a function acting on that set
A monoid is a single object category.


### Category {#category}

<span class="timestamp-wrapper"><span class="timestamp">[2017-05-09 Tue 23:17]</span></span>
`Kleisli category`  a category based on a monad.
any category C we can define the opposite category Cop just by reversing
all the arrows.
terminal object is the initial object in the opposite category.


### Product {#product}

A product of two objects a and b is the object c equipped with two projections
such that for any other object c’ equipped with two projections there is a
unique morphism m from c’ to c that factorizes those projections.


### Asymmetry {#asymmetry}

surjective +
injective =
bijection (isomorphism)


### Kleisli category {#kleisli-category}


### Bifunctors {#bifunctors}

C x D = E


### Covariant and Contravariant Functors {#covariant-and-contravariant-functors}

```haskell
class Contravariant f where
contramap :: (b -> a) -> (f a -> f b)

```


### Profunctors {#profunctors}

C ^ op x D = E


### Initial Object {#initial-object}

The initial object is the object that has one and only one morphism going to any object in the category.


### Yoneda lemma {#yoneda-lemma}

CPS
higher order function to data type
[C,Set] (C(a,-),F) =~ Fa


### Represetable {#represetable}

c(L1,-) = Rc
Data type as the key to get value


## Lambda Mathematics {#lambda-mathematics}


### Definitions {#definitions}

Zero: λs.(λz.z)
1 ≡ λsz.s(z)
2 ≡ λsz.s(s(z))
3 ≡ λsz.s(s(s(z)))
S ≡ λwyx.y(wyx)

**Multiplication**
(λxyz.x(yz))

**Conditionals**
T ≡ λxy.x
F ≡ λxy.y
∧ ≡ λxy.xy(λuv.v) ≡ λxy.xyF
∨ ≡ λxy.x(λuv.u)y ≡ λxy.xTy
¬ ≡ λx.x(λuv.v)(λab.a) ≡ λx.xFT

**conditional test**
Z ≡ λx.xF¬F (zero predicate)


## Linear algebra {#linear-algebra}


### Linear transformation {#linear-transformation}

Associative
Use new base to represent the old
A . B = C
use column of A vector to represent the basis in B
