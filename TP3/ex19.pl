
rle([], []).
rle([Head | Tail], Encoded) :-
    rle(Tail, Encoded, Head, 1).

rle([], [Char], Char, N) :- N = 1, !.
rle([], [[N, Char]], Char, N).

rle([Char | Tail], Encoded, Char, N) :-
    N1 is N + 1, !,
    rle(Tail, Encoded, Char, N1).

rle([Other | Tail], [Char | Rest], Char, N) :- 
    N = 1, !,
    rle(Tail, Rest, Other, 1).

rle([Other | Tail], [[N, Char] | Rest], Char, N) :-
    rle(Tail, Rest, Other, 1).

% TODO: rle_decode
