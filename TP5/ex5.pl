
not(X) :- X, !, fail.
not(_).

unificavel([], _, []).

unificavel([Head | Tail], Termo, L2) :-
    not(Head = Termo), !,
    unificavel(Tail, Termo, L2).

unificavel([Head | Tail], Termo, [Head | L]) :-
    unificavel(Tail, Termo, L).
