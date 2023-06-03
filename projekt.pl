room1.
room2.
room3.

bedroom(room1).
bedroom(room2).
bedroom(room3).

bedroom_tiles(4).

furniture(bed).
furniture(cabinet).
furniture(tv).
furniture(closet).
furniture(plant).
furniture(rug).

% contains(X, Y, Z) :- room(X), furniture(Y), Z > 0, Z =< 4, .
% furniture(X, Y, Z) :- bedroom(X), .

corridor.

corridor(corridor).
corridor_tiles().
% corridor_tiles :- findall(X, bedroom(X), Bedrooms), length(Bedrooms, Count), retractall(corridor_tiles(_)), assert(corridor_tiles(Count)).

room(X) :- bedroom(X).
room(corridor).

room_tiles(X,Y) :- bedroom(X) -> Y > 0, Y =< 4 ; corridor(X) -> Y > 0, findall(Z, bedroom(Z), Bedrooms), length(Bedrooms, Count), Y =< Count.

% neighbours(room1, room2).
% neighbours(room2, room1).
% neighbours(room2, room3).
% neighbours(room3, room2).

% neighbours(X, corridor) :- bedroom(X).
% neighbours(corridor, X) :- bedroom(X).

% neighbours(X, Y) :- neighbours(Y, X), !.

% % alias
% nbrs(X, Y) :- neighbours(X,Y).

door(X, Y) :- bedroom(X), corridor(Y) ; bedroom(Y), corridor(X).

:- dynamic location/1.
location(corridor).
loc(X) :- location(X).
go(X) :- room(X), clause(location(CurrentLocation), true), corridor(CurrentLocation) -> retractall(location(_)), assert(location(X)), walk(1) ; 
                                                                                        corridor(X), retractall(location(_)), assert(location(X)), walk(1). %TODO: walk out in corridor's fragment

:- dynamic position/1.
position(1).
pos(X) :- position(X).
walk(X) :- clause(location(CurrentLocation), true), room_tiles(CurrentLocation, X) -> retractall(position(_)), assert(position(X)).
