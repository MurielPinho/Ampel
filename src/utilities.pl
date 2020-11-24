/* Get the gameboard of the current state */
getGameBoard([H | _T], GameBoard) :-
        GameBoard = H.

/* Get player's pieces info */
playerPieces([Color, Pieces], Color, Pieces).
getPlayerInfo([_GameBoard, _Score, Player1, _Player2], 0, Color, Pieces) :-
        playerPieces(Player1, Color, Pieces).
getPlayerInfo([_GameBoard, _Score, _Player1, Player2], 1, Color, Pieces) :-
        playerPieces(Player2, Color, Pieces).

/* Set new updated player pieces [state, player, newpieces, newstate]*/
setPlayerPieces(GameState, Player, NewPieces, NewState) :-
        Index is Player + 2,
        replaceInList(GameState, Index, NewPieces, NewState).

/* Set the gameboard of the current state */
setGameBoard([_H | T], GameBoard, [GameBoard|T]).

/* Get current value on postion [Row, Col] at the board */      
getValueBoard(GameBoard,Value, Row, Col) :-
    manageColumn(TempCol),
    manageRow(TempRow),
    % Validate selection
    verifyNotBoard(TempRow, TempCol, IsBoard),
    (
        IsBoard == 0 ->
            convertPyramid(TempRow,TempCol,Row,Col),
            getValueFromMatrix(GameBoard,Row,Col,Value)
            ;
            write('  ERROR: This option is not valid!'), nl,
            getValueBoard(GameBoard,Value, Row, Col)
    ).
    


/* Replace a value in the position [Row,Col] at the board*/
replaceInList([_H|T], 0, Value, [Value|T]).

replaceInList([H|T], Index, Value, [H|TNew]) :-
        Index > 0,
        Index1 is Index - 1,
        replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 0, Column,Value, [HNew|T]) :-
        replaceInList(H, Column, Value, HNew).

replaceInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
        Row > 0,
        Row1 is Row - 1,
        replaceInMatrix(T, Row1, Column, Value, TNew).


/* Get a value from the position [Row,Col] at the board*/
getValueFromList([H|_T], 0, Value) :-
        Value = H.

getValueFromList([_H|T], Index, Value) :-
        Index > 0,
        Index1 is Index - 1,
        getValueFromList(T, Index1, Value).

getValueFromMatrix([H|_T], 0, Column, Value) :-
        getValueFromList(H, Column, Value).

getValueFromMatrix([_H|T], Row, Column, Value) :-
        Row > 0,
        Row1 is Row - 1,
        getValueFromMatrix(T, Row1, Column, Value).

/* Clear the screen to display less information */
clear :-
        write('\33\[2J').

convertPyramid(TempRow,TempCol,Row,Col) :-
        Row is TempRow,
        Temp1 is 11 - TempRow - 1,
        Temp2 is TempCol -  Temp1, nl,
        Col is Temp2 // 2.