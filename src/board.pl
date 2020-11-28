/*Declaration of a initial gamestate */

initialState([[
[empty,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank],
[red,red,blank,blank,blank,blank,blank,blank,blank,blank,blank],
[empty,empty,empty,blank,blank,blank,blank,blank,blank,blank,blank],
[empty,empty,empty,empty,blank,blank,blank,blank,blank,blank,blank],
[empty,empty,empty,empty,red,blank,blank,blank,blank,blank,blank],
[empty,empty,empty,empty,empty,empty,blank,blank,blank,blank,blank],
[empty,empty,empty,yellow,red,empty,empty,blank,blank,blank,blank],
[empty,green,empty,empty,empty,empty,empty,yellow,blank,blank,blank],
[yellow,empty,empty,empty,empty,empty,empty,empty,green,blank,blank],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,blank],
[yellow,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],[0,0],[green,20],[red,20]]).

/*Returns the symbol to be displayed on board */
symbol(blank,S) :- atom_codes(S, [0x0020]).
symbol(empty,S) :- atom_codes(S, [0x2502, 0x002E, 0x2502]).
symbol(yellow,S) :- atom_codes(S, [0x2502, 0x0059, 0x2502]).
symbol(green,S) :- atom_codes(S, [0x2502, 0x0047, 0x2502]).
symbol(red,S) :- atom_codes(S, [0x2502, 0x0052, 0x2502]).


