
bought(joao, honda).
bought(joao, uno).
year(honda, 1997).
year(uno, 1998).
value(honda, 20000).
value(uno, 7000).

can_sell(Person, Car, CurrentYear) :-
    bought(Person, Car),
    year(Car, PurchaseYear), CurrentYear - PurchaseYear =< 10,
    value(Car, Value), Value < 10000.