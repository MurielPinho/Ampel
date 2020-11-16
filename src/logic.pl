/*Initial logic to add yellow pieces*/
initialize(NewGameState) :-
    % Initialize board
    initialState(GameState),

    % Start setting yellow pieces on the board
    setYellowPiece(GameState, NewGameState, 4),
    displayGame(NewGameState,'Player 2').


/* Loop to add N yellow pieces to the board */
setYellowPiece(GameState, NewGameState, 0) :-
    NewGameState = GameState.

setYellowPiece(GameState, NewGameState, N) :-
    N > 0,
    N1 is N - 1,
    X is mod(N, 2),
    (
    0 is mod(N, 2) -> % if(0 == N % 2)
    displayGame(GameState, 'Player 1')
    ; % else
    displayGame(GameState, 'Player 2')
    ),
    nl,
    getGameBoard(GameState, GameBoard),

    % Player chooses tile to put yellow piece
    selectTile(GameBoard, Tile, Row, Col),
    % TODO check if tile is not on the edge
    replaceInMatrix(GameBoard, Row, Col, 'yellow', NewGameBoard),

    % Update GameState
    setGameBoard(GameState, NewGameBoard, NextGameState),
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