printMainMenu :-
    border('t',TopBorder),
    border('b',BotBorder),
    border('v',VertBorder),
    title(Title),nl,nl,
    write(TopBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write(Title),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('               Choose Gamemode:              '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('             1. Player Vs Player             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('            2. Player Vs Computer            '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('           3. Computer Vs Computer           '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                   0. Exit                   '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write('  '),write(VertBorder),write('                                             '),write(VertBorder),nl,
    write(BotBorder),nl,nl,nl.


title(T) :- atom_codes(T,[0x0020,0x0020,0x2503,0x0020,0x0020,0x2588,0x2588,0x2588,0x2588,0x2588,0x2557,0x0020,0x2588,0x2588,0x2588,0x2557,0x0020,0x0020,0x0020,0x2588,0x2588,0x2588,0x2557,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2557,0x0020,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2557,0x2588,0x2588,0x2557,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503,0x000a,
0x0020,0x0020,0x2503,0x0020,0x2588,0x2588,0x2554,0x2550,0x2550,0x2588,0x2588,0x2557,0x2588,0x2588,0x2588,0x2588,0x2557,0x0020,0x2588,0x2588,0x2588,0x2588,0x2551,0x2588,0x2588,0x2554,0x2550,0x2550,0x2588,0x2588,0x2557,0x2588,0x2588,0x2554,0x2550,0x2550,0x2550,0x2550,0x255d,0x2588,0x2588,0x2551,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503,0x000a,
0x0020,0x0020,0x2503,0x0020,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2551,0x2588,0x2588,0x2554,0x2588,0x2588,0x2588,0x2588,0x2554,0x2588,0x2588,0x2551,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2554,0x255d,0x2588,0x2588,0x2588,0x2588,0x2588,0x2557,0x0020,0x0020,0x2588,0x2588,0x2551,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503,0x000a,
0x0020,0x0020,0x2503,0x0020,0x2588,0x2588,0x2554,0x2550,0x2550,0x2588,0x2588,0x2551,0x2588,0x2588,0x2551,0x255a,0x2588,0x2588,0x2554,0x255d,0x2588,0x2588,0x2551,0x2588,0x2588,0x2554,0x2550,0x2550,0x2550,0x255d,0x0020,0x2588,0x2588,0x2554,0x2550,0x2550,0x255d,0x0020,0x0020,0x2588,0x2588,0x2551,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503,0x000a,
0x0020,0x0020,0x2503,0x0020 ,0x2588,0x2588,0x2551,0x0020,0x0020,0x2588,0x2588,0x2551,0x2588,0x2588,0x2551,0x0020,0x255a,0x2550,0x255d,0x0020,0x2588,0x2588,0x2551,0x2588,0x2588,0x2551,0x0020,0x0020,0x0020,0x0020,0x0020,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2557,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2588,0x2557,0x0020,0x2503,0x000a,
0x0020,0x0020,0x2503,0x0020,0x255a,0x2550,0x255d,0x0020,0x0020,0x255a,0x2550,0x255d,0x255a,0x2550,0x255d,0x0020,0x0020,0x0020,0x0020,0x0020,0x255a,0x2550,0x255d,0x255a,0x2550,0x255d,0x0020,0x0020,0x0020,0x0020,0x0020,0x255a,0x2550,0x2550,0x2550,0x2550,0x2550,0x2550,0x255d,0x255a,0x2550,0x2550,0x2550,0x2550,0x2550,0x2550,0x255d,0x0020,0x2503
]).

/*Returns the number indicator on the left of the board*/
indice(1, I)  :- atom_codes(I, [0x0020,0x0031,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020]).
indice(2, I)  :- atom_codes(I, [0x0020,0x0032,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020]).
indice(3, I)  :- atom_codes(I, [0x0020,0x0033,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020]).
indice(4, I)  :- atom_codes(I, [0x0020,0x0034,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020]).
indice(5, I)  :- atom_codes(I, [0x0020,0x0035,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020]).
indice(6, I)  :- atom_codes(I, [0x0020,0x0036,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020]).
indice(7, I)  :- atom_codes(I, [0x0020,0x0037,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020]).
indice(8, I)  :- atom_codes(I, [0x0020,0x0038,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020]).
indice(9, I)  :- atom_codes(I, [0x0020,0x0039,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020]).
indice(10, I) :- atom_codes(I, [0x0031,0x0030,0x2503,0x0020,0x0020,0x0020]).
indice(11, I) :- atom_codes(I, [0x0031,0x0031,0x2503,0x0020]).

border('v',Border) :- atom_codes(Border, [0x2503]).
border('h',Border) :- atom_codes(Border, [0x0020,0x0020,0x2520,0x2500,0x2500,   0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2500,0x2528]).
border('t',Border) :- atom_codes(Border, [0x0020,0x0020,0x250F,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2513]).
border('b',Border) :- atom_codes(Border, [0x0020,0x0020,0x2517,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x2501,0x251B]).
border('m1',Border) :- atom_codes(Border, [0x0020,0x0020,0x2520,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x252C,0x2500,0x2528]).
border('m2',Border) :- atom_codes(Border, [0x0020,0x0020,0x2520,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x253C,0x2500,0x253C,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2528]).
border('m3',Border) :- atom_codes(Border, [0x0020,0x0020,0x2520,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2534,0x2500,0x2528]).
border('i',Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x2502,0x0041,0x2502,0x0042,0x2502,0x0043,0x2502,0x0044,0x2502,0x0045,0x2502,0x0046,0x2502,0x0047,0x2502,0x0048,0x2502,0x0049,0x2502,0x004A,0x2502,0x004B,0x2502,0x004C,0x2502,0x004D,0x2502,0x004E,0x2502,0x004F,0x2502,0x0050,0x2502,0x0051,0x2502,0x0052,0x2502,0x0053,0x2502,0x0054,0x2502,0x0055,0x2502,0x0020,0x2503]).
border(1,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503]).
border(2,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503]).
border(3,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503]).
border(4,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503]).
border(5,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503]).
border(6,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503]).
border(7,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503]).
border(8,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x0020,0x0020,0x0020,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x0020,0x0020,0x0020,0x0020,0x2503]).
border(9,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x0020,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x0020,0x0020,0x2503]).
border(10,Border) :- atom_codes(Border, [0x0020,0x0020,0x2503,0x0020,0x250C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2510,0x0020,0x2503]).
border(11,Border) :- atom_codes(Border, [0x0020,0x0020,0x2520,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x253C,0x2500,0x2528]).
