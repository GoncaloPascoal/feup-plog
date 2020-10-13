% 5. a)
member_(X, [X | L]).
member_(X, [Y | L]) :-
    X != Y,
    member_(X, L).

% 5. b)
member_append(X, L) :-
    append(_, [X | _], L).

% 5. c)
member_last(X, L) :-
    append(_, [X], L).

% 5. d)
nth_element([X | _], 1, X).
nth_element([_ | L], N, Y) :-
    N > 1,
    N1 is N - 1,
    nth_element(L, N1, Y).
