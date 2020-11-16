:- consult('display.pl').
:- consult('input.pl').
:- consult('logic.pl').
:- consult('utilities.pl').

play :-
    initialize(NewGameState),
    displayGame(NewGameState, 'Player2').
