
age(john, 19).
age(mary, 35).
age(luke, 7).
age(peter, 41).
age(sheldon, 65).

get_diff(Age, Name, Diff) :-
    age(Name, PersonAge), Diff is abs(Age - PersonAge).

closest_age(Age, [N1 | Rest]) :-
    setof(Diff-Name, get_diff(Age, Name, Diff), [_D1-N1 | Tail]),
    get_rest(Tail, Rest).

get_rest([], []).
get_rest([_D-N | Tail], [N | Rest]) :-
    get_rest(Tail, Rest).
