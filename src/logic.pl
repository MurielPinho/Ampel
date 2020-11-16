%%%%%%%%%%%%%%%%%%
% Initialization %
%%%%%%%%%%%%%%%%%%

/*Initial logic to add yellow pieces*/
initialize(NewGameState, Player) :-
    % Number of yellow pieces to be placed
    N = 5,
    InitialPlayer = 0,

    % Initialize board
    initialState(GameState),

    % Start setting yellow pieces on the board
    setYellowPiece(GameState, InitialPlayer, NewGameState, N),

    % Next player will be mod(N, 2)
    Player is mod(N, 2).

/* Loop to add N yellow pieces to the board */
setYellowPiece(GameState, _Player, NewGameState, 0) :-
    clear,
    NewGameState = GameState.

setYellowPiece(GameState, Player, NewGameState, N) :-
    clear,
    N > 0,
    N1 is N - 1,

    % NextPlayer is mod(Player + 1, 2),
    NextPlayer is mod(Player + 1, 2),

    % Player chooses tile to put yellow piece
    displayGame(GameState, Player),
    getGameBoard(GameState, GameBoard),
    write('  Select empty tile to place a yellow piece:'), nl,
    selectTile(GameBoard, Tile, Row, Col), % TODO check if tile is not on the edge
    replaceInMatrix(GameBoard, Row, Col, 'yellow', NewGameBoard),

    % Update GameState
    setGameBoard(GameState, NewGameBoard, NextGameState),

    % Next player is the (current player + 1) mod 2
    setYellowPiece(NextGameState, NextPlayer, NewGameState, N1).



%%%%%%%%%%%%%%%%%%
% Initialization %
%%%%%%%%%%%%%%%%%%

/* Main Loop */
gameLoop(GameState, Player) :-
    displayGame(GameState, Player),
    write('Start main game loop').




%%%%%%%%%%%%%%%%%
% Aux Functions %
%%%%%%%%%%%%%%%%%

/* Get user input to select a tile */
selectTile(GameBoard, Tile, Row, Col) :-
    getValueBoard(GameBoard, NewTiles, Row, Col),
    validateTile(NewTiles, Value, GameBoard).

/* Get user input to select a piece */
selectPiece(GameBoard, Value, Row, Col) :-
    getValueBoard(GameBoard, NewValue, Row, Col),
    validateValue(NewValue, Value, GameBoard).

/* Get current value on postion [Row, Col] at the board */
getValueBoard(GameBoard,Value, Row, Col) :-
    manageColumn(Col),
    manageRow(Row),
    getValueFromMatrix(GameBoard,Row,Col,Value).