/* Get the gameboard of the current state */
getGameBoard([H | _T], GameBoard) :-
    GameBoard = H.

/* Return the scores from gamestate*/
getScore([_GameBoard, Score, _Player1, _Player2],GameScore) :-
    GameScore = Score.

/* Sets the scores for gamestate*/
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

/* Calculates the value for board */
value(GameState,Player,NPieces) :-
    getGameBoard(GameState,GameBoard),
    nPieces(GameBoard,0,0,'E',N0),
    nPieces(GameBoard,1,0,'E',N1),
    nPieces(GameBoard,2,0,'E',N2),
    nPieces(GameBoard,3,0,'E',N3),
    nPieces(GameBoard,4,0,'E',N4),
    nPieces(GameBoard,5,0,'E',N5),
    nPieces(GameBoard,6,0,'E',N6),
    nPieces(GameBoard,7,0,'E',N7),
    nPieces(GameBoard,8,0,'E',N8),
    nPieces(GameBoard,9,0,'E',N9),
    nPieces(GameBoard,10,0,'E',N10),
    NPieces is N0+N1+N2+N3+N4+N5+N6+N7+N8+N9+N10+Player.

/* Get User mode */
getUserMode(Mode) :-
    write('  Gamemode '),
    read(UserMode),
    ((UserMode < 0 ; UserMode > 3) -> write('Invalid option. Try again.'),nl, getUserMode(Mode) ; Mode = UserMode).

/* Get User difficulty */
getUserDifficulty(Difficulty) :-
    clear, printDifficulty,
    write('Select Difficulty '),
    read(UserDifficulty),
    ((UserDifficulty < 1 ; UserDifficulty > 2) -> write('Invalid option. Try again.'),nl, getUserDifficulty(Difficulty) ; Difficulty = UserDifficulty).

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

/* Calculates the number of pieces in a row on the board */
piecesHor(GameBoard,Row,Col,NPieces) :-
    Row =< 10, Row >= 0,
    Col =< 10, Col >= 0,
    NextC is Col + 1,

    piecesHor(GameBoard,Row,NextC,TmpPieces),
    (
        (getValueFromMatrix(GameBoard,Row,Col,'red');getValueFromMatrix(GameBoard,Row,Col,'green');getValueFromMatrix(GameBoard,Row,Col,'yellow')),
        NPieces is TmpPieces + 1
        ;
        NPieces is TmpPieces
    ).

piecesHor(_,_,_,0).

/* Calculates the number of pieces in a right diagonal on the board */
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

/* Calculates the number of pieces in a left diagonal on the board */
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


/* Calculates the number of pieces in the possible directions */
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

/* Places a piece on the board, validating the user's input*/
placePiece(GameBoard, Color, NewGameBoard) :-
    write('  Select tile to place your piece:'), nl,
    selectTile(GameBoard, Row, Col),
    replaceInMatrix(GameBoard, Row, Col, Color, UpdatedGameBoard),
    (checkAmpel(UpdatedGameBoard, Row, Col, _Ampel, _) ->
    write('  Can\'t make an Ampel while placing piece. Try again.'),nl,
    placePiece(GameBoard, Color, NewGameBoard)
    ;
    NewGameBoard = UpdatedGameBoard
    ).

/* Moves a pieces based on the Move received*/
move(GameState,[CurrentRow, CurrentCol,Direction,Color,Player],NextGameState) :-

    getGameBoard(GameState,GameBoard),
    nPieces(GameBoard, CurrentRow, CurrentCol, Direction, NPieces),
    calcPieceMovement(CurrentRow, CurrentCol, Direction, NPieces, DestRow, DestCol),
    ( DestRow > CurrentRow -> RowInc = 1 ; (DestRow < CurrentRow -> RowInc = -1 ; RowInc = 0)),
    ( DestCol > CurrentCol -> ColInc = 1 ; (DestCol < CurrentCol -> ColInc = -1 ; ColInc = 0)),

    NextRow is CurrentRow + RowInc,
    NextCol is CurrentCol + ColInc,
    getValueFromMatrix(GameBoard, NextRow, NextCol, Value),
    Value == 'empty' ,
    checkMovePossible(GameBoard, CurrentRow, DestRow, RowInc, CurrentCol, DestCol, ColInc, FinalRow, FinalCol),
    replaceInMatrix(GameBoard, CurrentRow, CurrentCol, 'empty', NewGameBoard),
    replaceInMatrix(NewGameBoard, FinalRow, FinalCol, Color, UpdatedGameBoard),
    (
    checkAmpel(UpdatedGameBoard,FinalCol, FinalRow, _Ampel, AmpelBoard) ->
        FinalGameBoard = AmpelBoard,
        updateAfterAmpel(GameState, Player, FinalGameState);
        FinalGameBoard = UpdatedGameBoard,
        FinalGameState = GameState
    ),
    setGameBoard(FinalGameState, FinalGameBoard, NextGameState).


