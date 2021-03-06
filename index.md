---
title: moving from R to Julia
author: Dan Kelley
date: "`r Sys.Date()`"
---

# Simple Equivalences

| R                          | Julia                      | Notes                                   |
|----------------------------|----------------------------|-----------------------------------------|
| 1L                         |  1                         | Integer unless given a decimal point.   |
| 1.                         |  1.                        | Floating-point works as expected.       |
| 1/2                        |  1/2                       | Promotes to floating.                   |
| `pi`                       |  $\pi$                     | This is handy!                          |
| `2*pi`                     |  $2\pi$                    | Only works for constants.               |
| `A <- matrix(1:4, nrow=2)` |  `A = [1 2 3 ; 4 5 6]`     | Used below.                             |
| `A[1,3] <- 10`             |  `A[1,3] = 10`             | (Same in both)                          |
| `as.vector(A)`             |  `vec(A)`                  | Needed for e.g. `Statistics:quantile()` |
| `cbind(1:3, 4:6)`          |  `[1:3 4:6]`               |                                         |
| `class(A)`                 |  `typeof(A)`               | Julia has a *lot* of types!             |
| `dim(A)`                   |  `size(A)`                 |                                         |
| `source("a.R")`            |  `include("a.jl")`         |                                         |
| `t(A)`                     |  `A'`                      |                                         | 



# Julia data types

See https://docs.julialang.org/en/v1/manual/types/ for more details.

1. Julia has a *lot* of types, including integers `Int8`, `UInt8`, and similar
for 16, 32, 64 and 128, plus floats `Float16`, `Float32`, and `Float64`.  It even
has a type for irrationals (try `typeof(`$\pi$`)` to see this).

2. Julia creates integers unless there is a decimal point in one of the
numbers.

3. Many Julia functions are restrictive on types.  For example,
`Statistics:quantile()` requires its first arg to be a vector, so `vec()` must
be used to compute quantiles of arrays.

## R

```{r}
a <- matrix(1:6, nrow=2)
a
#      [,1] [,2] [,3]
# [1,]    1    3    5
# [2,]    2    4    6

a[1,2] <- 10
a
#      [,1] [,2] [,3]
# [1,]    1   10    5
# [2,]    2    4    6

as.vector(a)
# [1] 1 2 10 4 5 6
```

## Julia
```
a = [1 2 3; 4 5 6]
# 2×3 Array{Int64,2}:
#  1  2  3
#  4  5  6

a[1,2]=10;a
# 2×3 Array{Int64,2}:
#  1  10  3
#  4   5  6

vec(a)
# 6-element Array{Int64,1}:
#  1
#  4
#  10
#  5
#  3
#  6
```

NB. Julia creates integers unless there is a decimal point in one of the
numbers.

# Multi-panel plots

See https://docs.juliaplots.org/latest/layouts/

## R

This plots 4 panels, with top-left being a random series, top-right being a
line, bottom-left being a quadratic, and bottom-right being a decaying
exponential.

```{R eval=FALSE}
par(mfrow=c(2,2))
n <- 10
x <- 1:n
plot(x, rnorm(n), type="l")
plot(x, 2*x, type="l")
plot(x, x*(x-n), type="l")
plot(x, exp(-x), type="l")
```

## Julia

```
using Plots
n = 10
x = 1:n
l = @layout[a b; c d]
a = plot(x, rand(n))
b = plot(x, 2*x)
c = plot(x, x.*(x.-n))
d = plot(x, exp.(-x))
plot(a, b, c, d, layout=l)
```

