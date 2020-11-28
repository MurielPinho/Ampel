/* Get the gameboard of the current state */
getGameBoard([H | _T], GameBoard) :-
        GameBoard = H.

getScore([_GameBoard, Score, _Player1, _Player2],GameScore) :-
        GameScore = Score.

setScore(GameState, NewScore, NewState) :-
        replaceInList(GameState, 1, NewScore, NewState).

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

piecesHor(GameBoard,Row,Col,NPieces) :-
        Row =< 10,
        Col =< 10,
        NextC is Col + 1,


        piecesHor(GameBoard,Row,NextC,TmpPieces),
        (
                (getValueFromMatrix(GameBoard,Row,Col,'red');getValueFromMatrix(GameBoard,Row,Col,'green');getValueFromMatrix(GameBoard,Row,Col,'yellow')),
                NPieces is TmpPieces + 1
                ;
                NPieces is TmpPieces
        ).

piecesHor(_,_,_,0).


piecesDiagR(GameBoard,Row,Col,NPieces) :-
        Row =< 10,
        Col =< 10,
        NextR is Row + 1,
        NextC is Col + 1,

        piecesDiagR(GameBoard,NextR,NextC,TmpPieces),
        (
                (getValueFromMatrix(GameBoard,Row,Col,'red');getValueFromMatrix(GameBoard,Row,Col,'green');getValueFromMatrix(GameBoard,Row,Col,'yellow')),
                NPieces is TmpPieces + 1
                ;
                NPieces is TmpPieces
        ).

piecesDiagR(_,_,_,0).

piecesDiagL(GameBoard,Row,Col,NPieces) :-
        Row =< 10,
        Col =< 10,
        NextR is Row + 1,


        piecesDiagL(GameBoard,NextR,Col,TmpPieces),
        (
                (getValueFromMatrix(GameBoard,Row,Col,'red');getValueFromMatrix(GameBoard,Row,Col,'green');getValueFromMatrix(GameBoard,Row,Col,'yellow')),
                NPieces is TmpPieces + 1
                ;
                NPieces is TmpPieces
        ).

piecesDiagL(_,_,_,0).



nPieces(GameBoard,_Row,Col,'NE',NPieces) :-
        NewRow is 0,
        NewCol is Col,
        piecesDiagL(GameBoard,NewRow,NewCol,NPieces).

nPieces(GameBoard,Row,Col,'NW',NPieces) :-
        NewRow is Row - Col,
        NewCol is 0,
        piecesDiagR(GameBoard,NewRow,NewCol,NPieces).

nPieces(GameBoard,Row,Col,'SE',NPieces) :-
        NewRow is Row - Col,
        NewCol is 0,
        piecesDiagR(GameBoard,NewRow,NewCol,NPieces).

nPieces(GameBoard,_Row,Col,'SW',NPieces) :-
        NewRow is 0,
        NewCol is Col,
        piecesDiagL(GameBoard,NewRow,NewCol,NPieces).

nPieces(GameBoard,Row,_Col,'E',NPieces) :-
        NewRow is Row,
        NewCol is 0,
        piecesHor(GameBoard,NewRow,NewCol,NPieces).

nPieces(GameBoard,Row,_Col,'W',NPieces) :-
        NewRow is Row,
        NewCol is 0,
        piecesHor(GameBoard,NewRow,NewCol,NPieces).

nPieces(_GameBoard,_Row,_Col,_,NPieces) :-
        NPieces = 0.

movePiece(GameBoard, CurrentRow, CurrentCol, FinalRow, FinalCol) :-
    nl, write('  Select a direction to move:'), nl,
    selectMoveOption(Direction),
    nl,
    nPieces(GameBoard, CurrentRow, CurrentCol, Direction, NPieces),
    calcPieceMovement(CurrentRow, CurrentCol, Direction, NPieces, NewRow, NewCol),
    ( NewRow > CurrentRow -> RowInc = 1 ; (NewRow < CurrentRow -> RowInc = -1 ; RowInc = 0)),
    ( NewCol > CurrentCol -> ColInc = 1 ; (NewCol < CurrentCol -> ColInc = -1 ; ColInc = 0)),
    CurrentRow1 is CurrentRow + RowInc, % Start at next position
    CurrentCol1 is CurrentCol + ColInc, % Start at next position
    checkMovePossible(GameBoard, CurrentRow1, NewRow, RowInc, CurrentCol1, NewCol, ColInc, Possible),
    (Possible == 1 -> FinalRow = NewRow, FinalCol = NewCol ;
    write('  Can\'t move in this direction. Try again.'),nl,
    movePiece(GameBoard, CurrentRow, CurrentCol, FinalRow, FinalCol)).

/* Checks if move is possible */
checkMovePossible(GameBoard, CurrentRow, _NewRow, 0, CurrentCol, _NewCol, 0, Possible) :-
        getValueFromMatrix(GameBoard, CurrentRow, CurrentCol, Value),
        (Value \= 'empty' -> Possible = 0 ; Possible = 1).
checkMovePossible(GameBoard, CurrentRow, NewRow, RowInc, CurrentCol, NewCol, ColInc, Possible) :-
        (CurrentRow == NewRow -> RowInc1 = 0 ; RowInc1 = RowInc),
        (CurrentCol == NewCol -> ColInc1 = 0 ; ColInc1 = ColInc),
        getValueFromMatrix(GameBoard, CurrentRow, CurrentCol, Value),
        CurrentRow1 is CurrentRow + RowInc,
        CurrentCol1 is CurrentCol + ColInc,
        (Value \= 'empty' -> Possible = 0 ; checkMovePossible(GameBoard, CurrentRow1, NewRow, RowInc1, CurrentCol1, NewCol, ColInc1, Possible)).


