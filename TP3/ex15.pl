
dot_prod(L1, L2, N) :-
    length(L1, S), length(L2, S), S > 0,
    dot_prod(L1, L2, 0, N).

dot_prod([], [], Acc, Acc).
dot_prod([H1 | T1], [H2 | T2], Acc, N) :-
    Prod is H1 * H2,
    Sum is Acc + Prod,
    dot_prod(T1, T2, Sum, N).
