
% List of all whole numbers from 1 to N
list_until(N, L) :-
    list_between(1, N, L).

% List of all whole numbers between N1 and N2, inclusive
list_between(N2, N2, [N2]).
list_between(N1, N2, [N1 | Rest]) :-
    Next is N1 + 1,
    list_between(Next, N2, Rest).

list_sum([], 0).
list_sum([X], X).
list_sum([X, Y | T], S) :- 
    P is X + Y,
    list_sum([P | T], S).

even(N) :- N mod 2 =:= 0.
