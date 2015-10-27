# Prolog Assignment
Assignment written for Declaritive Programming COMP90048 @ University Of Melbourne
By Nathan Malishev

Spec:
To solve small mathematical number puzzles. The number puzzle can be described as a grid of squares, each to be filled with a single digit 1-9 satisfying the following constraints:
<ol>
	<li>Each row & each column have no repeated digits</li>
	<li>all squares on the diagonal line form the upper left to lower right contain the same values</li>
	<li>The heading of each row and column hold either the sum or the product of all the digits in that row or column</li>
	</ol>

An Example puzzle               

| 0  | 14 | 10 | 35 |          
|----|----|----|----|                             
| 14 |    |    |    |          
| 15 |    |    |    |           
| 28 |    |    |    |      

The Puzzle solved 

| 0  | 14 | 10 | 35 |          
|----|----|----|----|                             
| 14 |  7 | 2  | 1  |          
| 15 |  3 | 7  | 5  |           
| 28 |  4 | 1  | 7  | 

Note: the row and column headings are given and do not have any constraints.

The program was to be able 2x2,3x3,4x4 puzzles.

How to Run:
test cases (numbers\_test.pl) & driver were provided (prologtest.pl). When running make sure you load in numbers\_test.pl & numbers.pl then execute do\_tests, which will run the test cases.


