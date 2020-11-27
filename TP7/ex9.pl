
between(N1, N2, N1) :-
    N1 =< N2.
between(N1, N2, X) :-
    N1 < N2,
    New is N1 + 1,
    between(New, N2, X).
