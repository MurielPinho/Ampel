:- consult('display.pl').
:- consult('input.pl').
:- consult('logic.pl').
:- consult('utilities.pl').
:- consult('board.pl').

play :-

    % Main menu
    mainMenu(Mode, Difficulty),

    % Initialize game by setting yellow pieces
    initialize(GameState, Player),

    % Start main game loop
    gameLoop(GameState, Player, Mode, Difficulty); nl,nl,write('\t       Thanks for playing!'),nl,nl.
