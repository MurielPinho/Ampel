%%%%%%%%%%%%%
% Main Menu %
%%%%%%%%%%%%%

/* Get user prefered gamemode and difficulty */
mainMenu(Mode, Difficulty) :-
    printMainMenu,
    getUserMode(Mode),
    format('Select the game mode: ~p', Mode),
    (
        (Mode =:= 2 ; Mode =:= 3) -> getUserDifficulty(Difficulty) ; Difficulty = 0
    ).


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

% gameLoop(GameState, CurrentPlayer, Mode, Difficulty).

/* Quit */
% gameLoop(_, _, 0, _) :- clear,write('Exiting...').

/*PvBot*/
gameLoop(GameState, CurrentPlayer, 2, Difficulty) :-
    % NextPlayer is mod(Player + 1, 2)
    NextPlayer is mod(CurrentPlayer + 1, 2),

    playerTurn(GameState, CurrentPlayer, NextPlayer, NextGameState), % Returns false when game is done
    botTurn(NextGameState, NextPlayer, CurrentPlayer, FinalGameState), % Returns false when game is done

    gameLoop(FinalGameState, CurrentPlayer, 2, Difficulty).

/*BotvBot*/
gameLoop(GameState, CurrentPlayer, 3, Difficulty) :-
    NextPlayer is mod(CurrentPlayer + 1, 2),

    botTurn(GameState, CurrentPlayer, NextPlayer, NextGameState), % Returns false when game is done
    botTurn(NextGameState, NextPlayer, CurrentPlayer, FinalGameState), % Returns false when game is done

    gameLoop(FinalGameState, CurrentPlayer, 3, Difficulty).

/* PvP Main Loop */
gameLoop(GameState, CurrentPlayer, 1, Difficulty) :-
    % NextPlayer is mod(Player + 1, 2)
    NextPlayer is mod(CurrentPlayer + 1, 2),

    playerTurn(GameState, CurrentPlayer, NextPlayer, NextGameState), % Returns false when game is done

    gameLoop(NextGameState, NextPlayer,1,Difficulty).


/* Player turn */
playerTurn(GameState, Player, NextPlayer, NextGameState) :-

    % Get players info
    getPlayerInfo(GameState, Player, Color, Pieces),
    getPlayerInfo(GameState, NextPlayer, NextColor, NextPieces),

    % 1. Move one of your pieces
    clear,
    displayGame(GameState, Player),
    (
        Pieces < 20 ->
            movePlayerPiece(GameState, Player, Color, NextGameState1) ;
            NextGameState1 = GameState, format('No ~p pieces on the board.', Color),nl
    ),
    clear,
    displayGame(NextGameState1, Player),
    !,
    \+ game_over(NextGameState1, Winner),


    % 2. Move one of your oponent's pieces
    (
        NextPieces < 20 ->
            movePlayerPiece(NextGameState1, Player, NextColor, NextGameState2) ;
            NextGameState2 = NextGameState1, format('No ~p pieces on the board.', NextColor),nl

    ),
    clear,
    displayGame(NextGameState2, Player),
    !,
    \+ game_over(NextGameState2, Winner),

    % 3. Place one of your piece
    clear,
    displayGame(NextGameState2, Player),
    (
        Pieces > 0 -> placePlayerPiece(NextGameState2, Player, NextGameState) ;
        NextGameState = NextGameState2, format('No ~p pieces to place.', Color),nl
    ).


botTurn(GameState, Player, NextPlayer, NextGameState) :-
    % Get players info
    getPlayerInfo(GameState, Player, Color, Pieces),
    getPlayerInfo(GameState, NextPlayer, NextColor, NextPieces),

    % 1. Move one of your pieces
    write('     Move one of your pieces'), nl,
    clear,
    displayGame(GameState, Player),
    (
        Pieces < 20 ->
            moveBotPiece(GameState, Player, Color, NextGameState1) ;
            NextGameState1 = GameState, format('No ~p pieces on the board.', Color),nl
    ),
    sleep(1),
    !,
    \+ game_over(NextGameState1, Winner),


    % 2. Move one of your oponent's pieces
    write('     Move one of your oponent\'s pieces'), nl,

    (
        NextPieces < 20 ->
            moveBotPiece(NextGameState1, Player, NextColor, NextGameState2) ;
            NextGameState2 = NextGameState1, format('No ~p pieces on the board.', NextColor),nl

    ),
    sleep(1),

    !,
    \+ game_over(NextGameState2, Winner),

    % 3. Place one of your piece
    write('     Place one of your piece'),nl,
    (
        Pieces > 0 -> placeBotPiece(NextGameState2, Player,Color, NextGameState) ;
        NextGameState = NextGameState2, format('No ~p pieces to place.', Color),nl
    ).

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
    nl, write('  Select a direction to move:'), nl,
    selectMoveOption(Direction),
    nl,

    !,
    move(GameState, [CurrentRow,CurrentCol,Direction,Color,Player], NextGameState)->
        write('')
        ;
        movePlayerPiece(GameState, Player, Color, NextGameState).

moveBotPiece(GameState, Player, Color, NextGameState) :-
    getGameBoard(GameState, GameBoard),

    random(0,10,Row),
    random(0,10,Col),
    random(1,6,TmpDir),
    getDirection(TmpDir,Direction),
    getValueFromMatrix(GameBoard,Row,Col,Value),
    !,
    Value == Color , move(GameState, [Row,Col,Direction,Color,Player], NextGameState)->
        write('')
        ;
        moveBotPiece(GameState, Player, Color, NextGameState).


placeBotPiece(GameState,Player,Color, NewGameState) :-
    random(0,10,TempRow),
    random(0,10,TempCol),

    % Get info from current state/player
    getPlayerInfo(GameState, Player, _Color, Pieces),
    getGameBoard(GameState, GameBoard),
    write(TempRow), write(' '), write(TempCol),nl,
    !,
        (getValueFromMatrix(GameBoard,TempRow,TempCol,'empty'), \+ checkAmpel(GameBoard, TempRow, TempCol, Ampel, _)) ->
        replaceInMatrix(GameBoard, TempRow, TempCol, Color, UpdatedGameBoard),
        NewPieces is Pieces - 1,
        setPlayerPieces(GameState, Player, [Color, NewPieces], NextGameState),
        setGameBoard(NextGameState, UpdatedGameBoard, NewGameState)
        ;
        placeBotPiece(GameState, Player,Color, NewGameState).

placeYellowBot(GameBoard,NewGameBoard) :-
    random(0,10,Row),
    random(0,10,Col),
    write(Row),write(' '),write(Col),nl,
    getValueFromMatrix(GameBoard,Row,Col,Value),
    write(Value),nl,
    (
        Value == 'empty' , verifyNotOnEdge(Row,Col,1) ->
            replaceInMatrix(GameBoard, Row, Col, 'yellow', UpdatedGameBoard),
            NewGameBoard = UpdatedGameBoard
            ;
            placeYellowBot(GameBoard, NewGameBoard)
    ).

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

game_over(GameState, Winner) :-
    getScore(GameState,[ScoreP1, ScoreP2]),
    (ScoreP1 >= 3, Winner = 1, nl,nl,format('\t\tWinner: Player ~p', Winner) ;
    ScoreP2 >= 3,  Winner = 2, nl,nl,format('\t\tWinner: Player ~p', Winner)).