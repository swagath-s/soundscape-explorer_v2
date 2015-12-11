import cc.arduino.*  ;
import processing.serial.*;

int button = 7;
int led = 13;
int buttonState = 0;


//making the Cell class and creating our grid

public class Cell{
  public int x = -1;
  public int y = -1 ; 
  public Cell(int X, int Y){
    x = X;
    y = Y;
  }
  public void doNothing(){};
  public int val = x+y;
}


Cell[][] grid = new Cell[5][5];

//Cell potato  = new Cell;


void cellAssign(Cell[][] grid){
for (int i = 0; i <5; i++){
  for (int k = 0; k<5; k++){
    Cell temp = new Cell(i, k);
    grid[i][k] = temp;
  }
}

}

{  
  cellAssign(grid);
}

Cell now = new Cell(2, 1);




void move(String where){
  if (  (where == "front" && now.y == 4) ||
        (where == "right" && now.x == 4) ||
        (where == "back" && now.y == 0) ||
        (where == "left" && now.x == 0)   )
        play("edge");
   else {
    switch (where){
      case "front":
        now = grid[now.x][now.y+1];
        //println("y++ "+ now.y);
        println(now.x, now.y);
        break;
      case "right":
        now = grid[now.x+1][now.y];
        //println("x++ ", now.x);
        println(now.x, now.y);
        break;
      case "back":
        now = grid[now.x][now.y-1];
        //println("y-- ", now.y);
        println(now.x, now.y);
        break;
      case "left":
        now = grid[now.x-1][now.y];
        //println("x-- ", now.x);
        println(now.x, now.y);
        break;
    }
   }
}



//preparing to detect button press; readButton is called from draw()

Arduino anp = new Arduino(this, "COM3", 57600);

void anpPinSetup() {
  anp.pinMode(button, Arduino.INPUT);
  anp.pinMode(led, Arduino.OUTPUT);
}


void readButton(){
  buttonState = anp.digitalRead(button);
  if (buttonState == 1) {
    anp.digitalWrite(led, Arduino.HIGH);
    move(dirn);
    delay(500);
  } else {
    anp.digitalWrite(led, Arduino.LOW);
  }
}