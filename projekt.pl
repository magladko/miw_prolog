write_list([Head|Tail]) :- write(Head), nl, write_list(Tail).

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

item(plant).
item(key).
item(crowbar).
item(large_pillow).
item(small_pillow).

:- dynamic on/2.
:- dynamic above/2.
:- dynamic under/2.
:- dynamic below/2.

on(large_pillow, bed1).
on(small_pillow, large_pillow).
on(key, small_pillow).

under(bed1, large_pillow).
under(large_pillow, small_pillow).
under(small_pillow, key).
under(plant, bed1).

above(X, Z) :- on(X, Z).
above(X, Z) :- on(X, Y), above(Y, Z).

below(X,Z) :- under(X,Z).
below(X,Z) :- under(X,Y), below(Y,Z).

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
pocket([mint]).
eq :- write('Your equipment:'), nl, pocket(X), write_list(X).

:- dynamic location/1.
:- retractall(location(_)).
location(corridor).
loc(X) :- location(X).
go(X) :- location(X) -> write('You are already here.') ; 
                        clause(location(CurrLoc), true), door(X, CurrLoc), retractall(location(_)), assert(location(X)), 
                        walk(1), write('You entered '), write(X), write('.').

:- dynamic position/1.
:- retractall(position(_)).
position(1).
pos(X) :- position(X).
walk(X) :- clause(location(CurrentLocation), true), room_tiles(CurrentLocation, X) -> retractall(position(_)), assert(position(X)).

pwd :- write('You are in '), location(X), write(X), write(' on tile '), position(Y), write(Y).

look :- write('You see '), location(X), position(Y), (furniture_pos(X, Y, Z) -> write(Z) ; write('nothing')), write('.').

look_above :- location(X), position(Y), (furniture_pos(X, Y, Furniture) -> write('While looking above You can see:'), nl, 
    (above(Item2, Furniture), write(' - '), write(Item2), nl ; write('nothing more.')) ; write('nothing.')
    ; write('Nothing to inspect here.')).

look_below :- location(X), position(Y), (furniture_pos(X, Y, Furniture) -> write('While looking below You can see:'), nl, 
    (below(Item2, Furniture), write(' - '), write(Item2), nl ; write('nothing more.')) ; write('nothing.')
    ; write('Nothing to inspect here.')).

grab :-
    location(CurrentLocation),
    position(CurrentPosition),
    furniture_pos(CurrentLocation, CurrentPosition, Furniture),
    above(Item, Furniture),
    retract(above(Item, Furniture)),
    assertz(on(Item, pocket)),
    write('You grabbed '), write(Item), write(' and put it in your pocket.'), nl.
      

doors :- write('You can go to: '), location(X), door(X, Y), write(Y).
