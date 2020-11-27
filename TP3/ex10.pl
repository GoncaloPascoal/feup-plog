
sorted([]).
sorted([_]).
sorted([X, Y | T]) :-
    X < Y,
    sorted([Y | T]).

% My implementation of the merge sort algorithm
my_sort([], []).
my_sort([X], [X]).
my_sort(L1, L2) :-
    length(L1, S1),
    Half is S1 // 2,
    append(Left, Right, L1), length(Left, Half),
    my_sort(Left, LeftSorted),
    my_sort(Right, RightSorted),
    merge(LeftSorted, RightSorted, L2).

merge(Left, [], Left).
merge([], Right, Right).
merge([HL | TL], [HR | TR], [HL | Rest]) :-
    HL < HR,
    merge(TL, [HR | TR], Rest).
merge([HL | TL], [HR | TR], [HR | Rest]) :-
    merge([HL | TL], TR, Rest).
