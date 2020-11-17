
initial(0-0).
final(2-_).

% Empty first bucket
next(_-Y, 0-Y, e1).

% Empty second bucket
next(X-_, X-0, e2).

% Fill first bucket
next(_-Y, 4-Y, f1).

% Fill second bucket
next(X-_, X-3, f2).

% Move from first bucket to second bucket
next(X-Y, X1-Y1, m12) :-
    X > 0,
    Y < 3,
    Diff is 3 - Y,
    T is min(X, Diff),
    X1 is X - T,
    Y1 is Y + T.

% Move from second bucket to first bucket
next(X-Y, X1-Y1, m21) :-
    Y > 0,
    X < 4,
    Diff is 4 - X,
    T is min(Y, Diff),
    X1 is X + T,
    Y1 is Y - T.

% Obtains the shortest sequence of states and operations from initial state to final state
solve(Initial, Final, MinPath, MinOps) :-
    setof(Len-Path-Ops, (dfs(Initial, Final, [Initial], Path, Ops), length(Path, Len)), [_MinLen-MinPath-MinOps | _]).

% Depth-first search that obtains a sequence of states and operations
dfs(End, End, Path, Path, []).
dfs(Start, End, Temp, Path, [Op | Rest]) :-
    next(Start, Mid, Op),
    \+ member(Mid, Temp),
    append(Temp, [Mid], TempAppended),
    dfs(Mid, End, TempAppended, Path, Rest).
