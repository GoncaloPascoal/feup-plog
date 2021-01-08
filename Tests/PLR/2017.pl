
:- use_module(library(clpfd)), use_module(library(lists)).

% Question 3

test([_, _]).
test([X1, X2, X3 | Xs]) :-
    (X1 #< X2 #/\ X2 #< X3) #\/ (X1 #> X2 #/\ X2 #> X3),
    test([X2, X3 | Xs]).

pos([], _, []).
pos([X | Xs], L2, [I | Is]) :-
    element(I, L2, X),
    pos(Xs, L2, Is).

p2(L1, L2) :-
    length(L1, N),
    length(L2, N),

    test(L2),
    pos(L1, L2, Is),
    all_distinct(Is),

    labeling([], Is).

% Question 4

total_time(_RecipeTimes, [], 0).
total_time(RecipeTimes, [Cooking | Rest], TotalTime) :-
    element(Cooking, RecipeTimes, Time),
    TotalTime #= Time + RestTime,
    total_time(RecipeTimes, Rest, RestTime).

total_eggs(_RecipeEggs, [], 0).
total_eggs(RecipeEggs, [Cooking | Rest], TotalEggs) :-
    element(Cooking, RecipeEggs, Eggs),
    TotalEggs #= Eggs + RestEggs,
    total_time(RecipeEggs, Rest, RestEggs).

sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs) :-
    length(Cookings, 3), length(RecipeTimes, NumRecipes),
    domain(Cookings, 1, NumRecipes),
    all_distinct(Cookings),

    total_time(RecipeTimes, Cookings, TotalTime),
    TotalTime #=< MaxTime,
    
    total_eggs(RecipeEggs, Cookings, Eggs),
    Eggs #=< NEggs,

    labeling([maximize(Eggs)], Cookings).

% Question 5

constrain_board([], [], _Board, 0).
constrain_board([ShelfLength | RestShelves], [Selected | RestSelected], Board, TotalLength) :-
    Selected #= Board #<=> B,
    TotalLength #= ShelfLength * B + RestLength,
    constrain_board(RestShelves, RestSelected, Board, RestLength).

constrain(_Shelves, _Boards, _SelectedBoards, I, NumBoards) :-
    I > NumBoards.
constrain(Shelves, Boards, SelectedBoards, I, NumBoards) :-
    nth1(I, Boards, BoardLength),
    constrain_board(Shelves, SelectedBoards, I, TotalLength),
    TotalLength #=< BoardLength,
    Next is I + 1,
    constrain(Shelves, Boards, SelectedBoards, Next, NumBoards).

cut(Shelves, Boards, SelectedBoards) :-
    length(Shelves, NumShelves), length(Boards, NumBoards),
    length(SelectedBoards, NumShelves),
    domain(SelectedBoards, 1, NumBoards),

    constrain(Shelves, Boards, SelectedBoards, 1, NumBoards),

    labeling([], SelectedBoards).