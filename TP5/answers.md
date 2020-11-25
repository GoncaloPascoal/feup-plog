## PLOG Exercises - TP5

**1.**
* B and C succeed -> A can only succeed if D and E succeed
* B or C fail -> Prolog backtracks and A can succeed if F and G succeed

**2. a)** 
```
X = 1
X = 2
```
**b)**
```
X = 1, Y = 1
X = 1, Y = 2
X = 2, Y = 1
X = 2, Y = 2
```
**c)**
```
X = 1, Y = 1
X = 1, Y = 2
```

**3. a)**
```
um
dois
tres
ultima_clausula
no
```
**b)**
```
um
no
```
**c)**
```
um-um
um-dois
um-tres
no
```

**4. a)** If X = Y, X > Z and Y > Z the program will incorrectly state that Z is the largest number.
**b)**
```prolog
max(X, Y, Z, X) :- X >= Y, X >= Z, !.
max(X, Y, Z, Y) :- Y >= X, Y >= Z, !.
max(_, _, Z, Z).
```

**6.**
* `imaturo(X)`: red cut, makes `imaturo(X)` same as `not(adulto(X))`
* The other two cuts are green cuts, if the first goal succeeds, Prolog will not bother checking the other clauses. This assumes `pessoa(X)` and `tartaruga(X)`are mutually exclusive