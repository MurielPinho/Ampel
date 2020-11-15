/*Initial functions*/
initialize :-
    % Initialize board
    initialState(GameState),

    % Start setting yellow pieces on the board
    displayGame(GameState,'Player 1'),

    setYellowPiece(GameState, NewGameState),
    displayGame(NewGameState,'Player 2').



setYellowPiece(GameState, NewGameState) :-
    getGameBoard(GameState, GameBoard),

    % Player chooses tile to put yellow piece
    selectTile(GameBoard, Tile, Row, Col),
    % TODO check if tile is not on the edge
    replaceInMatrix(GameBoard, Row, Col, 'yellow', NewGameBoard),

    % Update GameState
    setGameBoard(GameState, NewGameBoard, NewGameState).


/* AUX FUNCTIONS */
selectPiece(GameBoard, Value, Row, Col) :-
    getValueBoard(GameBoard, NewValue, Row, Col),
    validateValue(NewValue, Value, GameBoard).


selectTile(GameBoard, Tile, Row, Col) :-
    getValueBoard(GameBoard, NewTiles, Row, Col),
    validateTile(NewTiles, Value, GameBoard).


getValueBoard(GameBoard,Value, Row, Col) :-
    manageColumn(Col),
    manageRow(Row),
    getValueFromMatrix(GameBoard,Row,Col,Value).
