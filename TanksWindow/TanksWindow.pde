import processing.sound.*;
import controlP5.*;

ControlP5 cp5;
Tank myTank, yourTank;
Wall[] walls;
Projectile p;
SoundFile shoot, explosion, tankExplosion;
boolean turn;
boolean tankwindow, startwindow, howtoplaywindow, htptankswindow;
Button start, howtoplay, htpstart, restart, htptanks, resume;
Textlabel tanks, howtoplaylabel, menu;
Textarea instructions;
PImage heart;
float wind;

void setup(){
   size(800, 400);
   cp5 = new ControlP5(this);
   tankwindow = false;
   howtoplaywindow = false;
   setupStartWindow();
   shoot = new SoundFile(this, "tanksound.mp3"); // played when tank shoots
   explosion = new SoundFile(this, "explodesound.mp3"); // played when projectile explodes
   tankExplosion = new SoundFile(this, "tankexplodesound.mp3"); //Plays when tank explodes
   heart =  loadImage("heart.png");
   p  = new Projectile(-10,-10,0,0);//Initializes a projectile off screen
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
  walls = new Wall[3];
  walls[0] = new Wall(random(225,275), random(50,150), random(325, 375) );
  walls[1] = new Wall(0, random(200,350), walls[0].leftX);
  walls[2] = new Wall(walls[0].rightX, random(200,350), width-200);
  yourTank = new Tank( walls[0].rightX + random(50,150), walls[2].leftY - 30, false, "Player 2");
  myTank = new Tank(walls[0].leftX - random(100,200), walls[1].leftY - 30, true, "Player 1");
  fill(0,100,0);
  stroke(0,100,0);

  rect(600,0,200,400);
  
  turn = false;
 tanks = cp5.addTextlabel("TANKS")
 .setText("TANKS")
 .setPosition(25,25)
 .setSize(175,50)
 .setFont(createFont("armalite.ttf",50))
 .setLineHeight(14)
 .setColor(0)
 ;
 htptanks = cp5.addButton("How to Play")
 .setLabel("How To Play")
  .setSize(100,50)
  .setPosition(650, 50)
  .setColor(new CColor(0, 0, 0, 0xff999999, 0));
  ;
  restart = cp5.addButton("Restart")
   .setLabel("Restart")
   .setSize(100,50)
   .setColor(new CColor(0, 0, 0, 0xff999999, 0))
   .setPosition(650, 125);
  ;
  for(int i = 0; i < 5-myTank.numHits; i++){
    image(heart, myTank.xcoor + i*20, 75, 15, 15);
  }
  for(int i = 0; i < 5-yourTank.numHits; i++){
    image(heart, yourTank.xcoor + i*20, 75, 15, 15);
  }
  stroke(256,256, 256);
  fill(256,256, 256);
  line(300, 25, 300+ 200* wind, 25);
  tankwindow = true;
  if(wind>0){
      triangle(300+ 200* wind, 25, 300+ 200* wind - 7, 20, 300+ 200* wind - 7, 30);
  }else{
    triangle(300+ 200* wind, 25, 300+ 200* wind + 7, 20, 300+ 200* wind + 7, 30);
  }
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
  tanks = cp5.addTextlabel("TANKS")
 .setText("TANKS")
 .setPosition(25,25)
 .setSize(175,50)
 .setFont(createFont("armalite.ttf",50))
 .setColor(0)
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
void setupHTPTanks(){
  fill(0);
  stroke(0);
  rect(100,75,400, 300);
  instructions = cp5.addTextarea("instructions")
  .setPosition(125, 150)
  .setSize(350, 150)
  .setColor(99)
  .setFont(createFont("arial",18))
  .setText("The aim of Tanks is to destroy your enemy tank before they destroy you. To destroy your enemy tank, you must hit them 5 times with a projectile. To shoot, use your mouse to click on the screen. Holding the mouse will show an arrow, which represents the initial speed and angle of the projectile. Releasing the mouse shoots the projectile based on the arrow.");
  ;
  resume = cp5.addButton("Resume")
  .setLabel("Resume")
  .setSize(100,50)
  .setPosition(width/2 - 50, 325)
  .setColor(new CColor(0, 0xff005000, 0, 0xff999999, 0));
  ;
  htptankswindow = true;
}

void setupWinnerWindow(String name){
  congrats = cp5.addTextlabel("Congrats")
  .setLabel("Congrats " + name + "!");
  ;
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
   for(int i = 0; i < 5-myTank.numHits; i++){
    image(heart, myTank.xcoor + i*20, 75, 15, 15);
  }
  for(int i = 0; i < 5-yourTank.numHits; i++){
    image(heart, yourTank.xcoor + i*20, 75, 15, 15);
  }
  stroke(256,256, 256);
  fill(256,256, 256);
  line(300, 25, 300+ 200* wind, 25);
  if(wind>0){
      triangle(300+ 200* wind, 25, 300+ 200* wind - 7, 20, 300+ 200* wind - 7, 30);
  }else{
    triangle(300+ 200* wind, 25, 300+ 200* wind + 7, 20, 300+ 200* wind + 7, 30);
  }
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
      restart.remove();
      setupStartWindow();
      htptanks.remove();
    }
    if(htptanks.isPressed()){
      tankwindow = false;
      setupHTPTanks();
      htptanks.remove();
      restart.remove();
    }
  }
  if(htptankswindow){
    if(resume.isPressed()){
      resume.remove();
      rescreen();
      htptankswindow = false;
      htptanks = cp5.addButton("How to Play")
       .setLabel("How To Play")
        .setSize(100,50)
        .setPosition(650, 50)
        .setColor(new CColor(0, 0, 0, 0xff999999, 0));
        ;
      restart = cp5.addButton("Restart")
       .setLabel("Restart")
       .setSize(100,50)
       .setColor(new CColor(0, 0, 0, 0xff999999, 0))
       .setPosition(650, 125);
      ;
      instructions.remove();
      p  = new Projectile(-10,-10,0,0);//Initializes a projectile off screen
      tankwindow = true;
    }
  }
  if(startwindow){
    if (start.isPressed()){
      setupTanksWindow();
      startwindow = false;
      start.remove();
      howtoplay.remove();
      tanks.setPosition(25, 25);
      tanks.setFont(createFont("armalite.ttf",25));
    }
    if(howtoplay.isPressed()){
      setupHowToPlayWindow();
      startwindow = false;
      howtoplay.remove();
      start.remove();
      tanks.remove();
      tanks.setFont(createFont("armalite.ttf",25));
    }
  }
  if(howtoplaywindow){
    if(htpstart.isPressed()){
      setupTanksWindow();
      htpstart.remove();
      howtoplaylabel.remove();
      instructions.remove();
      tanks.remove();
      tanks.setFont(createFont("armalite.ttf",25));
      howtoplaywindow = false;
    }
  }
}

float startX, startY, endX, endY;
void mousePressed(){
  if(tankwindow && mouseX < 600 && !p.exists){
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
  if(tankwindow && mouseX < 600 && !p.exists){
 endX = mouseX;
 endY = mouseY;
 rescreen();
 makeline();
  }
}

void mouseReleased(){
  if(tankwindow && mouseX < 600 && !p.exists){
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
    fill(255,69,0);
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
