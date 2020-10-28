initial([
[board,board,board,board,board,board,board,board,board,board,empty,board,board,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,board,board,empty,blank,empty,board,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,board,empty,blank,empty,blank,empty,board,board,board,board,board,board,board,board],
[board,board,board,board,board,board,board,empty,blank,empty,blank,empty,blank,empty,board,board,board,board,board,board,board],
[board,board,board,board,board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board,board,board,board,board],
[board,board,board,board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board,board,board,board],
[board,board,board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board,board,board],
[board,board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board,board],
[board,board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board,board],
[board,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,board],
[empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty]]).


symbol(blank,S) :- S=' '.
symbol(board,S) :- S='  '.
symbol(empty,S) :- S='|.|'.
symbol(yellow,S) :- S='|Y|'.
symbol(green,S) :- S='|G|'.
symbol(red,S) :- S='|R|'.


indice(1, I)  :- I=' 1|'.
indice(2, I)  :- I=' 2|'.
indice(3, I)  :- I=' 3|'.
indice(4, I)  :- I=' 4|'.
indice(5, I)  :- I=' 5|'.
indice(6, I)  :- I=' 6|'.
indice(7, I)  :- I=' 7|'.
indice(8, I)  :- I=' 8|'.
indice(9, I)  :- I=' 9|'.
indice(10, I) :- I='10|'.
indice(11, I) :- I='11|'.



play :-
initial(GameState),
display_game(GameState,'Player 1').



display_game(GameState,Player) :-
    nl,
    write('    |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U| |\n'),
    write('  +---------------------------------------------+\n'),
    write('  |                      _                      |\n'),
    printMatrix(GameState, 1),
    write('  +---------------------------------------------+\n'),
    write('                   '),
    write(Player),
    write(' Turn \n').
printMatrix([], 12).

printMatrix([Head|Tail], N) :-
    indice(N, I),
    write(I),
    write(' '),
    N1 is N + 1,
    printLine(Head),
    write(' |'),
    write('\n  |---------------------------------------------|\n'),
    printMatrix(Tail, N1).

printLine([]).

printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    printLine(Tail).