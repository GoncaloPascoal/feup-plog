:- use_module(library(lists)).

functor2(Term, Name, N) :-
    Term =.. [Name | Args],
    length(Args, N).

arg2(N, Term, Arg) :-
    Term =.. [_ | Args],
    nth1(N, Args, Arg).
