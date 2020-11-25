
:- op(500, xfx, exists_in),
op(500, fx, concatenate),
op(500, fx, delete),
op(400, xfx, gives),
op(300, xfx, and),
op(300, xfx, on).

X exists_in [X|_].
X exists_in [_ | T] :-
  X exists_in T.

concatenate L and [] gives L.
concatenate [] and L gives L.
concatenate [H1 | T1] and L2 gives [H1 | L3] :-
  concatenate T1 and L2 gives L3.

delete _X on [] gives [].
delete X on [X | T] gives T.
delete X on [H | T] gives [H | NT] :-
    delete X on T gives NT.
