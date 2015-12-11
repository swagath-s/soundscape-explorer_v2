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
  public int val = x+y;
}


Cell[][] grid = new Cell[5][5];


void cellAssign(Cell[][] grid){
  print(grid[1][1].x);
                /*for (int i = 0; i <5; i++){
                  for (int k = 0; k<5; k++){
                    grid[i][k].x = i;
                    grid[i][k].y = k;
                  }
                }*/
  
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
        now = grid[now.x][now.y++];
        print("y++ "+ now.y);
        break;
      case "right":
        now = grid[now.x++][now.y];
        print("x++ ", now.x);
        break;
      case "back":
        now = grid[now.x][now.y--];
        print("y-- ", now.y);
        break;
      case "left":
        now = grid[now.x--][now.y];
        print("x-- ", now.x);
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