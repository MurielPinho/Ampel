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
[empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty]],[0,0],[green,20],[red,20]]).


/*Returns the symbol to be displayed on board*/
symbol(blank,S) :- S=' '.
symbol(board,S) :- S='  '.
symbol(empty,S) :- atom_codes(S, [0x2502, 0x002E, 0x2502]).
symbol(yellow,S) :- atom_codes(S, [0x2502, 0x0059, 0x2502]).
symbol(green,S) :- atom_codes(S, [0x2502, 0x0047, 0x2502]).
symbol(red,S) :- atom_codes(S, [0x2502, 0x0052, 0x2502]).



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



/*Displays the game, including the score, board and pieces*/
displayGame([GameBoard,GameScore|GameInfo],Player) :-
    printHeader(GameScore,Player),
    printMatrix(GameBoard, 1),
    printFooter(GameInfo).
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
    write('  |\tTurn: Player '),
    PlayerNum is Player + 1,
    write(PlayerNum),
    write('\t _   Score[P1,P2]:'),
    write(GameScore),
    write('\t|\n').


/*Prints the Board footer that contains the player pieces*/
printFooter([Player1,Player2]) :-
    % Define unicode chars
    atom_codes(VerticalBorder, [0x2503]),

    write('  '),
    write(VerticalBorder),
    write(' |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U| '),
    write(VerticalBorder), nl,

    write('  '),
    write(VerticalBorder),
    write('---------------------------------------------'),
    write(VerticalBorder), nl,

    write('  '),
    write(VerticalBorder),
    write('  Player 1 Pieces          Player 2 Pieces\t'),
    write(VerticalBorder), nl,


    playerPieces(Player1, Player1Color, Player1Pieces),
    playerPieces(Player2, Player2Color, Player2Pieces),
    symbol(Player1Color, S1),
    symbol(Player2Color, S2),
    write('  '),
    write(VerticalBorder),
    write('  '),
    write(S1),
    write(':   '),
    write(Player1Pieces),
    write('\t     \t      '),
    write(S2),
    write(':   '),
    write(Player2Pieces),
    write('\t\t'),
    write(VerticalBorder),
    write('\n'),

    write('  +---------------------------------------------+\n').

