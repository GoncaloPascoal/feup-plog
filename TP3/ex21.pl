
slice(List, Idx1, Idx2, Slice) :-
    Idx1 =< Idx2, length(List, Size), Idx1 < Size, Idx2 < Size,
    append(Before, Slice, BS),
    append(BS, _, List),
    length(Before, Idx1),
    length(Slice, SliceSize), SliceSize is Idx2 - Idx1 + 1.
