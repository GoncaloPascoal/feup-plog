
init_list(_Value, 0, []).
init_list(Value, Length, [Value | Rest]) :-
    Next is Length - 1,
    init_list(Value, Next, Rest).

% Copies elements of the given list N times
copy_n_times([], _N, []).
copy_n_times([Head | Tail], N, Result) :-
    init_list(Head, N, Rep),
    append(Rep, Rest, Result),
    copy_n_times(Tail, N, Rest).

duplicate(List, Result) :-
    copy_n_times(List, 2, Result).
