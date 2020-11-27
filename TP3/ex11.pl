
flatten([], []).
flatten([[S | TS] | T], Elems) :-
    flatten([S | TS], SElems),
    flatten(T, Rest),
    append(SElems, Rest, Elems).
flatten([H | T], [H | Rest]) :-
    flatten(T, Rest).
