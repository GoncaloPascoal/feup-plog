
:- use_module(library(clpfd)).

consecutive([_]).
consecutive([A, B | T]) :-
    A mod 2 #\= B mod 2,
    consecutive([B | T]).

seq(Vars) :-
    length(Vars, 5),
    domain(Vars, 1, 9),

    consecutive(Vars),

    element(3, Vars, Center),
    Center in 1..2,

    all_distinct(Vars),

    labeling([], Vars).

exactly(_X, [], 0).
exactly(X, [Y | T], N) :-
    X #= Y #<=> B,
    N #= M + B,
    exactly(X, T, M).

max_three(0, _Vars).
max_three(I, Vars) :-
    I > 0,
    exactly(I, Vars, NumTimes),
    NumTimes #=< 3,
    Next is I - 1,
    max_three(Next, Vars).

seqn(Vars, N) :-
    N mod 3 #= 0,
    
    length(Vars, N),
    domain(Vars, 1, 9),

    max_three(9, Vars),
    consecutive(Vars),

    element(1, Vars, First), element(N, Vars, Last),
    CenterIdx is N // 2 + 1,
    element(CenterIdx, Vars, Center),

    Center #> First, Center #> Last,

    labeling([], Vars).
    
% TODO: Answer c)

board_values(
    [3,5,7,7,2,6,2,7,
     2,4,6,3,9,4,8,6,
     2,1,8,9,5,9,3,4,
     5,1,4,8,8,4,7,8,
     4,3,8,9,7,8,8,4,
     1,7,9,8,3,3,8,5,
     3,2,4,5,2,6,1,2,
     2,7,1,1,8,1,7,2]).

validate_moves([_], [_]).
validate_moves([X1 , X2 | RX], [Y1, Y2 | RY]) :-
    DiffX #= abs(X2 - X1), DiffY #= abs(Y2 - Y1),
    (DiffX #= 1 #/\ DiffY #= 2) #\/ (DiffX #= 2 #/\ DiffY #= 1),
    validate_moves([X2 | RX], [Y2 | RY]).

calc_value([], [], 0).
calc_value([X | RX], [Y | RY], TotalValue) :-
    board_values(V),
    Idx #= X + (Y - 1) * 8,
    element(Idx, V, Value),
    TotalValue #= Value + RestValue,
    calc_value(RX, RY, RestValue).

zip([], [], []).
zip([X | RX], [Y | RY], [Z | RZ]) :-
    Z #= X + (Y - 1) * 8,
    zip(RX, RY, RZ).

horse(X, Y, TotalValue, N) :-
    length(X, N), length(Y, N),
    domain(X, 1, 8), domain(Y, 1, 8),

    zip(X, Y, Z),
    all_distinct(Z),

    append(X, Y, Coords),
    validate_moves(X, Y),
    calc_value(X, Y, TotalValue),

    labeling([maximize(TotalValue)], Coords).
