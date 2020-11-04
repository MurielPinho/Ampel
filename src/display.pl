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
[board,red,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board],
[empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty]],[0,0],[20,20,10],[20,20,10]]).


/*Returns the symbol to be displayed on board*/
symbol(blank,S) :- S=' '.
symbol(board,S) :- S='  '.
symbol(empty,S) :- S='|.|'.
symbol(yellow,S) :- S='|Y|'.
symbol(green,S) :- S='|G|'.
symbol(red,S) :- S='|R|'.


/*Returns the number indicator on the left of the board*/
indice(1, I)  :- I=' 1| '.
indice(2, I)  :- I=' 2| '.
indice(3, I)  :- I=' 3| '.
indice(4, I)  :- I=' 4| '.
indice(5, I)  :- I=' 5| '.
indice(6, I)  :- I=' 6| '.
indice(7, I)  :- I=' 7| '.
indice(8, I)  :- I=' 8| '.
indice(9, I)  :- I=' 9| '.
indice(10, I) :- I='10| '.
indice(11, I) :- I='11| '.


/*Initial functions*/
play :-
    initialState(GameState),
    display_game(GameState,'Player 1').


/*Displays the game, including the score, board and pieces*/
display_game([GameBoard,GameScore|GameInfo],Player) :-
    printHeader(GameScore,Player),
    printMatrix(GameBoard, 1),
    printFooter(GameInfo),
    selectPiece(GameBoard,Value).
printMatrix([], 12).


/*Prints a matrix using recursion*/
printMatrix([Head|Tail], N) :-
    indice(N, I),
    write(I),
    N1 is N + 1,
    printLine(Head),
    write(' |\n  |---------------------------------------------|\n'),
    printMatrix(Tail, N1).
printLine([]).

/*Prints a line from a matrix*/
printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    printLine(Tail).

/*Prints the header from the board, with current player and score. */
printHeader(GameScore,Player):-
    nl,
    write('  +---------------------------------------------+\n'),
    write('  | |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U| |\n'),
    write('  |---------------------------------------------|\n'),
    write('  |\tTurn: '),
    write(Player),
    write('\t _   Score[P1,P2]:'),
    write(GameScore),
    write('\t|\n').


/*Prints the Board footer that contains the player pieces*/
printFooter([Player1,Player2]) :-
    write('  | |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U| |\n'),
    write('  |---------------------------------------------|\n'),
    write('  |  Player 1 Pieces          Player 2 Pieces\t|\n'),
    write('  | [R,G,Y]:'),
    write(Player1),
    write('\t     [R,G,Y]:'),
    write(Player2),
    write('\t|\n'),
    write('  +---------------------------------------------+\n').
    
selectPiece(GameBoard,Value) :-
    getValueBoard(GameBoard,NewValue),
    validateValue(NewValue,Value,GameBoard).


getValueBoard(GameBoard,Value) :-
    manageColumn(Col),
    manageRow(Row),
    getValueFromMatrix(GameBoard,Row,Col,Value).


validateValue('green', Value, _GameBoard) :-
    Value = 'green'.

validateValue('red', Value, _GameBoard) :-
    Value = 'red'.

validateValue('yellow', Value, _GameBoard) :-
    Value = 'yellow'.
    
validateValue(_NewValue, Value, GameBoard) :-
    write('ERROR: This space doesnt contain a piece!\n'),
    selectPiece(GameBoard,Value).