/* Get new coords for piece movement */
calcPieceMovement(Row, Col, 'E', TotalMovement, NewRow, NewCol) :-
        NewRow is Row,
        NewCol is Col + TotalMovement.

calcPieceMovement(Row, Col, 'W', TotalMovement, NewRow, NewCol) :-
        NewRow is Row,
        NewCol is Col - TotalMovement.

checkAmpelDLU(Board,Col,Row,Ampel,FinalBoard) :-
    P2Col is Col - 1,
    P2Row is Row - 1,
    P3Col is Col - 2,
    P3Row is Row - 2,
    getValueFromMatrix(Board,Row,Col,P1),
    getValueFromMatrix(Board,P2Row,P2Col,P2),
    getValueFromMatrix(Board,P3Row,P3Col,P3),
    ((P1 == 'red' , P2 == 'yellow' , P3 == 'green');(P1 == 'green' ,P2 == 'yellow' , P3 == 'red')),
            replaceInMatrix(Board, P3Row, P3Col, 'empty', TmpBoard),replaceInMatrix(TmpBoard, P2Row, P2Col, 'empty', NewBoard),
            replaceInMatrix(NewBoard, Row, Col, 'empty', FinalBoard),
            Ampel = 1
            ;
            Ampel = 0.


checkAmpelDLD(Board,Col,Row,Ampel,FinalBoard) :-
    P2Col is Col + 1,
    P2Row is Row + 1,
    P3Col is Col + 2,
    P3Row is Row + 2,
    getValueFromMatrix(Board,Row,Col,P1),
    getValueFromMatrix(Board,P2Row,P2Col,P2),
    getValueFromMatrix(Board,P3Row,P3Col,P3),
    ((P1 == 'red' , P2 == 'yellow' , P3 == 'green');(P1 == 'green' ,P2 == 'yellow' , P3 == 'red')),
            replaceInMatrix(Board, P3Row, P3Col, 'empty', TmpBoard),replaceInMatrix(TmpBoard, P2Row, P2Col, 'empty', NewBoard),
            replaceInMatrix(NewBoard, Row, Col, 'empty', FinalBoard),
            Ampel = 1
            ;
            Ampel = 0.


checkAmpelDRU(Board,Col,Row,Ampel,FinalBoard) :-
    P2Col is Col ,
    P2Row is Row - 1,
    P3Col is Col ,
    P3Row is Row - 2,
    getValueFromMatrix(Board,Row,Col,P1),
    getValueFromMatrix(Board,P2Row,P2Col,P2),
    getValueFromMatrix(Board,P3Row,P3Col,P3),
    ((P1 == 'red' , P2 == 'yellow' , P3 == 'green');(P1 == 'green' ,P2 == 'yellow' , P3 == 'red')),
            replaceInMatrix(Board, P3Row, P3Col, 'empty', TmpBoard),replaceInMatrix(TmpBoard, P2Row, P2Col, 'empty', NewBoard),
            replaceInMatrix(NewBoard, Row, Col, 'empty', FinalBoard),
            Ampel = 1
            ;
            Ampel = 0.


checkAmpelDRD(Board,Col,Row,Value,FinalBoard) :-
    P2Col is Col ,
    P2Row is Row + 1,
    P3Col is Col ,
    P3Row is Row + 2,
    getValueFromMatrix(Board,Row,Col,P1),
    getValueFromMatrix(Board,P2Row,P2Col,P2),
    getValueFromMatrix(Board,P3Row,P3Col,P3),
    ((P1 == 'red' , P2 == 'yellow' , P3 == 'green');(P1 == 'green' ,P2 == 'yellow' , P3 == 'red')),
            replaceInMatrix(Board, P3Row, P3Col, 'empty', TmpBoard),replaceInMatrix(TmpBoard, P2Row, P2Col, 'empty', NewBoard),
            replaceInMatrix(NewBoard, Row, Col, 'empty', FinalBoard),
            Value = 1
            ;
            Value = 0.


checkAmpelHR(Board,Col,Row,Ampel,FinalBoard) :-
    P2Col is Col + 1,
    P2Row is Row ,
    P3Col is Col + 2,
    P3Row is Row ,
    getValueFromMatrix(Board,Row,Col,P1),
    getValueFromMatrix(Board,P2Row,P2Col,P2),
    getValueFromMatrix(Board,P3Row,P3Col,P3),
    ((P1 == 'red' , P2 == 'yellow' , P3 == 'green');(P1 == 'green' ,P2 == 'yellow' , P3 == 'red')),
            replaceInMatrix(Board, P3Row, P3Col, 'empty', TmpBoard),replaceInMatrix(TmpBoard, P2Row, P2Col, 'empty', NewBoard),
            replaceInMatrix(NewBoard, Row, Col, 'empty', FinalBoard),
            Ampel = 1
            ;
            Ampel = 0.


checkAmpelHL(Board,Col,Row,Ampel,FinalBoard) :-
    P2Col is Col - 1,
    P2Row is Row ,
    P3Col is Col - 2,
    P3Row is Row ,
    getValueFromMatrix(Board,Row,Col,P1),
    getValueFromMatrix(Board,P2Row,P2Col,P2),
    getValueFromMatrix(Board,P3Row,P3Col,P3),
    ((P1 == 'red' , P2 == 'yellow' , P3 == 'green');(P1 == 'green' ,P2 == 'yellow' , P3 == 'red')),
            replaceInMatrix(Board, P3Row, P3Col, 'empty', TmpBoard),replaceInMatrix(TmpBoard, P2Row, P2Col, 'empty', NewBoard),
            replaceInMatrix(NewBoard, Row, Col, 'empty', FinalBoard),
            Ampel = 1
            ;
            Ampel = 0.
