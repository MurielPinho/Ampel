/*Declaration of a initial gamestate*/
initialState([[
[board,board,board,board,board,board,board,board,board,board,empty,board,board,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,board,board,empty,blank,empty,board,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,board,empty,blank,empty,blank,empty,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,empty,blank,empty,blank,empty,blank,empty,board,board,board,board,board,board,board],
[board,board,board,board,board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board,board,board,board,board],
[board,board,board,board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board,board,board,board],
[board,board,board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board,board,board],
[board,board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board,board],
[board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board],
[board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board],
[empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty]],[20,20,10],[20,20,10]]).

/*Declaration of a midgame gamestate*/
midState([[
[board,board,board,board,board,board,board,board,board,board,empty,board,board,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,board,board,empty,blank,empty,board,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,board,empty,blank,yellow,blank,empty,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,empty,blank,empty,blank,empty,blank,empty,board,board,board,board,board,board,board],
[board,board,board,board,board,board,red,blank,green,blank,empty,blank,yellow,blank,red,board,board,board,board,board,board],
[board,board,board,board,board,empty,blank,empty,blank,red,blank,empty,blank,green,blank,empty,board,board,board,board,board],
[board,board,board,board,empty,blank,empty,blank,red,blank,red,blank,yellow,blank,empty,blank,green,board,board,board,board],
[board,board,board,empty,blank,green,blank,yellow,blank,empty,blank,empty,blank,empty,blank,green,blank,empty,board,board,board],
[board,board,red,blank,empty,blank,empty,blank,empty,blank,red,blank,green,blank,red,blank,red,blank,empty,board,board],
[board,empty,blank,yellow,blank,empty,blank,empty,blank,empty,blank,green,blank,empty,blank,red,blank,empty,blank,empty,board],
[empty,blank,green,blank,empty,blank,red,blank,green,blank,empty,blank,red,blank,empty,blank,green,blank,red,blank,empty]],[13,15,7],[14,15,8]]).

/*Declaration of a final gamestate*/
finalState([[
[board,board,board,board,board,board,board,board,board,board,empty,board,board,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,board,board,empty,blank,empty,board,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,board,empty,blank,yellow,blank,empty,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,empty,blank,empty,blank,empty,blank,empty,board,board,board,board,board,board,board],
[board,board,board,board,board,board,red,blank,green,blank,empty,blank,empty,blank,red,board,board,board,board,board,board],
[board,board,board,board,board,empty,blank,empty,blank,red,blank,empty,blank,empty,blank,empty,board,board,board,board,board],
[board,board,board,board,empty,blank,empty,blank,red,blank,red,blank,yellow,blank,empty,blank,green,board,board,board,board],
[board,board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,green,blank,empty,board,board,board],
[board,board,red,blank,empty,blank,empty,blank,empty,blank,red,blank,green,blank,red,blank,red,blank,empty,board,board],
[board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,green,blank,empty,blank,red,blank,empty,blank,empty,board],
[empty,blank,empty,blank,empty,blank,red,blank,green,blank,empty,blank,red,blank,empty,blank,green,blank,red,blank,empty]],[11,15,7],[11,15,8]]).


/*Returns the symbol to be displayed on board*/
symbol(blank,S) :- S=' '.
symbol(board,S) :- S='  '.
symbol(empty,S) :- S='|.|'.
symbol(yellow,S) :- S='|Y|'.
symbol(green,S) :- S='|G|'.
symbol(red,S) :- S='|R|'.


/*Returns the number indicator on the left of the board*/
indice(1, I)  :- I=' 1|'.
indice(2, I)  :- I=' 2|'.
indice(3, I)  :- I=' 3|'.
indice(4, I)  :- I=' 4|'.
indice(5, I)  :- I=' 5|'.
indice(6, I)  :- I=' 6|'.
indice(7, I)  :- I=' 7|'.
indice(8, I)  :- I=' 8|'.
indice(9, I)  :- I=' 9|'.
indice(10, I) :- I='10|'.
indice(11, I) :- I='11|'.


/*Initial functions*/
play :-
initialState(GameState),
display_game(GameState,'Player 1').


/*Displays the game, including the board and pieces*/
display_game([GameBoard|GamePieces],Player) :-
    nl,
    write('    |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|  \n'),
    write('  +---------------------------------------------+\n'),
    write('  |  '),
    write(Player),
    write(' Turn       _                      |\n'),
    printMatrix(GameBoard, 1),
    write('  +---------------------------------------------+\n'),
    write('     Player 1 Pieces          Player 2 Pieces    \n'),
    printPieces(GamePieces).
printMatrix([], 12).


/*Prints a matrix using recursion*/
printMatrix([Head|Tail], N) :-
    indice(N, I),
    write(I),
    write(' '),
    N1 is N + 1,
    printLine(Head),
    write(' |'),
    write('\n  |---------------------------------------------|\n'),
    printMatrix(Tail, N1).
printLine([]).

/*Prints a line from a matrix*/
printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    printLine(Tail).



/*Print the numbers of pieces each player has*/
printPieces([Player1,Player2]) :-
write('    [R,G,Y]:'),
write(Player1),
write('       [R,G,Y]:'),
write(Player2).


/*Example for the midgame gamestate*/
playMid :-
midState(GameState),
display_game(GameState,'Player 2').

/*Example for the final gamestate*/
playFinal :-
finalState(GameState),
display_game(GameState,'Player 1').

