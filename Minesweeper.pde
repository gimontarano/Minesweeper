

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined
public final static int NUM_ROWS = 10;
public final static int NUM_COLS = 10;
public final static int NUM_BOMBS = 5;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    //your code to declare and initialize buttons goes here
    
    for(int i = 0; i < NUM_ROWS; i++)
    {
        for(int j = 0; j < NUM_COLS; j++)
        {
            buttons[i][j] = new MSButton(i, j);
        }
    }
    for(int i = 0; i < NUM_BOMBS; i++)
    {
        setBombs();
    }
    
}
public void setBombs()
{
    //your code
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[row][col]))
    {
        bombs.add(buttons[row][col]);
    }
    else 
    {
        setBombs();
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    fill(0);
    text("you lose", 100, 200);
}
public void displayWinningMessage()
{
    //your code here
    fill(0);
    text("you win", 100, 300);

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        
        //your code here
        if(mouseButton == LEFT)
        {
            clicked = true;
            if(isValid(r,c-1) && !bombs.contains(buttons[r][c-1]) && buttons[r][c-1].clicked == false && buttons[r][c-1].marked == false)
            {
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r,c+1) && !bombs.contains(buttons[r][c+1]) && buttons[r][c+1].clicked == false && buttons[r][c+1].marked == false)
            {
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r-1,c) && !bombs.contains(buttons[r-1][c]) && buttons[r-1][c].clicked == false && buttons[r-1][c].marked == false)
            {
                buttons[r-1][c].mousePressed();
            }
            if(isValid(r+1,c) && !bombs.contains(buttons[r+1][c]) && buttons[r+1][c].clicked == false && buttons[r+1][c].marked == false)
            {
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r+1,c-1) && !bombs.contains(buttons[r+1][c-1]) && buttons[r+1][c-1].clicked == false && buttons[r+1][c-1].marked == false)
            {
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r-1,c+1) && !bombs.contains(buttons[r-1][c+1]) && buttons[r-1][c+1].clicked == false && buttons[r-1][c+1].marked == false)
            {
                buttons[r-1][c+1].mousePressed();
            }
            if(isValid(r-1,c-1) && !bombs.contains(buttons[r-1][c-1]) && buttons[r-1][c-1].clicked == false && buttons[r-1][c-1].marked == false)
            {
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r+1,c+1) && !bombs.contains(buttons[r+1][c+1]) && buttons[r+1][c+1].clicked == false && buttons[r+1][c+1].marked == false)
            {
                buttons[r+1][c+1].mousePressed();
            }
        }
        if(mouseButton == RIGHT)
        {
            marked = !marked;
        }
    }

    public void draw () 
    {    
        int count = 0;
        for(int i = 0; i < NUM_BOMBS; i++)
        {
            if(bombs.get(i).marked)
            {
                count++;
            }
        }
        text("Bombs marked: " + count, 100, 100);
        if(count == NUM_BOMBS)
        {
            displayWinningMessage();
        }
        if (marked)
            fill(0);
        else if(clicked && bombs.contains(this))
        {
            displayLosingMessage();
            fill(255,0,0);
            for(int i = 0; i < NUM_BOMBS; i++)
            {
                bombs.get(i);
                fill(255, 0, 0);
            }
        }
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        //label = numBombs.toString();
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r <= NUM_ROWS-1 && c >= 0 && c <= NUM_COLS-1)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {

        int numBombs = 0;
        
        if(isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if(isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if(isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        if(isValid(row, col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if(isValid(row+1, col) && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if(isValid(row, col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(isValid(row-1, col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        return numBombs;
/*
        if(isValid(r,c-1) && blobs[r][c-1].isMarked())
            blobs[r][c-1].mousePressed();
          if(isValid(r,c+1) && blobs[r][c+1].isMarked())
          {
            blobs[r][c+1].mousePressed();
          }
          if(isValid(r-1,c) && blobs[r-1][c].isMarked())
          {
            blobs[r-1][c].mousePressed();
          }
          if(isValid(r+1,c) && blobs[r+1][c].isMarked())
          {
            blobs[r+1][c].mousePressed();
          }
          
          if(isValid(r+1,c-1) && blobs[r+1][c-1].isMarked())
            blobs[r+1][c-1].mousePressed();
          //3 more recursive calls
          if(isValid(r-1,c+1) && blobs[r-1][c+1].isMarked())
          {
            blobs[r-1][c+1].mousePressed();
          }
          if(isValid(r-1,c-1) && blobs[r-1][c-1].isMarked())
          {
            blobs[r-1][c-1].mousePressed();
          }
          if(isValid(r+1,c+1) && blobs[r+1][c+1].isMarked())
          {
            blobs[r+1][c+1].mousePressed();
          }

        */
        
    }
}



//JACKY MINESWEEPER