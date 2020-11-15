manageRow(NewRow) :-
    readRow(Row),
    validateRow(Row, NewRow).

manageColumn(NewColumn) :-
    readColumn(Column),
    validateColumn(Column, NewColumn).

readRow(Row) :-
    write('  > Row '),
    read(Row).

readColumn(Column) :-
    write('  > Column '),
    read(Column).

validateColumn('a', NewColumn) :-
    NewColumn = 0.

validateColumn('b', NewColumn) :-
    NewColumn = 1.

validateColumn('c', NewColumn) :-
    NewColumn = 2.

validateColumn('d', NewColumn) :-
    NewColumn = 3.

validateColumn('e', NewColumn) :-
    NewColumn = 4.

validateColumn('f', NewColumn) :-
    NewColumn = 5.

validateColumn('g', NewColumn) :-
    NewColumn = 6.

validateColumn('h', NewColumn) :-
    NewColumn = 7.

validateColumn('i', NewColumn) :-
    NewColumn = 8.

validateColumn('j', NewColumn) :-
    NewColumn = 9.

validateColumn('k', NewColumn) :-
    NewColumn = 10.

validateColumn('l', NewColumn) :-
    NewColumn = 11.

validateColumn('m', NewColumn) :-
    NewColumn = 12.

validateColumn('n', NewColumn) :-
    NewColumn = 13.

validateColumn('o', NewColumn) :-
    NewColumn = 14.

validateColumn('p', NewColumn) :-
    NewColumn = 15.

validateColumn('q', NewColumn) :-
    NewColumn = 16.

validateColumn('r', NewColumn) :-
    NewColumn = 17.

validateColumn('s', NewColumn) :-
    NewColumn = 18.

validateColumn('t', NewColumn) :-
    NewColumn = 19.

validateColumn('u', NewColumn) :-
    NewColumn = 20.


validateColumn(_Column, NewColumn) :-
    write('ERROR: That column is not valid!\n\n'),
    readColumn(Input),
    validateColumn(Input, NewColumn).

validateRow(1, NewRow) :-
    NewRow = 0.

validateRow(2, NewRow) :-
    NewRow = 1.

validateRow(3, NewRow) :-
    NewRow = 2.

validateRow(4, NewRow) :-
    NewRow = 3.

validateRow(5, NewRow) :-
    NewRow = 4.

validateRow(6, NewRow) :-
    NewRow = 5.

validateRow(7, NewRow) :-
    NewRow = 6.

validateRow(8, NewRow) :-
    NewRow = 7.

validateRow(9, NewRow) :-
    NewRow = 8.

validateRow(10, NewRow) :-
    NewRow = 9.

validateRow(11, NewRow) :-
    NewRow = 10.

validateRow(_Row, NewRow) :-
    write('ERROR: That row is not valid!\n\n'),
    readRow(Input),
    validateRow(Input, NewRow).


validateValue('green', Value, _GameBoard) :-
    Value = 'green'.

validateValue('red', Value, _GameBoard) :-
    Value = 'red'.

validateValue('yellow', Value, _GameBoard) :-
    Value = 'yellow'.

validateValue(_NewValue, Value, GameBoard) :-
    write('ERROR: This space doesnt contain a piece!\n'),
    selectPiece(GameBoard,Value).

validateTile('empty', Tile, _GameBoard) :-
    Tile = 'empty'.

validateTile(_NewTile, Tile, GameBoard) :-
    write('ERROR: This space is not an empty tile!\n'),
    selectTile(GameBoard,Tile).