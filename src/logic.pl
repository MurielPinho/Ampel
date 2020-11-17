%%%%%%%%%%%%%%%%%%
% Initialization %
%%%%%%%%%%%%%%%%%%

/*Initial logic to add yellow pieces*/
initialize(NewGameState, Player) :-
    % Number of yellow pieces to be placed
    N = 1,
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



%%%%%%%%%%%%%
% Main Game %
%%%%%%%%%%%%%

/* Main Loop */
gameLoop(GameState, Player, NewGameState, Done) :-
    Done < 1,

    % NextPlayer is mod(Player + 1, 2),
    NextPlayer is mod(Player + 1, 2),

    % Display the game
    clear,
    displayGame(GameState, Player),

    % Get user's play option
    getUserOption(Input),


    % Player chooses to place a piece
    setPiece(GameState, Player, NextGameState),
    write('Start main game loop'),
    gameLoop(NextGameState, NextPlayer, NewGameState, 0).


/* Place pieces */
setPiece(GameState, Player, NextGameState) :-

    % Get info from current state/player
    getPlayerColor(Player, Color),
    getGameBoard(GameState, GameBoard),

    % Player selects open tile to place his piece
    write('  Select tile to place your piece:'), nl,
    selectTile(GameBoard, Tile, Row, Col),
    replaceInMatrix(GameBoard, Row, Col, Color, NewGameBoard),

    % Update GameState
    % TODO update player pieces
    setGameBoard(GameState, NewGameBoard, NextGameState).



%%%%%%%%%%%%%%%%%
% Aux Functions %
%%%%%%%%%%%%%%%%%

/* Get user input to select a tile */
selectTile(GameBoard, Tile, Row, Col) :-
    getValueBoard(GameBoard, NewTile, Row, Col),
    validateTile(NewTile, Tile, GameBoard).

/* Get user input to select a piece */
selectPiece(GameBoard, Value, Row, Col) :-
    getValueBoard(GameBoard, NewValue, Row, Col),
    validateValue(NewValue, Value, GameBoard).

/* Get current value on postion [Row, Col] at the board */
getValueBoard(GameBoard,Value, Row, Col) :-
    manageColumn(Col),
    manageRow(Row),
    getValueFromMatrix(GameBoard,Row,Col,Value).

/* Get color of player */
getPlayerColor(Player, Color) :-
    (
        Player =:= 0 ->
        Color = 'green' ; % Player 1 is green
        Color = 'red'     % Player 2 is red
    ).