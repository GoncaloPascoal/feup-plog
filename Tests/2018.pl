
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

company('TAP', 'Tap Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A.', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

% QUESTION 1

short(Flight) :-
    flight(Flight, _, _, _, Duration, _),
    Duration < 90.

% QUESTION 2

shorter(Flight1, Flight2, Flight1) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 < Duration2, !.

shorter(Flight1, Flight2, Flight2) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration2 < Duration1, !.

% QUESTION 3

arrivalTime(Flight, ArrivalTime) :-
    flight(Flight, _, _, Departure, Duration, _),
    DepMinutes is Departure mod 100,
    Minutes is DepMinutes + Duration,
    Arrival is (Departure // 100 + Minutes // 60) * 100 + Minutes mod 60,
    ArrivalTime is Arrival mod 2400.

% QUESTION 4

operates(Company, Country) :-
    company(Company, _, _, _),
    flight(_, From, _, _, _, Company),
    airport(_, From, Country).

operates(Company, Country) :-
    company(Company, _, _, _),
    flight(_, _, To, _, _, Company),
    airport(_, To, Country).

countries(Company, ListOfCountries) :-
    countries(Company, [], ListOfCountries).

countries(Company, Acc, ListOfCountries) :-
    operates(Company, Country),
    \+ member(Country, Acc),
    countries(Company, [Country | Acc], ListOfCountries).

countries(_, Acc, Acc).

% QUESTION 5

toMinutes(Time, Minutes) :-
    Minutes is (Time // 100) * 60 + Time mod 100.

timeDiff(Time1, Time2, DiffMinutes) :-
    toMinutes(Time1, Minutes1), toMinutes(Time2, Minutes2),
    DiffMinutes is Minutes1 - Minutes2, DiffMinutes > 0, !.

timeDiff(Time1, Time2, DiffMinutes) :-
    toMinutes(Time1, Minutes1), toMinutes(Time2, Minutes2),
    DiffMinutes is Minutes1 - Minutes2 + 2400.

pairableFlights :-
    flight(Flight1, _, Mid, _, _, _),
    flight(Flight2, Mid, _, Departure2, _, _),
    arrivalTime(Flight1, Arrival1),
    timeDiff(Departure2, Arrival1, Diff),
    Diff >= 30, Diff =< 90,
    write(Mid), write(' - '), write(Flight1), write(' \\ '), write(Flight2), nl,
    fail.

pairableFlights.

% QUESTION 6


% QUESTION 7
:- use_module(library(lists)).

avgFlightLengthFromAirport(Airport, AvgLength) :-
    airport(_, Airport, _),
    findall(D, flight(_, Airport, _, _, D, _), L),
    calcAvgLength(Airport, L, AvgLength).

calcAvgLength(_, Acc, AvgLength) :-
    length(Acc, N), N > 0,
    sumlist(Acc, L), AvgLength is L / N.

% QUESTION 8


% QUESTION 9
