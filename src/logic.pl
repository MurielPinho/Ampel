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

    % Start placing yellow pieces on the board
    placeYellowPiece(GameState, InitialPlayer, NewGameState, N),

    % Next player will be mod(N, 2)
    Player is mod(N, 2).

/* Loop to add N yellow pieces to the board */
placeYellowPiece(GameState, _Player, NewGameState, 0) :-
    clear,
    NewGameState = GameState.

placeYellowPiece(GameState, Player, NewGameState, N) :-
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
    placeYellowPiece(NextGameState, NextPlayer, NewGameState, N1).



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

    (
        1 is Input ->
            % Player chooses to place a piece
            placePlayerPiece(GameState, Player, NextGameState)
        ;
            % Player chooses to move a piece
            movePlayerPiece(GameState, Player, NextGameState)
    ),

    % Next round
    gameLoop(NextGameState, NextPlayer, NewGameState, Done).


/* Place piece */
placePlayerPiece(GameState, Player, NextGameState) :-

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


/* Move piece */
movePlayerPiece(GameState, Player, NextGameState) :-

    % Get info from current state/player
    getPlayerColor(Player, Color),
    getGameBoard(GameState, GameBoard),

    % Player selects open tile to place his piece
    write('  Select one of your pieces:'), nl,
    selectPiece(GameBoard, Color, CurrentRow, CurrentCol),
    replaceInMatrix(GameBoard, CurrentRow, CurrentCol, 'empty', NewGameBoard),

    % Player selects open tile to place his piece
    nl, write('  Select tile to place your piece:'), nl,
    selectTile(NewGameBoard, Tile, NewRow, NewCol),
    replaceInMatrix(NewGameBoard, NewRow, NewCol, Color, FinalGameBoard),

    % Update GameState
    setGameBoard(GameState, FinalGameBoard, NextGameState).


%%%%%%%%%%%%%%%%%
% Aux Functions %
%%%%%%%%%%%%%%%%%

/* Get user input to select a tile */
selectTile(GameBoard, Tile, Row, Col) :-
    getValueBoard(GameBoard, NewTile, Row, Col),
    validateTile(NewTile, Tile, GameBoard).

/* Get user input to select a piece */
selectPiece(GameBoard, Color, Row, Col) :-
    getUserPiece(GameBoard, Color, Row, Col).
