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


% :- dynamic on/2.
% :- dynamic above/2.
% :- dynamic under/2.
% :- dynamic below/2.

% on(large_pillow, bed1).
% on(small_pillow, large_pillow).
% on(key, small_pillow).

% under(bed1, large_pillow).
% under(large_pillow, small_pillow).
% under(small_pillow, key).
% under(plant, bed1).

% above(X, Z) :- on(X, Z).
% above(X, Z) :- on(X, Y), above(Y, Z).

% below(X,Z) :- under(X,Z).
% below(X,Z) :- under(X,Y), below(Y,Z).


% look_above :- location(X), position(Y), (furniture_pos(X, Y, Furniture) -> write('While looking above You can see:'), nl, 
%     (above(Item2, Furniture), write(' - '), write(Item2), nl ; write('nothing more.')) ; write('nothing.')
%     ; write('Nothing to inspect here.')).

% look_below :- location(X), position(Y), (furniture_pos(X, Y, Furniture) -> write('While looking below You can see:'), nl, 
%     (below(Item2, Furniture), write(' - '), write(Item2), nl ; write('nothing more.')) ; write('nothing.')
%     ; write('Nothing to inspect here.')).


% membership checking
list_member(X,[X|_]).
list_member(X,[_|TAIL]) :- list_member(X,TAIL).

% length calculation
list_length([],0).
list_length([_|TAIL],N) :- list_length(TAIL,N1), N is N1 + 1.

% element deletion
list_delete(X, [X], []).
list_delete(X,[X|L1], L1).
list_delete(X, [Y|L2], [Y|L1]) :- list_delete(X,L2,L1).
