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
initialize(NewGameState, Player,1) :-
    % Number of yellow pieces to be placed
    InitialPlayer = 0,

    % Initialize board
    initialState(GameState),

    % Start placing yellow pieces on the board
    placeYellowPiece(GameState, InitialPlayer, NewGameState1),
    placeYellowPiece(NewGameState1, InitialPlayer, NewGameState2),
    placeYellowPiece(NewGameState2, InitialPlayer, NewGameState3),
    placeYellowPiece(NewGameState3, InitialPlayer, NewGameState4),
    placeYellowPiece(NewGameState4, InitialPlayer, NewGameState),

    % Next player will be mod(N, 2)
    Player = 1.

initialize(NewGameState, Player,2) :-
    % Number of yellow pieces to be placed

    InitialPlayer = 0,

    % Initialize board
    initialState(GameState),

    % Start placing yellow pieces on the board
    placeYellowPiece(GameState, InitialPlayer, NewGameState1),
    placeYellowBot(NewGameState1,NewGameState2),
    placeYellowPiece(NewGameState2, InitialPlayer, NewGameState3),
    placeYellowBot(NewGameState3,NewGameState4),
    placeYellowPiece(NewGameState4, InitialPlayer, NewGameState),

    % Next player will be mod(N, 2)
    Player = 1.

initialize(NewGameState, Player,3) :-
    % Number of yellow pieces to be placed

    InitialPlayer = 0,

    % Initialize board
    initialState(GameState),

    % Start placing yellow pieces on the board
    placeYellowBot(GameState,NewGameState1),
    placeYellowBot(NewGameState1,NewGameState2),
    placeYellowBot(NewGameState2,NewGameState3),
    placeYellowBot(NewGameState3,NewGameState4),
    placeYellowBot(NewGameState4,NewGameState),


    % Next player will be mod(N, 2)
    Player = 1.
initialize(NewGameState, Player,_).

/* Loop to add N yellow pieces to the board */
placeYellowPiece(GameState, _Player, NewGameState, 0) :-
    clear,
    NewGameState = GameState.

placeYellowPiece(GameState, Player, NewGameState) :-
    clear,

    % NextPlayer is mod(Player + 1, 2),
    NextPlayer is mod(Player + 1, 2),

    % Player chooses tile to put yellow piece
    displayGame(GameState, Player),
    getGameBoard(GameState, GameBoard),
    write('  Select empty tile (not on the edge) to place a yellow piece:'), nl,
    selectInitialTile(GameBoard, Row, Col),
    replaceInMatrix(GameBoard, Row, Col, 'yellow', NewGameBoard),

    % Update GameState
    setGameBoard(GameState, NewGameBoard, NewGameState).

placeYellowBot(GameState,NewGameState) :-
    getGameBoard(GameState, GameBoard),
    random(0,10,Row),   
    random(0,10,Col),
    write(Row), write(Col),
    !,
    
        getValueFromMatrix(GameBoard,Row,Col,'empty') , verifyNotOnEdge(Row,Col,1) ->
            replaceInMatrix(GameBoard, Row, Col, 'yellow', UpdatedGameBoard),
            setGameBoard(GameState,UpdatedGameBoard,NewGameState)
            ;
            placeYellowBot(GameState, NewGameState)
    .

%%%%%%%%%%%%%
% Main Game %
%%%%%%%%%%%%%




/* PvP Main Loop */
gameLoop(GameState, CurrentPlayer, 1, Difficulty) :-
    % NextPlayer is mod(Player + 1, 2)
    NextPlayer is mod(CurrentPlayer + 1, 2),

    playerTurn(GameState, CurrentPlayer, NextPlayer, NextGameState), % Returns false when game is done

    gameLoop(NextGameState, NextPlayer,1,Difficulty).

/*PvBot*/
gameLoop(GameState, CurrentPlayer, 2, Difficulty) :-
    % NextPlayer is mod(Player + 1, 2)
    NextPlayer is mod(CurrentPlayer + 1, 2),

    playerTurn(GameState, CurrentPlayer, NextPlayer, NextGameState), % Returns false when game is done
    botTurn(NextGameState, NextPlayer, CurrentPlayer, Difficulty, FinalGameState), % Returns false when game is done

    gameLoop(FinalGameState, CurrentPlayer, 2, Difficulty).

