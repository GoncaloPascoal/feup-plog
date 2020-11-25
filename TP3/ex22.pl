
rotate([], _N, []).
rotate(L, 0, L).

rotate([Head | Tail], N, X) :-
    N > 0, !, Next is N - 1,
    append(Tail, [Head], Rot),
    rotate(Rot, Next, X).

rotate(L, N, X) :-
    Next is N + 1,
    append(Prefix, [Last], L),
    rotate([Last | Prefix], Next, X).
