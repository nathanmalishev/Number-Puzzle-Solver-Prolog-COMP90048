%% COMP30022 Declaritive Programming
%% Nathan Malishev - 637 410

%% To solve small mathematical number puzzles. The number puzzle can be described as a grid of 
%%squares, each to be filled with a single digit 1-9 satisfying the following constraints:
%%     -Each row & each column have no repeated digits
%%     -all squares on the diagonal line form the upper left to lower right contain the same values
%%     -The heading of each row and column hold either the sum or the product of all the 
%%           digits in that row or column

%% An Example puzzle              The Puzzle solved  

%%     14 | 10 | 35                  | 14 |10 | 35
%% 14 |   |    |                  14 | 7  | 2 | 1
%% 15 |   |    |                  15 | 3  | 7 | 5
%% 28 |   |    |                  28 | 4  | 1 | 7

%% Note: the row and column headings are given and do not have any constraints.

%% The program was to be able 2x2,3x3,4x4 puzzles.

%% My appraoch, was to check each condition make sure they were valid & then label each Row.
%% This worked well as i put domain limits initially in functions like sum_list & product_list
%% So backtracking was not costly and my solution was extremely effiecent.
%% Possible improvements, would be to make all the valid checking functions just take in the puzzle
%% My current solutions, each valid checking constraint requires a different argument
%% Things to note if the constraints for Rows & columns change so will my solution, as
%% vaild_columns just transposes the puzzle then applies valid_rows. 

:- ensure_loaded(library(clpfd)).


%Puzzle_solution 
% @arg - [[row1],[row2]..[rowN]]
% Takes in an array of N row arrays
%for eg the example puzzle [[0,14,10,35],[14,_,_,_],[15,_,_,_],[28,_,_,_]]
puzzle_solution([HeadPuzzle | TailPuzzle]):-
    validDiagonal(TailPuzzle,1,_),
    validRows(TailPuzzle),
    validColumns([HeadPuzzle | TailPuzzle]),
    %map label accross every row & assign variables
    maplist(label,[HeadPuzzle|TailPuzzle]).


%validDiagonal
% @arg1 - Tail of the puzzle, first row doesn't have a diagonal that counts!
% @arg2 - N the index of diagonal in a given array (Start with N=1)
% @arg3 - The diagonal value
validDiagonal([], _,_).
validDiagonal( [Head|TailPuzzle] , N, Diagonal):-
    %retieve what the diagonal value should be & see if it holds
    getElemByIndex( Head , N , Diagonal),
    N0 #= N+1,
    validDiagonal(TailPuzzle, N0, Diagonal).


%getElemByIndex
% @arg1 - Row array
% @arg2 - The index of the item we want
% @arg3 - The Elem itselfs
getElemByIndex( [H|_],0,H). % if we get to zero we have found our Elem
getElemByIndex( [Head|Tail], Count0 ,Elem):-
    Count #= Count0-1,
    getElemByIndex( Tail, Count,Elem).


%validColumns
% @arg1 - takes in whole puzzle
validColumns([]).
validColumns([Head | Tail]):-
    % transpose the columns into rows
    transpose([Head|Tail],[_|TransposedPuzzle]),
    %take the tail of the transposal & now treat as rowss
    validRows(TransposedPuzzle).


%validRows
% @arg1 - Tail of puzzle (as row1 headers don't follow constraints)
validRows([]).
validRows([List|Tail]):-
    validRow(List),
    all_distinctExH(List),
    validRows(Tail).


%all_distinctExH - checks if tail is distinct (Header does not follow constraints)
all_distinctExH([Head|Tail]):-
    all_distinct(Tail).


%validRow - checks if the row follows the contraints 
% arg1 - row
validRow([Elem|Tail]):-
    sumList(Tail,Elem);
    productList(Tail,Elem).


%sumList - sums a list and only lets our domain be between 1-9 as listed in constraintss
sumList([],0).
sumList([H|T],Sum):-
    sumList(T,Rest),
    H #< 10,
    H #> 0,
    Sum #= H+Rest.


%productList - takes the product of a list and only lets our domain be between 1-9 as in constraints
productList([],1).
productList([H|T],Sum):-
    productList(T,Rest),
    H #< 10,
    H #> 0,
    Sum #= H*Rest.