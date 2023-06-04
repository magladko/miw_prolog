% neighbours(room1, room2).
% neighbours(room2, room1).
% neighbours(room2, room3).
% neighbours(room3, room2).

% neighbours(X, corridor) :- bedroom(X).
% neighbours(corridor, X) :- bedroom(X).

% neighbours(X, Y) :- neighbours(Y, X), !.

% % alias
% nbrs(X, Y) :- neighbours(X,Y).



% on_top(room1, pillow, bed).
% on_top(X, Y) :- X = pillow, Y = bed.
% bottom(X, Y) :- (furniture(X), item(Y)) -> contains(room3, X, Position) ; furniture(Y), item(X) -> 
% on_top(X,Y) :- item(X), furniture(Y), 
% on_top(plant, cabinet).
% on_top().

% contains(Room, Item, Position) :- contains(Room, Item, Position).
    % item(Item), contains(Room, clause(on_top(Y, Z), true), Position).


% contains(X, Y, Z) :- bedroom(X), Y = bed, Z = 3.
% contains(X, Y, Z) :- bedroom(X), Y = cabinet, Z = 4.
% contains(X, Y, Z) :- bedroom(X), Y = plant, Z = 4.
% contains(X, Y, Z) :- bedroom(X), Y = tv, Z = 2.
% contains(X, Y, Z) :- bedroom(X), Y = closet, Z = 1.
% contains(X, Y, Z) :- corridor(X), Y = rug, Z = 1; Z = 2; Z = 3.