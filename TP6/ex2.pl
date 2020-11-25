
% Example predicate
positive(X) :- X > 0.

my_split(L, Pred, SL) :-
    my_split(L, Pred, Succeeded, Failed),
    append(Succeeded, Failed, SL).

my_split([], _Pred, [], []).
my_split([Head | Tail], Pred, [Head | Rest], Failed) :-
    T =.. [Pred, Head], T, !,
    my_split(Tail, Pred, Rest, Failed).
my_split([Head | Tail], Pred, Succeeded, [Head | Rest]) :-
    my_split(Tail, Pred, Succeeded, Rest).
