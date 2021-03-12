import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public int NUM_ROWS = 20;
public int NUM_COLS = 20;

private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = false; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int x=0;x<NUM_ROWS; x++)
  {
    for(int y=0;y<NUM_COLS; y++)
    {
      buttons[x][y] = new Life(x, y);
    }
  }
  //your code to initialize buffer goes here
  
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  for(int x=0;x<NUM_ROWS; x++)
  {
    for(int y=0;y<NUM_COLS; y++)
    {
      buffer[x][y] = buttons[x][y].getLife();
    }
  }
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
    
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for(int a= 0;a<NUM_ROWS; a++)
  {
    for(int b=0;b<NUM_COLS; b++)
    {
      int n = countNeighbors(a,b);
      System.out.println(a+","+b+":"+n);
      
      if(n == 3)
      {
        buffer[a][b] = true;
      }
      else if(n == 2 && buttons[a][b].getLife())
      {
        buffer[a][b] = true;
      }
      else
      {
        buffer[a][b] = false;
      }
      
      buttons[a][b].draw();
    }
  }

  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if(key == 's')
  {
    running = !running;
  }
  if(key == 'r')
  {
    setup();
  }
}

public void copyFromBufferToButtons() {
  for(int x=0;x<NUM_ROWS; x++)
  {
    for(int y=0;y<NUM_COLS; y++)
    {
      buttons[x][y].setLife(buffer[x][y]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for(int x=0;x<NUM_ROWS; x++)
  {
    for(int y=0;y<NUM_COLS; y++)
    {
      buffer[x][y] = buttons[x][y].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  boolean colBad = c<0 || c>=NUM_COLS;
  boolean rowBad = r<0 || r>=NUM_ROWS;
  
  if(colBad || rowBad)
  {
    return false;
  }
  return true;
}

public int countNeighbors(int row, int col) {
  int count = 0;
  for(int r=-1;r<2;r++)
  {
    for(int c=-1;c<2;c++)
    {
      if(isValid(r+row,c+col) && !(c == 0 && r == 0))
        {
          if(buttons[r+row][c+col].getLife())
          {
            count++;
          }
        }
    }
  }
  return count;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    //your code here
    alive = living;
  }
}
