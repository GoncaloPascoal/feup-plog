## PLOG Exercises - TP2

**1. a)** `X = a, Y = d, Z = e`  
**b)** Following the execution flow:
```prolog
r(X, Y)
X = a, Y = b

s(Y, Z)
Y = b, Z = c

not(r(Y, X))
Y = b, X = a        % (1)

s(Y, Z)
Y = b, Z = d

not(r(Y, X))
Y = b, X = a        % (2)

s(Y, Z)

r(X, Y)
X = a, Y = c

s(Y, Z)
Y = c, Z = c

not(r(Y, X))
Y = c, X = a

not(s(Y, Y))
Y = c

not(r(Y, X))        % (3)

s(Y, Z)

r(X, Y)
X = b, Y = a

s(Y, Z)

r(X, Y)
X = a, Y = d

s(Y, Z)
Y = d, Z = e

not(r(Y, X))
Y = d, X = a

not(s(Y, Y))
Y = d

X = a, Y = d, Z = e ?
```
Therefore we backtrack from the 3rd to the 2nd goal 3 times.

**2.**
```prolog
a(X, 2).
yes

b(X, kalamazoo).
X = 2 ?

c(X, b3).
X = a3 ?

c(X, Y).
X = a1, Y = b1 ?

d(X, Y).
X = a1, Y = 2 ?
```