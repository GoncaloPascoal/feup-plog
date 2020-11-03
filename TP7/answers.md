## PLOG Exercises - TP7

**1. a)**
```
   ae
 na  c
a  b
```
**b)** Impossible  
**c)**
```
 ad
a  na
  b  c
```
**d)** Impossible  
**e)**
```
 ad
a  ad
  b  c
```
**f)**
```
   ae
 ae  c
a  b
```
**g)**
```
  ad
 /  \
a    ad
    /  \
   b   ae
      /  \
     ae   f
    /  \
   na  e
  /  \
 c    d
```

**3. a)**
```
             \\
        /          \
     //              :
  /      \        /     \
Voo     para     Dia     :
       /     \         /   \
      de    Dest    Hora   min
     /  \
 Número Orig
```
**b)**
```
               :
        /             \
     para               :
    /    \         /         \
  de      C      para       para
 /  \           /    \     /    \
1    A         de     C   de     B
              /  \       /  \
             2    B     3    A
```

**5.**
```
marcelo joga futebol e squash.

     joga
    /    \
marcelo   e
         / \
  futebol   squash

joga(marcelo, [futebol, squash]).
```
```
renata joga tenis e basquete e volei.

     joga
    /    \
renata    e
         / \
    tenis   e
           / \
   basquete   volei

joga(renata, [tenis, basquete, volei]).
```