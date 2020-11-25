/* reconsult('p.pl'). play.
*/


/*Displays the game, including the score, board and pieces*/
displayGame([GameBoard,GameScore|GameInfo],Player) :-
    printHeader(GameScore,Player),
    printMatrix(GameBoard, 1),
    printFooter(GameInfo).
printMatrix([], 12).


/*Prints a matrix using recursion*/
printMatrix([Head|Tail], N) :-
    border('v',VerticalBorder),
    border(N,HorizontalBorder),
    indice(N, I),
    write(I),
    N1 is N + 1,
    printLine(Head),
    write(VerticalBorder),nl,
    write(HorizontalBorder),
    nl,
    printMatrix(Tail, N1).
printLine([]).

/*Prints a line from a matrix*/
printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    write(' '),
    printLine(Tail).

/*Prints the header from the board, with current player and score. */
printHeader(GameScore,Player):-
    border('v',VerticalBorder),
    border('t',TopBorder),
    border('m1',Middle1Border),
    border('m2',Middle2Border),
    border('i',Indice),
    nl,
    write(TopBorder),
    write('\n  '),
    write(VerticalBorder),
    write('\tTurn: Player '),
    PlayerNum is Player + 1,
    write(PlayerNum),
    write('\t'),
    write('     Score[P1,P2]:'),
    write(GameScore),
    write('\t'), write(VerticalBorder), nl ,
    write(Middle1Border),nl,
    write(Indice), nl,
    write(Middle2Border),nl.



/*Prints the Board footer that contains the player pieces*/
printFooter([Player1,Player2]) :-
    % Define unicode chars
    border('v',VerticalBorder),
    border('m3',MiddleBorder),
    border('b',BottomBorder),
    border('i',Indice),

    write(Indice), nl,


    write(MiddleBorder), nl,

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
    write(BottomBorder),
    write('\n').