/*BotvBot*/
gameLoop(GameState, CurrentPlayer, 3, Difficulty) :-
    NextPlayer is mod(CurrentPlayer + 1, 2),

    botTurn(GameState, CurrentPlayer, NextPlayer, Difficulty,NextGameState), % Returns false when game is done
    botTurn(NextGameState, NextPlayer, CurrentPlayer,Difficulty, FinalGameState), % Returns false when game is done

    gameLoop(FinalGameState, CurrentPlayer, 3, Difficulty).




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


botTurn(GameState, Player, NextPlayer,Difficulty, NextGameState) :-
    % Get players info
    getPlayerInfo(GameState, Player, Color, Pieces),
    getPlayerInfo(GameState, NextPlayer, NextColor, NextPieces),

    % 1. Move one of your pieces
    clear,
    displayGame(GameState, Player),
    (
        Pieces < 20 ->
            choose_move(GameState,Player,Difficulty,Color,Move1,NextGameState1) ;
            
            NextGameState1 = GameState, format('No ~p pieces on the board.', Color),nl
    ),
    sleep(1),
    !,
    \+ game_over(NextGameState1, Winner),


    % 2. Move one of your oponent's pieces

    (
        NextPieces < 20 ->
            choose_move(NextGameState1,Player,Difficulty,NextColor,Move2,NextGameState2) ;
            %moveBotPieceRandom(NextGameState1, Player, NextColor, NextGameState2) ;
            NextGameState2 = NextGameState1, format('No ~p pieces on the board.', NextColor),nl

    ),
    sleep(1),

    !,
    \+ game_over(NextGameState2, Winner),

    % 3. Place one of your piece
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



choose_move(GameState, Player, 1, Color, Move, NextGameState) :-
    moveBotPieceRandom(GameState, Player, Color, NextGameState,Move).

choose_move(GameState, Player, 2, Color, Move, NextGameState) :-
    moveBotPieceValid(GameState, Player, Color, NextGameState,Move).

choose_move(GameState, Player, _, Color, Move, NextGameState).

moveBotPieceValid(GameState, Player, Color, NextGameState,Move) :-
    getGameBoard(GameState, GameBoard),

    random(0,10,Row),
    random(0,10,Col),
    random(1,6,TmpDir),
    getDirection(TmpDir,Direction),
    getValueFromMatrix(GameBoard,Row,Col,Value),
    !,
    Value == Color , move(GameState, [Row,Col,Direction,Color,Player], NextGameState)->
        Move = [Row,Col,Direction,Color,Player]
        ;
        moveBotPieceValid(GameState, Player, Color, NextGameState, Move).

moveBotPieceRandom(GameState, Player, Color, NextGameState, Move) :-
    getGameBoard(GameState, GameBoard),

    random(0,10,Row),
    random(0,10,Col),
    random(1,6,TmpDir),
    getDirection(TmpDir,Direction),
    getValueFromMatrix(GameBoard,Row,Col,Value),
    !,
    Value == Color , move(GameState, [Row,Col,Direction,Color,Player], NextGameState)->
        write('     Succesful Move'),nl,
        Move = [Row,Col,Direction,Color,Player]
        ;
        NextGameState = GameState.


placeBotPiece(GameState,Player,Color, NewGameState) :-
    random(0,10,TempRow),
    random(0,10,TempCol),

    % Get info from current state/player
    getPlayerInfo(GameState, Player, _Color, Pieces),
    getGameBoard(GameState, GameBoard),
    !,
        (getValueFromMatrix(GameBoard,TempRow,TempCol,'empty'), \+ checkAmpel(GameBoard, TempRow, TempCol, _Ampel, _)) ->
        replaceInMatrix(GameBoard, TempRow, TempCol, Color, UpdatedGameBoard),
        NewPieces is Pieces - 1,
        setPlayerPieces(GameState, Player, [Color, NewPieces], NextGameState),
        setGameBoard(NextGameState, UpdatedGameBoard, NewGameState)
        ;
        placeBotPiece(GameState, Player,Color, NewGameState).   



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