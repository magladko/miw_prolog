auto.
rower.
deskorolka.

%fakty
duze(auto).
maly(rower).
malutka(deskorolka).

szybszy(auto,rower).
szybszy(rower,deskorolka).

szybszy(X,Z):-szybszy(X,Y),szybszy(Y,Z).

%ciecie
b(d).
b(e).
b(f).
c(g).
c(h).
c(i).
% a(X, Y) :- b(X), !, c(Y).
% a(X, Y) :- b(X), c(Y).
a(X, Y) :- b(X), c(Y), !.

%dynamiczne
:- dynamic na_biurku/1.
na_biurku(pilka).
na_biurku(dlugopis).

:- dynamic w_kieszeni/1.
w_kieszeni(klucze).

zabierz(X):-retract(na_biurku(X)),assert(w_kieszeni(X)),write('zabrales przedmiot: '),nl,write(X).

rozmowa:-write('co chcesz zabrac z biurka?'),
    nl,
    read(X),
    na_biurku(X) ->  zabierz(X); write('nie ma tego na biurku').

ksiazka('fajny tytul', [autor1, 'autor 2']).
