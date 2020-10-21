initialBoard([
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

alpha(1, A)  :- A='                     '.
alpha(2, A)  :- A='                   '.
alpha(3, A)  :- A='                 '.
alpha(4, A)  :- A='               '.
alpha(5, A)  :- A='             '.
alpha(6, A)  :- A='           '.
alpha(7, A)  :- A='         '.
alpha(8, A)  :- A='       '.
alpha(9, A)  :- A='     '.
alpha(10, A) :- A='   '.
alpha(11, A) :- A=' '.


board(1, B)  :- B='|.|'.
board(2, B)  :- B='|.| |.|'.
board(3, B)  :- B='|.| |.| |.|'.
board(4, B)  :- B='|.| |.| |.| |.|'.
board(5, B)  :- B='|.| |.| |.| |.| |.|'.
board(6, B)  :- B='|.| |.| |.| |.| |.| |.|'.
board(7, B)  :- B='|.| |.| |.| |.| |.| |.| |.|'.
board(8, B)  :- B='|.| |.| |.| |.| |.| |.| |.| |.|'.
board(9, B)  :- B='|.| |.| |.| |.| |.| |.| |.| |.| |.|'.
board(10, B) :- B='|.| |.| |.| |.| |.| |.| |.| |.| |.| |.|'.
board(11, B) :- B='|.| |.| |.| |.| |.| |.| |.| |.| |.| |.| |.|'.

printBoard(X) :-
    nl,
    write('    |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U| |\n'),
    write('  +---------------------------------------------+\n'),
    write('  |                      _                      |\n'),
    printMatrix(X, 1),
    write('  +---------------------------------------------+\n').
printMatrix([], 12).

printMatrix([Head|Tail], N) :-
    indice(N, I),
    alpha(N, A),
    board(N, B),
    write(I),
    write(A),
    write(B),
    write(A),
    N1 is N + 1,
    printLine(Head),
    write('|'),
    write('\n  |---------------------------------------------|\n'),
    printMatrix(Tail, N1).

printLine([]).

printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    write('|'),
    printLine(Tail).