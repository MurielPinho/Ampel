# Ampel

### Identification

* **Game:** Ampel
* **Group:** Ampel_4
* **Class:** 5
* **Students:**
    * André Mamprin Mori - up201700132
    * Muriel Pinho - up201700132 
### Game Description 



### GameState Implementation

The GameState is implemented in a list containing 3 lists:
1. Represents the board in a 26x11 Matrix containing atoms for the following:
    - **red** represents the *Red* pieces. 
    - **green** represents the *Green* pieces. 
    - **yellow** represents the *Yellow* pieces. 
    - **empty** represents the *Empty* or *Playable* spaces. 
    - **board** and **blank** represent *Unplayable* spaces but they transalate into different things when the board is displayed.
        - **board** translates into 2 spaces.
        - **blank** translates into 1 space.  

2. Represents the pieces available to be played for Player 1, formatted as [R,G,Y] with R for *Red* pieces available, G for *Green* pieces available and Y for *Yellow* pieces available.
3. Represents the pieces available to be played for Player 2, formatted as [R,G,Y] with R for *Red* pieces available, G for *Green* pieces available and Y for *Yellow* pieces available.

#### GameState Examples

- **Initial State**
    - Description: 
        
    - Prolog representation:
    ```
    initialState([[
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
    [empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty,blank,empty]],
    [20,20,10],
    [20,20,10]]).
    ```
     


### GameState Visualization



