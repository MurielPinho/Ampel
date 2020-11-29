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
gameLoop(GameState, Player) :-
    % NextPlayer is mod(Player + 1, 2),
    NextPlayer is mod(Player + 1, 2),

    playerTurn(GameState, Player, NextPlayer),
    gameLoop(GameState, NextPlayer).


/* Player turn */
playerTurn(GameState, Player, NextPlayer) :-

    % Get players info
    getPlayerInfo(GameState, Player, Color, _Pieces),
    getPlayerInfo(GameState, NextPlayer, NextColor, _NextPieces),

    % 1. Move one of your pieces
    clear,
    displayGame(GameState, Player),
    movePlayerPiece(GameState, Player, Color, NextGameState1),
    write('oi'),
    (checkVictory(NextGameState1);write('venci ')),
    write('tchau'),


    % 2. Move one of your oponent's pieces
    clear,
    displayGame(NextGameState1, Player),
    movePlayerPiece(NextGameState1, Player, NextColor, NextGameState2),
    checkVictory(NextGameState2),

    % 3. Place one of your piece
    clear,
    displayGame(NextGameState2, Player),
    placePlayerPiece(NextGameState2, Player, NextGameState3).


/* Place piece */
placePlayerPiece(GameState, Player, NextGameState) :-

    % Get info from current state/player
    getPlayerInfo(GameState, Player, Color, Pieces),
    getGameBoard(GameState, GameBoard),

    % Player selects open tile to place his piece
    placePiece(GameBoard, Color, NewGameBoard),

    % Update GameState
    NewPieces is Pieces - 1,
    setPlayerPieces(GameState, Player, [Color, NewPieces], NextGameState1),
    setGameBoard(NextGameState1, NewGameBoard, NextGameState).


/* Move piece */
movePlayerPiece(GameState, Player, Color, NextGameState) :-

    % Get info from current state/player
    getGameBoard(GameState, GameBoard),

    % Player selects his piece
    format('  Select a ~p piece to move:', Color), nl,
    selectPiece(GameBoard, Color, CurrentRow, CurrentCol),

    % Player selects direction to move his piece
    movePiece(GameBoard, CurrentRow, CurrentCol, NewRow, NewCol),

    % Update GameBoard
    replaceInMatrix(GameBoard, CurrentRow, CurrentCol, 'empty', NewGameBoard),
    replaceInMatrix(NewGameBoard, NewRow, NewCol, Color, UpdatedGameBoard),

    % Check for Ampel
    (
        checkAmpel(UpdatedGameBoard,NewCol, NewRow, Ampel, AmpelBoard) ->
            FinalGameBoard = AmpelBoard,
            updateAfterAmpel(GameState, Player, FinalGameState);
            FinalGameBoard = UpdatedGameBoard,
            FinalGameState = GameState
    ),

    % Update GameState
    setGameBoard(FinalGameState, FinalGameBoard, NextGameState).

/* Updated GameState after ampel*/
updateAfterAmpel(GameState, Player, FinalState) :-
    getScore(GameState, [ScoreP1 | ScoreP2]),
    (
        Player =:= 0 -> NewScoreP1 is ScoreP1 + 1, NewScoreP2 = ScoreP2;
            NewScoreP1 = ScoreP1, NewScoreP2 is ScoreP2 + 1
    ),
    setScore(GameState, [NewScoreP1 | NewScoreP2], NewState),

    % % Return pieces to players
    getPlayerInfo(NewState, 0, ColorP1, PiecesP1),
    getPlayerInfo(NewState, 1, ColorP2, PiecesP2),
    NewPiecesP1 is PiecesP1 + 1,
    NewPiecesP2 is PiecesP2 + 1,
    setPlayerPieces(NewState, 0, [ColorP1,NewPiecesP1], NewStateP1),
    setPlayerPieces(NewStateP1, 1, [ColorP2,NewPiecesP2], FinalState).


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

checkVictory(GameState) :-
    getScore(GameState,[ScoreP1, ScoreP2]),
    ScoreP1 < 3, ScoreP2 < 3.