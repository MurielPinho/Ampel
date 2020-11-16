:- consult('display.pl').
:- consult('input.pl').
:- consult('logic.pl').
:- consult('utilities.pl').

play :-
    % Initialize game by setting yellow pieces
    initialize(GameState, Player),

    % Start main game loop
    gameLoop(GameState, Player).
