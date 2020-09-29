pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(lamb, breitling).
team(besenyei, redbull).
team(chambliss, redbull).
team(maclean, mrt).
team(mangold, cobra).
team(jones, matador).
team(bonhomme, matador).

airplane(lamb, mx2).
airplane(besenyei, edge540).
airplane(chambliss, edge540).
airplane(maclean, edge540).
airplane(mangold, edge540).
airplane(jones, edge540).
airplane(bonhomme, edge540).

circuit(istanbul).
circuit(budapest).
circuit(porto).

winner(porto, jones).
winner(budapest, mangold).
winner(istanbul, mangold).

gates(istanbul, 9).
gates(budapest, 6).
gates(porto, 5).

winner_team(C, T) :- team(P, T), winner(C, P). 