/* Checks for possible moves */
checkMovePossible(_GameBoard, CurrentRow, _DestRow, 0, CurrentCol, _DestCol, 0, PossibleRow, PossibleCol) :-
    PossibleRow = CurrentRow,
    PossibleCol = CurrentCol.


/* Checks for possible moves */
checkMovePossible(GameBoard, CurrentRow, DestRow, RowInc, CurrentCol, DestCol, ColInc, PossibleRow, PossibleCol) :-
    NextRow is CurrentRow + RowInc, % Start at next position
    NextCol is CurrentCol + ColInc, % Start at next position

    (NextRow == DestRow -> RowInc1 = 0 ; RowInc1 = RowInc),
    (NextCol == DestCol -> ColInc1 = 0 ; ColInc1 = ColInc),

    getValueFromMatrix(GameBoard, NextRow, NextCol, Value),
    (
    Value \= 'empty' -> PossibleRow = CurrentRow, PossibleCol = CurrentCol ;
     checkMovePossible(GameBoard, NextRow, DestRow, RowInc1, NextCol, DestCol, ColInc1, PossibleRow, PossibleCol)
    ).


/* Get new coords for piece movement based on the destiny direction */
calcPieceMovement(Row, Col, 'E', TotalMovement, DestRow, DestCol) :-
    TmpDestRow is Row,
    TmpDestCol is Col + TotalMovement,
    ( TmpDestRow < 0 -> DestRow = 0; DestRow = TmpDestRow),
    ( TmpDestCol < 0 -> DestCol = 0; DestCol = TmpDestCol).

calcPieceMovement(Row, Col, 'W', TotalMovement, DestRow, DestCol) :-
    TmpDestRow is Row,
    TmpDestCol is Col - TotalMovement,
    ( TmpDestRow < 0 -> DestRow = 0; DestRow = TmpDestRow),
    ( TmpDestCol < 0 -> DestCol = 0; DestCol = TmpDestCol).

calcPieceMovement(Row, Col, 'NW', TotalMovement, DestRow, DestCol) :-
    TmpDestRow is Row - TotalMovement,
    TmpDestCol is Col - TotalMovement,
    ( TmpDestRow < 0 -> DestRow = 0; DestRow = TmpDestRow),
    ( TmpDestCol < 0 -> DestCol = 0; DestCol = TmpDestCol).

calcPieceMovement(Row, Col, 'SW', TotalMovement, DestRow, DestCol) :-
    TmpDestRow is Row + TotalMovement,
    TmpDestCol is Col,
    ( TmpDestRow < 0 -> DestRow = 0; DestRow = TmpDestRow),
    ( TmpDestCol < 0 -> DestCol = 0; DestCol = TmpDestCol).

calcPieceMovement(Row, Col, 'NE', TotalMovement, DestRow, DestCol) :-
    TmpDestRow is Row - TotalMovement,
    TmpDestCol is Col,
    ( TmpDestRow < 0 -> DestRow = 0; DestRow = TmpDestRow),
    ( TmpDestCol < 0 -> DestCol = 0; DestCol = TmpDestCol).

calcPieceMovement(Row, Col, 'SE', TotalMovement, DestRow, DestCol) :-
    TmpDestRow is Row + TotalMovement,
    TmpDestCol is Col + TotalMovement,
    ( TmpDestRow < 0 -> DestRow = 0; DestRow = TmpDestRow),
    ( TmpDestCol < 0 -> DestCol = 0; DestCol = TmpDestCol).

/* Check for ampel in the left upper diagonal of the board*/
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


/* Check for ampel in the left down diagonal of the board*/
checkAmpelDLD(Board,Col,Row,Ampel,FinalBoard) :-
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
        Ampel = 1
        ;
        Ampel = 0.


/* Check for ampel in the right upper diagonal of the board*/
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


/* Check for ampel in the right down diagonal of the board*/
checkAmpelDRD(Board,Col,Row,Value,FinalBoard) :-
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
        Value = 1
        ;
        Value = 0.


/* Check for ampel in the right horizontal of the board*/
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


/* Check for ampel in the left horizontal of the board*/
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
