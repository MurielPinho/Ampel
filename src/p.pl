:- consult('display.pl').
:- consult('input.pl').
:- consult('logic.pl').
:- consult('utilities.pl').
:- consult('board.pl').

play :-
    % Initialize game by setting yellow pieces
    initialize(GameState, Player),

    % Start main game loop
    Done = 0,
    gameLoop(GameState, Player).
