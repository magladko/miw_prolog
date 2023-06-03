room1.
room2.
room3.

bedroom(room1).
bedroom(room2).
bedroom(room3).

corridor.

corridor(corridor).
% corridor(1).
% corridor(2).
% corridor(3).

room(X) :- bedroom(X).
room(corridor).

% neighbours(room1, room2).
% neighbours(room2, room1).
% neighbours(room2, room3).
% neighbours(room3, room2).

% neighbours(X, corridor) :- bedroom(X).
% neighbours(corridor, X) :- bedroom(X).

% % alias
% nbrs(X, Y) :- neighbours(X,Y).

door(X, Y) :- bedroom(X), corridor(Y) ; bedroom(Y), corridor(X).
% door(X, Y) :- bedroom(Y), corridor(X).

:- dynamic location/1.
location(corridor).
loc(X) :- location(X).
go(X) :- room(X), clause(location(CurrentLocation), true), corridor(CurrentLocation) -> retractall(location(_)), assert(location(X)), walk(1) ; 
                                                                                        corridor(X), retractall(location(_)), assert(location(X)), walk(1). %TODO: walk out in corridor's fragment

:- dynamic position/1.
position(1).
pos(X) :- position(X).
% walk(X) :- X > 0, location(corridor) -> findall(X, bedroom(X), Bedrooms), length(Bedrooms, Count), X =< Count ; X =< 4.
walk(X) :- X > 0, location(corridor) -> findall(Y, bedroom(Y), Bedrooms), length(Bedrooms, Count), X =< Count, retractall(position(_)), assert(position(X)) ; 
                                        not(location(corridor)), X =< 4, retractall(position(_)), assert(position(X)).

