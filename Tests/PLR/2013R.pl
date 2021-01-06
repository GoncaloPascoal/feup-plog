
:- use_module(library(clpfd)), use_module(library(lists)), use_module(library(ordsets)).

get_line(LineNumber, Sudoku, Line) :-
    nth1(LineNumber, Sudoku, Line).

get_column(ColumNumber, Sudoku, Column) :-
    transpose(Sudoku, Transposed),
    nth1(ColumNumber, Transposed, Column).

construct_block(_Sudoku, _StartRow, _StartCol, BlockSide, BlockSide, []).
construct_block(Sudoku, StartRow, StartCol, I, BlockSide, [RowBlock | Rest]) :-
    RowIdx is StartRow + I,
    nth0(RowIdx, Sudoku, Row),
    sublist(Row, RowBlock, StartCol, BlockSide),
    NextI is I + 1,
    construct_block(Sudoku, StartRow, StartCol, NextI, BlockSide, Rest).

get_block(BlockNumber, N, Sudoku, Block) :-
    BlockSide is truncate(sqrt(N)),
    Block0 is BlockNumber - 1,
    StartRow is Block0 // BlockSide * BlockSide, StartCol is Block0 mod BlockSide * BlockSide,
    construct_block(Sudoku, StartRow, StartCol, 0, BlockSide, Block).

make_grid(_N, 0, []).
make_grid(N, I, [Line | Rest]) :-
    I > 0,
    length(Line, N),
    Next is I - 1,
    make_grid(N, Next, Rest).

nlist(0, []).
nlist(N, [N | Rest]) :-
    N > 0,
    Next is N - 1,
    nlist(Next, Rest).

unique_lines(_Sudoku, 0).
unique_lines(Sudoku, I) :-
    get_line(I, Sudoku, Line),
    all_distinct(Line),
    Next is I - 1,
    unique_lines(Sudoku, Next).

unique_columns(_Sudoku, 0).
unique_columns(Sudoku, I) :-
    get_column(I, Sudoku, Column),
    all_distinct(Column),
    Next is I - 1,
    unique_columns(Sudoku, Next).

unique_blocks(_Sudoku, 0, _N).
unique_blocks(Sudoku, I, N) :-
    get_block(I, N, Sudoku, Block),
    append(Block, BlockFlat),
    all_distinct(BlockFlat),
    Next is I - 1,
    unique_blocks(Sudoku, Next, N).

restrict(N, Sudoku) :-
    make_grid(N, N, Sudoku),
    append(Sudoku, Flat),
    domain(Flat, 1, N),

    nlist(N, NList),
    ord_setproduct(NList, [N], Cardinality),
    global_cardinality(Flat, Cardinality),

    unique_lines(Sudoku, N),
    unique_columns(Sudoku, N),
    unique_blocks(Sudoku, N, N).

sudoku(N, Sudoku) :-
    restrict(N, Sudoku),
    append(Sudoku, Flat),
    labeling([], Flat).


get_diagonal1(N, Sudoku, Diagonal) :-
    get_diagonal1(0, N, Sudoku, Diagonal).

get_diagonal1(N, N, _Sudoku, []).
get_diagonal1(I, N, Sudoku, [Num | Rest]) :-
    nth0(I, Sudoku, Row), nth0(I, Row, Num),
    NextI is I + 1,
    get_diagonal1(NextI, N, Sudoku, Rest).

get_diagonal2(N, Sudoku, Diagonal) :-
    get_diagonal2(0, N, Sudoku, Diagonal).

get_diagonal2(N, N, _Sudoku, []).
get_diagonal2(I, N, Sudoku, [Num | Rest]) :-
    nth0(I, Sudoku, Row), Idx is N - I - 1,
    nth0(Idx, Row, Num),
    NextI is I + 1,
    get_diagonal2(NextI, N, Sudoku, Rest).

exactly(_X, [], 0).
exactly(X, [Y | T], N) :-
    X #= Y #<=> B,
    N #= M + B,
    exactly(X, T, M).

sudoku2(N, Sudoku) :-
    restrict(N, Sudoku),
    append(Sudoku, Flat),

    K is truncate(sqrt(N)),

    get_diagonal1(N, Sudoku, Diagonal1), get_diagonal2(N, Sudoku, Diagonal2),
    exactly(1, Diagonal1, Count1), exactly(1, Diagonal2, Count2),

    (Count1 #= K) #\ (Count2 #= K),

    labeling([], Flat).

% TODO: Answer c)

different_colors([], _Colors).
different_colors([A-B | Rest], Colors) :-
    element(A, Colors, ColorA),
    element(B, Colors, ColorB),
    ColorA #\= ColorB,
    different_colors(Rest, Colors).

exactly_even([], _Colors, 0).
exactly_even([A-B | Rest], Colors, N) :-
    element(A, Colors, ColorA),
    element(B, Colors, ColorB),
    ((ColorA mod 2 #= 0) #/\ (ColorB mod 2 #= 0)) #<=> Even,
    N #= M + Even,
    exactly_even(Rest, Colors, M).

cost(_N, [], 0).
cost(N, [Color | Rest], Cost) :-
    Cost #= N - Color + 1 + RestCost,
    cost(N, Rest, RestCost).

regions(N, Adj, Colors) :-
    length(Colors, N),
    domain(Colors, 1, N),

    different_colors(Adj, Colors),
    exactly_even(Adj, Colors, 3),
    cost(N, Colors, Cost),

    labeling([minimize(Cost)], Colors).

regions_example(Colors) :-
    regions(9, [1-2, 1-3, 2-3, 2-4, 2-5, 3-4, 3-6, 4-5, 4-6, 4-7, 4-8, 5-8, 5-9, 6-7, 7-8, 8-9], Colors).