/*Initial functions*/
initialize :-
    initialState(GameState),
    displayGame(GameState,'Player 1'),
    getGameBoard(GameState, GameBoard),
    selectTile(GameBoard, Value).


selectPiece(GameBoard,Value) :-
    getValueBoard(GameBoard,NewValue),
    validateValue(NewValue,Value,GameBoard).


selectTile(GameBoard, Tile) :-
    getValueBoard(GameBoard,NewTiles),
    validateTile(NewTiles,Value,GameBoard).


getValueBoard(GameBoard,Value) :-
    manageColumn(Col),
    manageRow(Row),
    getValueFromMatrix(GameBoard,Row,Col,Value).
