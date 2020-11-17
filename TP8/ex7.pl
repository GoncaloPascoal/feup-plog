
hanoi(1, Start, End, _, [m(Start, End)]).
    
hanoi(N, Start, End, Aux, Moves) :-
    N1 is N - 1,
    hanoi(N1, Start, Aux, End, M1),
    hanoi(1, Start, End, Aux, M2),
    hanoi(N1, Aux, End, Start, M3),
    append(M1, M2, M12),
    append(M12, M3, Moves).
