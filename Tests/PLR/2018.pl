
:- use_module(library(clpfd)).

% Question 3

check([_], []).
check([A, B | R], [X | Xs]) :-
    A + B #= X,
    check([B | R], Xs).

prog2(N,M,L1,L2) :-
    length(L1, N),
    N1 is N - 1, length(L2, N1),
    domain(L1, 1, M),
    domain(L2, 1, M),

    append(L1, L2, L),
    all_distinct(L),

    check(L1, L2),
    labeling([], L1).

% Question 4

add_men([], _I, []).
add_men([Woman | Rest], I, [I-Woman | RestPairs]) :-
    Next is I + 1,
    add_men(Rest, Next, RestPairs).

restrict_heights([], _WomenHeights, _Delta, []).
restrict_heights([MenHeight | RestHeights], WomenHeights, Delta, [Woman | RestWomen]) :-
    element(Woman, WomenHeights, WomanHeight),
    MenHeight #>= WomanHeight, % Man cannot be shorter than woman
    MenHeight - WomanHeight #< Delta, % Height difference must be below delta
    restrict_heights(RestHeights, WomenHeights, Delta, RestWomen).

gym_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    length(MenHeights, N), length(WomenHeights, N),
    length(Women, N),

    domain(Women, 1, N),
    all_distinct(Women),

    restrict_heights(MenHeights, WomenHeights, Delta, Women),

    labeling([], Women),
    add_men(Women, 1, Pairs).

% Question 5

exactly(_X, [], 0).
exactly(X, [Y | T], N) :-
    X #= Y #<=> B,
    N #= M + B,
    exactly(X, T, M).

restrict_heights_skating([], _WomenHeights, _Delta, []).
restrict_heights_skating([MenHeight | RestHeights], WomenHeights, Delta, [Woman | RestWomen]) :-
    Woman #> 0,
    element(Woman, WomenHeights, WomanHeight),
    MenHeight #>= WomanHeight, % Man cannot be shorter than woman
    MenHeight - WomanHeight #< Delta, % Height difference must not be above delta
    restrict_heights_skating(RestHeights, WomenHeights, Delta, RestWomen).
restrict_heights_skating([_ | RestHeights], WomenHeights, Delta, [Woman | RestWomen]) :-
    Woman #= 0,
    restrict_heights_skating(RestHeights, WomenHeights, Delta, RestWomen).

add_men_skating([], _I, []).
add_men_skating([0 | Rest], I, Pairs) :-
    Next is I + 1,
    add_men_skating(Rest, Next, Pairs).
add_men_skating([Woman | Rest], I, [I-Woman | RestPairs]) :-
    Woman > 0,
    Next is I + 1,
    add_men_skating(Rest, Next, RestPairs).

optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    length(MenHeights, MenCount), length(WomenHeights, WomenCount),
    length(Women, MenCount),
    domain(Women, 0, WomenCount),
    all_distinct_except_0(Women),

    restrict_heights_skating(MenHeights, WomenHeights, Delta, Women),

    exactly(0, Women, NumUnpaired),

    labeling([minimize(NumUnpaired)], Women),
    add_men_skating(Women, 1, Pairs).
