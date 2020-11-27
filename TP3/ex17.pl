
% True if a list is a palindrome (same when read forwards or backwards)
palindrome([]).
palindrome([_]).
palindrome(L) :-
    append([X | T], [X], L),
    palindrome(T).
