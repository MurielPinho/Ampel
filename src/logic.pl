/*Initial logic to add yellow pieces*/
initialize(NewGameState) :-
    % Initialize board
    initialState(GameState),

    % Start setting yellow pieces on the board
    setYellowPiece(GameState, NewGameState, 2),
    displayGame(NewGameState,'Player 2').


setYellowPiece(GameState, NewGameState, 0) :-
    NewGameState = GameState,
    write('HEY').

setYellowPiece(GameState, NewGameState, N) :-
    N > 0,
    N1 is N - 1,
    displayGame(GameState, 'Player 1'),
    getGameBoard(GameState, GameBoard),

    % Player chooses tile to put yellow piece
    selectTile(GameBoard, Tile, Row, Col),
    % TODO check if tile is not on the edge
    replaceInMatrix(GameBoard, Row, Col, 'yellow', NewGameBoard),

    % Update GameState
    setGameBoard(GameState, NewGameBoard, NextGameState),
    printMatrix(GameBoard, 1),
    setYellowPiece(NextGameState, NewGameState, N1).


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
