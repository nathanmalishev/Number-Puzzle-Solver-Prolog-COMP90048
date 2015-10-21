%%


:- ensure_loaded(library(clpfd)).

puzzle_solution([HeadPuzzle | TailPuzzle]):-
    validDiagonal(TailPuzzle,1,_),
    validRows(TailPuzzle),
    validColumns([HeadPuzzle | TailPuzzle]),
    maplist(label,[HeadPuzzle|TailPuzzle]).

validDiagonal([], _,_).
validDiagonal( [Head|TailPuzzle] , N, Diagonal):-
    getElemByIndex( Head , N , Diagonal),
    N0 #= N+1,
    validDiagonal(TailPuzzle, N0, Diagonal).

getElemByIndex( [H|_],0,H).
getElemByIndex( [Head|Tail], Count0 ,Elem):-
    Count #= Count0-1,
    getElemByIndex( Tail, Count,Elem).

validColumns([]).
validColumns([Head | Tail]):-
    transpose([Head|Tail],[_|TransposedPuzzle]),
    validRows(TransposedPuzzle).

validRows([]).
validRows([List|Tail]):-
    validRow(List),
    all_distinctExH(List),
    validRows(Tail).

all_distinctExH([Head|Tail]):-
    all_distinct(Tail).

validRow([Elem|Tail]):-
    sumList(Tail,Elem);
    productList(Tail,Elem).

sumList([],0).
sumList([H|T],Sum):-
    sumList(T,Rest),
    H #< 10,
    H #> 0,
    Sum #= H+Rest.

productList([],1).
productList([H|T],Sum):-
    productList(T,Rest),
    H #< 10,
    H #> 0,
    Sum #= H*Rest.


    