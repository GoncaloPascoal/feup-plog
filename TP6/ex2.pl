
my_split([], _, []).

my_split([Head | Tail], Pred, [Head | Res1]) :-
    Term =.. [Pred, Head],
    Term, !,
    my_split(Tail, Pred, Res1).

my_split([Head | Tail], Pred, Res) :-
    append(Res1, [Head], Res),
    my_split(Tail, Pred, Res1).
