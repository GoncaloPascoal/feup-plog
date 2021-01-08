
:- use_module(library(clpfd)), use_module(library(lists)).

numbers(NumsSorted) :-
    length(Nums, 6),
    length(Ps, 6),
    domain(Nums, 1, 49),

    NumsSorted = [A, B, C, D, E, F],
    sorting(Nums, Ps, NumsSorted),

    A #= B / 2,
    D #= 2 * B,
    A + C + D + E + F #= 100,
    E #= B + C,
    A + C #= F - E,

    (B #= A + 1) #\ (C #= B + 1) #\ (D #= C + 1) #\ (E #= D + 1) #\ (F #= E + 1),

    labeling([], NumsSorted).

even_domain([]).
even_domain([H | T]) :-
    H in {2, 4, 6, 8},
    even_domain(T).

odd_domain([]).
odd_domain([H | T]) :-
    H in {1, 3, 5, 7, 9},
    odd_domain(T).

mult :-
    Vars = [I1, P1, P2, P3, P4, P5, I2, P6, P7, P8, I3, P9, I4, I5, P10, P11],

    even_domain([P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11]),
    odd_domain([I1, I2, I3, I4, I5]),

    First #= I1 * 100 + P1 * 10 + P2,
    Second #= P3 * 10 + P4,

    Result #= I4 * 1000 + I5 * 100 + P10 * 10 + P11,

    SumFirst #= P5 * 1000 + I2 * 100 + P6 * 10 + P7,
    SumSecond #= P8 * 1000 + I3 * 100 + P9 * 10,

    First * Second #= Result,
    SumFirst + SumSecond #= Result,
    P4 * First #= SumFirst,
    P3 * 10 * First #= SumSecond,

    labeling([], Vars),
    write(Vars), nl.

factories(3).
products(6).

factory(1, [2-(20,100), 3-20, 4-(20,30), 5-50]).
factory(2, [1-(0,100), 3-(0,20), 4-(10,20), 5-(20,50), 6-(10,50)]).
factory(3, [1-(0,100), 2-(50,100), 3-(0,20), 4-(10,20), 5-(20,50), 6-(10,50)]).

product(1, [0, 5, 3], 10, (20, 150)).
product(2, [7, 4, 5], 13, (10, 100)).
product(3, [2, 2, 1], 5, (60, 250)).
product(4, [5, 0, 3], 8, (30, 80)).
product(5, [1, 3, 2], 5, (80, 350)).
product(6, [10, 12, 0], 20, (10, 80)).


calculate_profit_factory(_FactoryIdx, [], 0).
calculate_profit_factory(FactoryIdx, [Product-Quantity | Rest], ProfitFactory) :-
    product(Product, Costs, SellPrice, _Limits), nth1(FactoryIdx, Costs, Cost),
    ProfitFactory #= Quantity * (SellPrice - Cost) + RestProfit,
    calculate_profit_factory(FactoryIdx, Rest, RestProfit).

calculate_profit(0, _Production, 0).
calculate_profit(FactoryIdx, Production, Profit) :-
    nth1(FactoryIdx, Production, Factory),
    calculate_profit_factory(FactoryIdx, Factory, ProfitFactory),
    Profit #= ProfitFactory + RestProfit,
    NextIdx is FactoryIdx - 1,
    calculate_profit(NextIdx, Production, RestProfit).

generate_list_factory(_FactoryIdx, NumProducts, NumProducts, []).
generate_list_factory(FactoryIdx, NumProducts, I, [Next-Quantity | Rest]) :-
    Next is I + 1,
    factory(FactoryIdx, Products), member(Next-(Lower, Upper), Products), !,
    Quantity in {0} \/ (Lower..Upper),
    generate_list_factory(FactoryIdx, NumProducts, Next, Rest).
generate_list_factory(FactoryIdx, NumProducts, I, [Next-Quantity | Rest]) :-
    Next is I + 1,
    factory(FactoryIdx, Products), member(Next-Limit, Products), !,
    Quantity in {0, Limit},
    generate_list_factory(FactoryIdx, NumProducts, Next, Rest).
generate_list_factory(FactoryIdx, NumProducts, I, [Next-0 | Rest]) :-
    Next is I + 1,
    generate_list_factory(FactoryIdx, NumProducts, Next, Rest).

generate_list(NumFactories, _NumProducts, NumFactories, []).
generate_list(NumFactories, NumProducts, I, [Factory | Rest]) :-
    Next is I + 1,
    generate_list_factory(Next, NumProducts, 0, Factory), % Since factories are 1 indexed instead of zero indexed, we can use Next to pass that index
    generate_list(NumFactories, NumProducts, Next, Rest).

get_quantities([], []).
get_quantities([_Product-Quantity | Rest], [Quantity | RestQuantities]) :-
    get_quantities(Rest, RestQuantities).


total_quantity(_Product, [], 0).
total_quantity(Product, [FactoryProd | Rest], TotalQuantity) :-
    member(Product-Quantity, FactoryProd),
    TotalQuantity #= Quantity + RestQuantity,
    total_quantity(Product, Rest, RestQuantity).

restrict_limits(0, _Production).
restrict_limits(Product, Production) :-
    product(Product, _Costs, _SellPrice, (Min, Max)),
    total_quantity(Product, Production, TotalQuantity),
    TotalQuantity #>= Min #/\ TotalQuantity #=< Max,
    NextProduct is Product - 1,
    restrict_limits(NextProduct, Production).

print_production([]).
print_production([Product-Quantity | Rest]) :-
    write('Product '), write(Product), write(': '), write(Quantity), nl,
    print_production(Rest).

print_results(_Factory, []).
print_results(Factory, [FactoryProd | Rest]) :-
    write('Factory '), write(Factory), nl,
    print_production(FactoryProd), nl,
    Next is Factory + 1,
    print_results(Next, Rest).
    

factory_algorithm :-
    factories(NumFactories),
    products(NumProducts),

    generate_list(NumFactories, NumProducts, 0, Production),
    restrict_limits(NumProducts, Production),

    calculate_profit(NumFactories, Production, Profit),
    
    append(Production, ProductionFlat),
    get_quantities(ProductionFlat, Quantities),

    labeling([maximize(Profit)], Quantities),
    print_results(1, Production),
    write('Total Profit: '), write(Profit), nl.


