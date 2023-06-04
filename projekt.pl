write_list([Head|Tail]) :- write(Head), nl, write_list(Tail).

reset :- retractall(pocket(_)), assert(pocket([])), retractall(location(_)), assert(location(corridor)), retractall(position(_)), assert(position(1)).

room1.
room2.
room3.

bedroom(room1).
bedroom(room2).
bedroom(room3).

bedroom_tiles(4).

corridor.
corridor(corridor).

room(X) :- bedroom(X) ; corridor(X).

room_tiles(X,Y) :- bedroom(X) -> Y > 0, Y =< 4 ; corridor(X) -> Y > 0, findall(Z, bedroom(Z), Bedrooms), length(Bedrooms, Count), Y =< Count.

door(room1, corridor).
door(corridor, room1).
door(room2, corridor).
door(corridor, room2).
door(room3, corridor).
door(corridor, room3).

bed(bed1).
bed(bed2).
bed(bed3).
cabinet(cabinet1).
cabinet(cabinet2).
cabinet(cabinet3).
tv(tv1).
tv(tv2).
tv(tv3).
closet(closet1).
closet(closet2).
closet(closet3).
rug(rug).

furniture(X) :- bed(X) ; cabinet(X) ; tv(X) ; closet(X) ; rug(X).

:- dynamic above/2.
:- dynamic below/2.

above(pillow, bed1).
above(cup, cabinet1).
above(plant, tv1).
above(book, closet1).
above(clock, bed2).
above(lamp, cabinet2).
above(artwork, tv2).
above(photo_frame, closet2).
above(mirror, bed3).
above(decorative_box, cabinet3).
above(calendar, tv3).
above(speaker, closet3).
above(hat, rug).

below(key, bed1).
below(book, cabinet1).
below(shoes, bed2).
below(basket, cabinet2).
below(coat, bed3).
below(gloves, cabinet3).
below(mug, rug).
below(crowbar, tv3).

furniture_pos(room1, 1, closet1).
furniture_pos(room1, 2, tv1).
furniture_pos(room1, 3, bed1).
furniture_pos(room1, 4, cabinet1).

furniture_pos(room2,1, closet2).
furniture_pos(room2,2, tv2).
furniture_pos(room2,3, bed2).
furniture_pos(room2,4, cabinet2).

furniture_pos(room3, 1, closet3).
furniture_pos(room3, 2, tv3).
furniture_pos(room3, 3, bed3).
furniture_pos(room3, 4, cabinet3).

furniture_pos(corridor, 1, rug).
furniture_pos(corridor, 2, rug).
furniture_pos(corridor, 3, rug).

:- dynamic pocket/1.
% :- retractall(pocket(_)).
pocket([]).
eq :- write('Your equipment:'), nl, pocket(X), write_list(X).

:- dynamic location/1.
location(corridor).
loc(X) :- location(X).
go(X) :- location(X) -> write('You are already here.') ; 
                        clause(location(CurrLoc), true), door(X, CurrLoc), retractall(location(_)), assert(location(X)), 
                        walk(1), write('You entered '), write(X), write('.'), !.

:- dynamic position/1.
position(1).
pos(X) :- position(X).
walk(X) :- clause(location(CurrentLocation), true), room_tiles(CurrentLocation, X) -> retractall(position(_)), assert(position(X)).

pwd :- write('You are in '), location(X), write(X), write(' on tile '), position(Y), write(Y).

look :- write('You see '), location(X), position(Y), (furniture_pos(X, Y, Z) -> write(Z) ; write('nothing')), write('.').

look_above :- location(X), position(Y), (furniture_pos(X, Y, Furniture) -> write('While looking above You can see '), 
    (above(Item2, Furniture) -> write(' - '), write(Item2) ; write('nothing.')), nl
    ; write('Nothing to inspect here.')).

look_below :- location(X), position(Y), (furniture_pos(X, Y, Furniture) -> write('While looking below You can see '), 
    (below(Item2, Furniture) -> write(' - '), write(Item2) ; write('nothing.')), nl
    ; write('Nothing to inspect here.')).

doors :- write('You can go to: '), location(X), door(X, Y), write(Y).

traverse_room :-
    location(Room),
    write('You are in '), write(Room), write('.'), nl,
    traverse_tiles(Room, 1).

traverse_tiles(Room, Tile) :-
    walk(Tile),
    write('You are on tile '), write(Tile), write('.'), nl,
    furniture_pos(Room, Tile, Furniture),
    write('You see '), write(Furniture), write('.'), nl,
    TileNext is Tile + 1,
    look_above,
    look_below,
    !,
    nl,
    traverse_tiles(Room, TileNext).

pick_up(Item) :-
    retract(pocket(Items)),
    asserta(pocket([Item|Items])),
    write('You picked up '), write(Item), write('.'), nl.

pick_item :-
    location(Location),
    position(Position),
    (above(Item, Furniture),
        clause(furniture_pos(Location, Position, Furniture), true),
        pick_up(Item),
        retract(above(Item, Furniture)),
        !
    ;
    below(Item, Furniture),
        clause(furniture_pos(Location, Position, Furniture), true),
        pick_up(Item),
        retract(below(Item, Furniture)),
        !
    ;
    write('There is no item to pick up here.')
    ).

escape :-
    location(corridor) ->
    (
        pocket(Items),
        (member(crowbar, Items) ->
        position(1),
        write('Congratulations! You have escaped! You win!'),
        nl
        ; !, write('The doors would not move...')))
        ; !, write('The door is in a corridor...'). 
