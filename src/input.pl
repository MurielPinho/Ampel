/* Manages input for a row */
manageRow(NewRow) :-
    readRow(Row),
    validateRow(Row, NewRow).

/* Manages input for a column */
manageColumn(NewColumn) :-
    readColumn(Column),
    validateColumn(Column, NewColumn).

/* Reads input for a row */
readRow(Row) :-
    write('  > Row '),
    read(Row).

/* Reads input for a column */
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

/* Get user's selected empty tile */
selectTile(GameBoard, ValidRow, ValidCol) :-
    % Get user's selection
    getValueBoard(GameBoard, Value, SelectedRow, SelectedCol),

    % Validate selection
    (
        Value == 'empty' ->
            ValidRow = SelectedRow,
            ValidCol =  SelectedCol
            ;
            write('  ERROR: This option is not valid!'), nl,
            selectTile(GameBoard, ValidRow, ValidCol)
    ).

/* Get user's selected empty tile */
selectInitialTile(GameBoard, ValidRow, ValidCol) :-
    % Get user's selection
    getValueBoard(GameBoard, Value, SelectedRow, SelectedCol),

    % Validate selection
    verifyNotOnEdge(SelectedRow, SelectedCol, Valid),
    (
        (Value == 'empty', Valid == 1) ->
            ValidRow = SelectedRow,
            ValidCol =  SelectedCol
            ;
            write('  ERROR: This option is not valid!'), nl,
            selectInitialTile(GameBoard, ValidRow, ValidCol)
    ).


/* Check if the empty tile is on the edge of the board*/
verifyNotOnEdge(SelectedRow, SelectedCol, Valid) :-
    (

        ( SelectedCol == 0 ; SelectedCol == SelectedRow ; SelectedRow == 10) ->
            Valid = 0
            ;
            Valid = 1
    ).

verifyNotBoard(SRow, SCol, IsBoard) :-
    (
        ColParity is SCol mod 2,
        RowParity is SRow mod 2,
        ( RowParity == ColParity  ) ->
            IsBoard = 0
            ;
            IsBoard = 1
    ).

%%%%%%%%%%%%%
% Main Game %
%%%%%%%%%%%%%

/* Get user input for his play option (place/move piece) */
getUserOption(ValidOption) :-
    write('  Choose your option:'), nl,
    write('    1) Place Piece'), nl,
    write('    2) Move Piece'), nl,
    write('  Option '),
    read(Option), nl,
    validateOption(Option, ValidOption).

/* Check if user input is valid*/
validateOption(1, ValidOption) :-
    ValidOption = 1.

validateOption(2, ValidOption) :-
    ValidOption = 2.

validateOption(_Option, ValidOption) :-
    write('  ERROR: This option is not valid!'), nl,
    getUserOption(ValidOption).

/* Select a player's piece */
selectPiece(GameBoard, Color, ValidRow, ValidCol) :-
    % Get user's selection
    getValueBoard(GameBoard, Value, SelectedRow, SelectedCol),

    % Validate selection
    (
        Color == Value ->
            ValidRow = SelectedRow,
            ValidCol =  SelectedCol
            ;
            write('  ERROR: This option is not valid!'), nl,
            selectPiece(GameBoard, Color, ValidRow, ValidCol)
    ).


/* Select direction for piece to move */
selectMoveOption(Direction) :-
    write('  1) NW    2) NE'),nl,
    write('  3) W     4) E'),nl,
    write('  5) SW    6) SE'),nl,
    write('  > Option '), read(UserOption),
    (
        (UserOption < 1 ; UserOption > 6) ->
            write('  Invalid option. Try again.'),nl,
            selectMoveOption(Direction)
            ;
            getDirection(UserOption, Direction)
    ).

/* Translates direction for piece to move based on input */
getDirection(1, Direction) :-
    Direction = 'NW'.
getDirection(2, Direction) :-
    Direction = 'NE'.
getDirection(3, Direction) :-
    Direction = 'W'.
getDirection(4, Direction) :-
    Direction = 'E'.
getDirection(5, Direction) :-
    Direction = 'SW'.
getDirection(6, Direction) :-
    Direction = 'SE'.