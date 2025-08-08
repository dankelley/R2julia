#import "@local/document:0.0.1": conf
#show: doc => conf(
category: "",
title: "Hints on migrating from R to Julia",
date: "2025-08-08",
author: "Dan Kelley",
preface: "",
doc,
)
#set heading(numbering: "1.1.1.")

#outline()

= Overview

1. Error messages in Julia tend to be much less helpful than those in R.
   Functions in R tend to do quite a lot of checking as they work, and to give
   clear warnings or errors if problems arise. This is true of some Julia
   functions, but it is not the norm in that system. Many problems are
   signalled by a long traceback listing not just in your code, but in other
   lower-level code.  It is important to learn how to read these listings.

2. Julia is not object-oriented, so some of your R thinking will need
   adjustment.

3. Braces are not used in conditionals, loops, or functions; the keyword `end`
   is used to indicate the end of such blocks.

4. Study and practice the `.` notation, which is very powerful but quite unlike
   R.

5. Note that the `.` notation is often used for vectorized operations.

6. In Julia, functions can alter the data that you supply as arguments.  To
   learn more, look for discussion of "mutable" arguments in Julia
   documentation. If you are experienced in Python, your path to understand may
   be shorter than would be the case if you have used R extensively.

7. Julia functions have concrete expectations of parameter types. For
   example, if you set `guidefontsize` to 12.0, an error message will result
   because it was expecting an integer. R is more permissive with regard to
   integers and floats.

8. You may alter existing plots by calling `plot!()`. Julia does not use an
   overpainting style, as is used in base R graphics, so you may find the
   results surprising.

9. Base Julia plots offer less in the way of aesthetic control than is the
   case for base R plots. 

10. Base Julia plots are cruder than those of R.  For example, I find that
    axis numbers run together sometimes. Julia does not seem to check on the
    lengths of those strings, but R must, since I have never seen such problems
    in the latter system.

11. In addition to its base graphical system, Julia has some other
    libraries. This leads to some confusion in interpreting what you find on
    the web.  I cannot recommend any particular library at this stage, and am
    tending to stick with base graphics (as I do in R).

12. Julia is touted as a fast system, and that's the case for long
    computations.  However, it is much slower on startup than R or python, so
    it is not as suitable as the others for quick scripts.

13. The Julia community can be quite helpful to newcomers.

= Details

== Assignment

In R, one might
```R
x <- 10
```
whereas in Julia one might write
```julia
x = 10
```

(Some R authors use `=` for assignment. Although this works, it is not the
recommended style.)

== Greek letters and subscripts in variable names

In R, one might write
```R
lambda <- 10
x0 <- 0.0
```
whereas in Julia we could (if desired) write Greek letters and subscripts directly
```julia
λ = 10
x₀ = 0.0
```

To enter Greek letters in a Julia session (or the neovim editor), type
`\lambda` and you will be given the choice of replacing what you typed by
either lower- or upper-case lambda.

What is happening is that Julia accepts Unicode symbols.  So, for example, you
can subscript by 0 or 1, but not by, say `x`, because subscript-x is not a
Unicode symbol.


== Brevity of notation
In R, one might write
```R
a <- 3
b <- 2 * a
```
for the circumference of a circle of unit radius,
and in Julia one might write
```julia
a = 3
b = 2a
```

Notice that Julia does not require an asterisk when a numerical constant is
written to the left of a variable to indicate multiplication. (This does not
work if the constant is written to the left of the variable, however.)

== Built-in constants

Like R, Julia has a built-in constant named `pi` for the ratio of the
circumference of a circle to its radius. This may be written as π, if desired.

== Creating vectors

In R, one might write
```R
c(1, 2:3)
```
and in Julia one might write
```julia
[1;2:3]
```
I recommend trying the latter in Julia, to see how the results are displayed.  Then try the same, but with say `2:300` instead of `2:3`, and notice that Julia has a nice way of showing the start and the end of material like this in a console.

The next step is to explore other ways of creating (or trying to create)
similar aggregate forms. Try each of the following, and study the results.

```julia
[1 2 3]
[1,2,3]
[1;2;3]
```

Ah, now you're an expert!  Well, maybe not.  Try the following, and think about how (and why) Julia responds.
```julia
[1 2:3]
[1;2:3]
[1,2,3]
```

== Functions

_FIXME: write material here and be *very* clear about the confusing mutable-parameter issue!_

= Practical Examples


== Selecting the first half of a data frame

In R one might write
```R
head(df, nrow(df)/2)
```
and in Julia an equivalent is
```julia
first(df, trunc(Int, nrow(df)/2))
```
Suggestion: write the latter as `first(df, nrow(df)/2)` and study the error message,
since R users will encounter that message quite often until they get used to Julia.

== Adding lines to a scatterplot

In R, one might use
```R
x <- seq(0, 1, 0.01)
y <- (x - 0.25) * (x - 0.75)
yn <- y + rnorm(length(y), sd = 0.03)
plot(x, yn, pch=20, col="red", xlab="x", ylab="signal")
lines(x, y, col="blue", lwd=5)
```
and in Julia one might use
```julia
using Plots
x = 0:0.01:1
y = (x .- 0.25) .* (x .- 0.75) # note the use of .- and .*
yn = y + 0.03 * randn(length(x))
plot(x, yn, seriestype=:scatter, legend=false, color=:red, xlab="x", ylab="signal")
plot!(x, y, seriestype=:line, color=:blue, linewidth=5)
```

In Julia, we may add to an existing plot by using `plot!()` instead of
`plot()`. Importantly, this can do more than just add material -- it can also
change material. For example, if the original plot had an x axis ranging from 0
to 1 to capture the supplied data, and if the additional plot had data from 100
to 101, then the plot range would be extended to show both. This is very much
in contrast to R, which employs a sort of overpainting model.

