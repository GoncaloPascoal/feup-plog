
:- dynamic played/4.

player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

game('5 ATG', [action, adventure, openworld, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).


% QUESTION 1

achievedALot(Player) :-
    played(Player, _Game, _Hours, Percentage),
    Percentage >= 80.

% QUESTION 2

isAgeAppropriate(Player, Game) :-
    player(Player, _, Age),
    game(Game, _, AgeLimit),
    Age >= AgeLimit.

% QUESTION 3

timePlayingGames(Player, Games, ListOfTimes, SumTimes) :-
    timePlayingGames(Player, Games, ListOfTimes, 0, SumTimes).

timePlayingGames(_, [], [], Acc, Acc).
timePlayingGames(Player, [Game | RestGames], [Hours | Rest], Acc, SumTimes) :-
    played(Player, Game, Hours, _), !,
    NewAcc is Acc + Hours,
    timePlayingGames(Player, RestGames, Rest, NewAcc, SumTimes).

timePlayingGames(Player, [_Game | RestGames], [0 | Rest], Acc, SumTimes) :-
    timePlayingGames(Player, RestGames, Rest, Acc, SumTimes).

% QUESTION 4

listGamesOfCategory(Cat) :-
    game(Game, Categories, Age),
    member(Cat, Categories),
    write(Game), write(' ('), write(Age), write(')'), nl,
    fail.
listGamesOfCategory(_) :- !.

% QUESTION 5

updatePlayer(Player, Game, Hours, Percentage) :-
    retract(played(Player, Game, OldHours, OldPercentage)), !,
    NewHours is OldHours + Hours, NewPercentage is OldPercentage + Percentage,
    assert(played(Player, Game, NewHours, NewPercentage)).

updatePlayer(Player, Game, Hours, Percentage) :-
    assert(played(Player, Game, Hours, Percentage)).

% QUESTION 6

fewHours(Player, Games) :-
    fewHours(Player, [], Games).
    
fewHours(Player, Acc, Games) :-
    played(Player, Game, Hours, _),
    Hours < 10,
    \+ member(Game, Acc),
    fewHours(Player, [Game | Acc], Games).

fewHours(_Player, Acc, Acc).

% QUESTION 7

isInRange(Player, MinRange, MaxRange) :-
    player(Player, _, Age),
    Age >= MinRange, Age =< MaxRange.

ageRange(MinRange, MaxRange, Players) :-
    findall(P, isInRange(P, MinRange, MaxRange), Players).

% QUESTION 8

sumAges(L, Sum) :-
    sumAges(L, 0, Sum).

sumAges([], Acc, Acc).
sumAges([P | Rest], Acc, Sum) :-
    player(_, P, Age),
    NewAcc is Acc + Age,
    sumAges(Rest, NewAcc, Sum).

playsGame(Player, Game) :-
    played(Player, Game, _, _).

ageRange(Game, AverageAge) :-
    bagof(P, playsGame(P, Game), Players),
    sumAges(Players, Sum),
    length(Players, NPlayers),
    AverageAge is Sum / NPlayers.

% QUESTION 9

effectiveness(Player, Game, Effectiveness) :-
    played(Player, Game, Hours, Percentage),
    Effectiveness is Percentage / Hours.

reverseList(L, R) :-
    reverseList(L, [], R).
reverseList([], Acc, Acc).
reverseList([H | T], Acc, R) :-
    reverseList(T, [H | Acc], R).

getEffective([], _, []).
getEffective([E-P | Rest], Max, [P | RestEff]) :-
    E =:= Max, !,
    getEffective(Rest, Max, RestEff).
getEffective(_, _, []).

mostEffectivePlayers(Game, Players) :-
    setof(E-P, effectiveness(P, Game, E), S),
    reverseList(S, RS),
    RS = [Max-_ | _],
    getEffective(RS, Max, Players).

% QUESTION 10

/*

Given a player X, the predicate succeeds if the player hasn't played a game that isn't appropriate for their age. A better name for the predicate would be playsOnlyAgeAppropriate(?X).

*/
