/* Get the gameboard of the current state */
getGameBoard([H | _T], GameBoard) :-
        GameBoard = H.

/* Set the gameboard of the current state */
setGameBoard([_H | T], GameBoard, [GameBoard|T]).


/* Replace a value in the position [Row,Col] at the board*/
replaceInList([_H|T], 0, Value, [Value|T]).

replaceInList([H|T], Index, Value, [H|TNew]) :-
        Index > 0,
        Index1 is Index - 1,
        replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 0, Column,Value, [HNew|T]) :-
        replaceInList(H, Column, Value, HNew).

replaceInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
        Row > 0,
        Row1 is Row - 1,
        replaceInMatrix(T, Row1, Column, Value, TNew).


/* Get a value from the position [Row,Col] at the board*/
getValueFromList([H|_T], 0, Value) :-
        Value = H.

getValueFromList([_H|T], Index, Value) :-
        Index > 0,
        Index1 is Index - 1,
        getValueFromList(T, Index1, Value).

getValueFromMatrix([H|_T], 0, Column, Value) :-
        getValueFromList(H, Column, Value).

getValueFromMatrix([_H|T], Row, Column, Value) :-
        Row > 0,
        Row1 is Row - 1,
        getValueFromMatrix(T, Row1, Column, Value).

/* Clear the screen to display less information */
clear :-
        write('\33\[2J').