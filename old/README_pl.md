# MIW: Prolog project documentation

## 1. Mapa

![Map](map.png "Map")

## 2. Dokumentacja

### Nawigacja

Mapa składa się z 4 pomieszczeń, 3 sypialni oraz jednego korytarza. Sypialnie dzielą się na 4 kafelki, natomiast korytarz na 3. Numeracja kafelków opisana jest na mapie.

- `go(Room)` $-$ predykat służący przemieszczaniu się między pokojami, pokoje muszą łączyć się ze sobą drzwiami.

- `walk(Tile)` $-$ predykat służący nawigacji po pokoju.

- `doors` $-$ informuje o pokojach, do których można w danej chwili przejść za pomocą go(Room).

- `pwd` $-$ wypisuje informację o aktualnej pozycji na mapie

- `look` $-$ wypisuje informację o meblu na aktualnym kafelku

- `look_above` $-$ wypisuje informację o rzeczach znajdujących się na meblu

- `look_below` $-$ wypisuje informację o rzeczach znajdujących się pod meblem.

- `traverse_room` $-$ automatyczne zwiedzenie pokoju, przejście po wszystkich kafelkach i spojrzenie się pod i nad kolejne meble.

- `pick_item` $-$ przenosi leżącą rzecz do ekwipunku. Przenosi najpierw rzecz z wierzchu, kolejne wołanie przenosi rzecz spod spodu.

- `escape` $-$ cel rozgrywki, wygrana następuje po wywołaniu w korytarzu, kiedy gracz posiada łom w ekwipunku.
