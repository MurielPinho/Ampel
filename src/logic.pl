%%%%%%%%%%%%%%%%%%
% Initialization %
%%%%%%%%%%%%%%%%%%

/*Initial logic to add yellow pieces*/
initialize(NewGameState, Player) :-
    % Number of yellow pieces to be placed
    N = 0,
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
    write('  Select empty tile (not on the edge) to place a yellow piece:'), nl,
    selectInitialTile(GameBoard, Row, Col),
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
    getPlayerInfo(GameState, Player, Color, Pieces),
    getGameBoard(GameState, GameBoard),

    % Player selects open tile to place his piece
    write('  Select tile to place your piece:'), nl,
    selectTile(GameBoard, Row, Col),
    replaceInMatrix(GameBoard, Row, Col, Color, NewGameBoard),

    % Update GameState
    NewPieces is Pieces - 1,
    setPlayerPieces(GameState, Player, [Color, NewPieces], NextGameState1),
    setGameBoard(NextGameState1, NewGameBoard, NextGameState).


/* Move piece */
movePlayerPiece(GameState, Player, NextGameState) :-

    % Get info from current state/player
    getPlayerInfo(GameState, Player, Color, _Pieces),
    getGameBoard(GameState, GameBoard),

    % Player selects his piece
    write('  Select one of your pieces:'), nl,
    selectPiece(GameBoard, Color, CurrentRow, CurrentCol),

    % Player selects direction to move his piece
    movePiece(GameBoard, CurrentRow, CurrentCol, NewRow, NewCol),

    % Update GameBoard
    replaceInMatrix(GameBoard, CurrentRow, CurrentCol, 'empty', NewGameBoard),
    replaceInMatrix(NewGameBoard, NewRow, NewCol, Color, FinalGameBoard),

    % Update GameState
    setGameBoard(GameState, FinalGameBoard, NextGameState).

checkAmpel(Board,Row,Col,Ampel,FinalBoard) :-
    (
        (checkAmpelDLU(Board,Col,Row,Ampel,FinalBoard),Ampel =:= 1);
        (checkAmpelDRU(Board,Col,Row,Ampel,FinalBoard),Ampel =:= 1);
        (checkAmpelHR(Board,Col,Row,Ampel,FinalBoard),Ampel =:= 1);
        (checkAmpelDRD(Board,Col,Row,Ampel,FinalBoard),Ampel =:= 1);
        (checkAmpelDLD(Board,Col,Row,Ampel,FinalBoard),Ampel =:= 1);
        (checkAmpelHL(Board,Col,Row,Ampel,FinalBoard),Ampel =:= 1)
    )
    .

checkVictory(GameState,Winner) :-
    getScore(GameState,Score),
    (
        (checkVictoryP1(Score,Winner),Winner =:= 1);
        (checkVictoryP2(Score,Winner),Winner =:= 2)

    ).


checkVictoryP1([ScoreP1,_ScoreP2],Winner) :-
    ScoreP1 >= 3 -> Winner = 1 ; Winner = 0 .


checkVictoryP2([_ScoreP1,ScoreP2],Winner) :-
    ScoreP2 >= 3 -> Winner = 2 ; Winner = 0 .


