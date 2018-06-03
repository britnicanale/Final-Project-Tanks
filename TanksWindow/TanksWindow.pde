import processing.sound.*;
import controlP5.*;

ControlP5 cp5;
Tank myTank, yourTank;
Wall[] walls;
Projectile p;
SoundFile shoot, explosion, tankExplosion;
boolean turn;
boolean tankwindow, startwindow, howtoplaywindow;
Button start, howtoplay, htpstart, restart;
Textlabel tanks, howtoplaylabel, menu;
Textarea instructions;


void setup(){
   size(800, 400);
   cp5 = new ControlP5(this);
   tankwindow = false;
   howtoplaywindow = false;
   setupStartWindow();
   shoot = new SoundFile(this, "tanksound.mp3"); // played when tank shoots
   explosion = new SoundFile(this, "explodesound.mp3"); // played when projectile explodes
   tankExplosion = new SoundFile(this, "tankexplodesound.mp3"); //Plays when tank explodes
}

void setupStartWindow(){
  startwindow = true;
  background(135,206,250);
  tanks = cp5.addTextlabel("TANKS")
   .setText("TANKS")
   .setPosition(width/2 - 87.5, 50)
   .setSize(175,50)
   .setFont(createFont("armalite.ttf",50))
   .setLineHeight(14)
   .setColor(0)
   ;
  start = cp5.addButton("Start")
  .setLabel("Start")  
  .setSize(100,50)
  .setPosition(width/2 - 50, 150)
  .setColor(new CColor(0, 0xff005000, 0, 0xff999999, 0));
  ;
  howtoplay = cp5.addButton("How To Play")
  .setLabel("How To Play")
  .setSize(100,50)
  .setPosition(width/2 - 50, 225)
  .setColor(new CColor(0, 0xff005000, 0, 0xff999999, 0));
  ;
}

void setupTanksWindow(){

  background(135,206,250);
  walls = new Wall[2];
  walls[0] = new Wall(0, height * 2 / 3, (width - 200));
  walls[1] = new Wall(225, 150, 275);
  yourTank = new Tank( walls[1].rightX + 200, walls[0].leftY - 30, false);
  myTank = new Tank(walls[1].leftX / 2 - 60, walls[0].leftY - 30, true);
  fill(0,100,0);
  stroke(0,100,0);

  rect(600,0,200,400);
  
  turn = false;
  tankwindow = true;
  menu = cp5.addTextlabel("Menu")
  .setLabel("Menu")
  .setFont(createFont("armalite.ttf",35))
  .setSize(100,50)
  .setColor(99)
  .setVisible(true)
  .setPosition(650, 50);
  ;
  restart = cp5.addButton("Restart")
   .setLabel("Restart")
   .setSize(100,50)
   .setColor(new CColor(0, 0, 0, 0xff999999, 0))
   .setPosition(650, 125);
  ;
}

void setupHowToPlayWindow(){
  background(135,206,250);
  instructions = cp5.addTextarea("instructions")
  .setPosition(width/2 - 125, 125)
  .setSize(300, height - 150)
  .setColor(0)
  .setFont(createFont("arial",18))
  .setText("The aim of Tanks is to destroy your enemy tank before they destroy you. To destroy your enemy tank, you must hit them 5 times with a projectile. To shoot, use your mouse to click on the screen. Holding the mouse will show an arrow, which represents the initial speed and angle of the projectile. Releasing the mouse shoots the projectile based on the arrow.");
  ;
  howtoplaylabel = cp5.addLabel("howtoplay")
  .setPosition(width/2 - 112, 75)
  .setSize(225,50)
  .setColor(0)
  .setText("How To Play")
  .setFont(createFont("armalite.ttf",35));
  ;
  htpstart = cp5.addButton("HTPStart")
  .setLabel("Start")
  .setSize(100,50)
  .setPosition(width/2 - 50, height - 62.5)
  .setColor(new CColor(0, 0xff005000, 0, 0xff999999, 0));
  ;
  howtoplaywindow = true;
}
void rescreen(){
   background(135,206,250);
   for(int i = 0; i < walls.length;i++){
     walls[i].redraw();
   }
   fill(0,100,0);
   stroke(0,100,0);
   rect(600,0,200,400);
   myTank.redraw();
   yourTank.redraw();
}
   
void draw(){
  if(tankwindow){
    if(p!= null && p.exists){
      rescreen();
      p.move();
      }else if(p != null && !p.exists && p.exploding){
        p.explode();
    }
    if(myTank.exploding){
      myTank.explode();
    }
      if(yourTank.exploding){
      yourTank.explode();
    }
    if(restart.isPressed()){
      tankwindow = false;
      setupStartWindow();
    }
  }
  if(startwindow){
    if (start.isPressed()){
      setupTanksWindow();
      startwindow = false;
      start.setVisible(false);
      howtoplay.setVisible(false);
      tanks.setPosition(25, 25);
      tanks.setFont(createFont("armalite.ttf",25));
    }
    if(howtoplay.isPressed()){
      setupHowToPlayWindow();
      startwindow = false;
      howtoplay.setVisible(false);
      start.setVisible(false);
      tanks.setPosition(25, 25);
      tanks.setFont(createFont("armalite.ttf",25));
    }
  }
  if(howtoplaywindow){
    if(htpstart.isPressed()){
      setupTanksWindow();
      htpstart.setVisible(false);
      howtoplay.setVisible(false);
      tanks.setPosition(25, 25);
      tanks.setFont(createFont("armalite.ttf",25));
      howtoplaywindow = false;
    }
  }
}

float startX, startY, endX, endY;
void mousePressed(){
  if(tankwindow && mouseX < 600){
  endX = mouseX;
  endY = mouseY;
  if(turn){
  startX = myTank.xcoor+33;
  startY = myTank.ycoor + 7;
  }else{
    startX = yourTank.xcoor+25;
  startY = yourTank.ycoor + 7;
  }
  makeline();
  }
}


void mouseDragged(){
  if(tankwindow && mouseX < 600){
 endX = mouseX;
 endY = mouseY;
 rescreen();
 makeline();
  }
}

void mouseReleased(){
  if(tankwindow && mouseX < 600){
  if(turn){
    p = myTank.shoot(dist(startX, startY, endX, endY)/ 10, atan2(endY-startY, endX-startX));
  }else{
    p = yourTank.shoot(dist(startX, startY, endX, endY)/ 10, atan2(endY-startY, endX-startX));
  }
  turn = !turn;
  }
}

//creates line to represent initial velocity & angle
void makeline(){ 
  if(tankwindow){
    //Makes arrow representing initial velocity
    stroke(255,69,0);
    pushMatrix();
    translate(endX, endY);
    rotate(atan2(endY-startY, endX-startX));
    triangle(-10,-7, -10,7, 0,0);
    popMatrix();
    line(startX, startY, endX, endY);
    pushMatrix();
    if(turn){
      translate(myTank.xcoor+33, myTank.ycoor + 7);
    }else{
      translate(yourTank.xcoor+25, yourTank.ycoor + 7);
    }
    rotate(atan2(endY-startY,endX-startX));
    fill(0,100,0);
    stroke(0,100,0);
    rect(0,0, 30, 7);
    popMatrix();
  }
}
