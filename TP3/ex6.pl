% 6. a)
delete_one(X, L1, L2) :-
    append(La, Lb, L2),
    append(La, [X | Lb], L1).

% 6. b)
delete_all(X, L1, L1) :-
    \+ member(X, L1).

delete_all(X, L1, L2) :-
    delete_one(X, L1, L2),
    delete_all(X, L2, []).

% 6. c)

