
check_factors(_N, I, MaxF) :- I >= MaxF.
check_factors(N, I, MaxF) :-
    N mod I > 0,
    I1 is I + 2,
    check_factors(N, I1, MaxF).

is_prime(2).
is_prime(N) :-
    N > 2,
    N mod 2 > 0,
    MaxF is truncate(sqrt(N)),
    check_factors(N, 3, MaxF).
