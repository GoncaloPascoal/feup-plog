
separa([], _, []).

separa([Head | Tail], Pred, [Head | Res1]) :-
    Term =.. [Pred, Head],
    Term, !,
    separa(Tail, Pred, Res1).

separa([Head | Tail], Pred, Res) :-
    append(Res1, [Head], Res),
    separa(Tail, Pred, Res1).

