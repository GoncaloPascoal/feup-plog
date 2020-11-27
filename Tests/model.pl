
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

% QUESTION 1

madeItThrough(Participant) :-
	performance(Participant, Times),
	member(120, Times).

% QUESTION 2

my_nth1(1, [X | _T], X).
my_nth1(N, [_H | T], X) :-
    N > 1, N1 is N - 1,
    my_nth1(N1, T, X).

juriTimes(Participants, JuriMember, Times, Total) :-
    juriTimes(Participants, JuriMember, 0, Times, Total).

juriTimes([], _JuriMember, Total, [], Total).
juriTimes([Participant | RestP], JuriMember, Acc, [Time | RestT], Total) :-
    performance(Participant, Times),
    my_nth1(JuriMember, Times, Time),
    NextAcc is Acc + Time,
    juriTimes(RestP, JuriMember, NextAcc, RestT, Total).

% QUESTION 3

patientJuri(JuriMember) :-
    performance(First, FirstP), performance(Second, SecondP), First =\= Second,
    my_nth1(JuriMember, FirstP, 120), my_nth1(JuriMember, SecondP, 120).

% QUESTION 4

sum_list(L, Sum) :-
    sum_list(L, 0, Sum).

sum_list([], Acc, Acc).
sum_list([H | T], Acc, Sum) :-
    NextAcc is Acc + H,
    sum_list(T, NextAcc, Sum).

get_best(P1, _P2, Total1, Total2, P1) :- Total1 > Total2.
get_best(_P1, P2, Total1, Total2, P2) :- Total2 > Total1.

bestParticipant(P1, P2, P) :-
    performance(P1, Times1), performance(P2, Times2),
    sum_list(Times1, Total1), sum_list(Times2, Total2),
    Total1 =\= Total2,
    get_best(P1, P2, Total1, Total2, P).

% QUESTION 5

allPerfs :-
    participant(P, _I, Perf), performance(P, Times),
    write(P:Perf:Times), nl,
    fail.
allPerfs :-
    !.

% QUESTION 6

no_button([]).
no_button([120 | Rest]) :-
    no_button(Rest).

successful(Participant) :-
    performance(Participant, Times),
    no_button(Times).

nSuccessfulParticipants(T) :-
    bagof(P, sucessful(P), L), length(L, T).

% QUESTION 7

include_fans(_Idx, [], []).
include_fans(Idx, [120 | Rest], [Idx | OtherFans]) :-
    !, Next is Idx + 1,
    include_fans(Next, Rest, OtherFans).
include_fans(Idx, [_H | Rest], Fans) :-
    !, Next is Idx + 1,
    include_fans(Next, Rest, Fans).

get_fans(P, Fans) :-
    performance(P, Times),
    include_fans(1, Times, Fans).

juriFans(L) :-
    findall(P-F, get_fans(P, F), L).

% QUESTION 8

:- use_module(library(lists)).

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

invert_list(L, Inv) :-
    invert_list(L, [], Inv).
    
invert_list([], Temp, Temp).
invert_list([Head | Tail], Temp, Inv) :-
    invert_list(Tail, [Head | Temp], Inv).

nextPhase(N, Participants) :-
    setof(Total-Id-Perf, eligibleOutcome(Id, Perf, Total), S),
    invert_list(S, SI),
    append(Participants, _Rest, SI),
    length(Participants, N).

% QUESTION 11

impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

impose_restrictions(0, _).
impose_restrictions(N, L) :-
    impoe(N, L),
    Next is N - 1,
    impose_restrictions(Next, L).

langford(N, L) :-
    Length is 2 * N,
    length(L, Length),
    impose_restrictions(N, L).
    