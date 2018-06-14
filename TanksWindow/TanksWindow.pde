import processing.sound.*;
import controlP5.*;


ControlP5 startwindow, tankswindow, howtoplaywindow, htptankswindow, winnerwindow; //Different windows with different buttons, labels, and textareas
Tank myTank, yourTank; 
Wall[] walls;
Projectile p;
SoundFile shoot, explosion, tankExplosion;
boolean turn; // Determines which tank's turn it is; true is left, false is right
Button start, howtoplay, htpstart, restart, htptanks, resume, playagain, exit; 
Textlabel tankslabel, TWtankslabel, howtoplaylabel, congratslabel, htptankslabel, menulabel, twhowtoplaylabel, playerone, playertwo;
Textfield playeroneinput, playertwoinput;
Textarea instructions, twinstructions;
PImage heart; // For lives
float wind; //X accelleration representing wind
boolean paused; //determines if functionality is paused after a button press (to avoid bad actions)
int pauseframe;//determines when first paused
String pausebefore; //to identify action taken after pause
   
void setup(){
   size(800, 400);
   
   shoot = new SoundFile(this, "tanksound.mp3"); // played when tank shoots
   explosion = new SoundFile(this, "explodesound.mp3"); // played when projectile explodes
   tankExplosion = new SoundFile(this, "tankexplodesound.mp3"); //Plays when tank explodes
   heart =  loadImage("heart.png"); //For lives
   
   p = new Projectile(-10,-10, 0, 0); //initializes projectile off screen
  paused = false;
  
  createWindows(); // creates each window and makes them invisible to start
  setupStartWindow();
}

void createWindows(){
  startwindow = new ControlP5(this);
  tankslabel = startwindow.addTextlabel("TANKSlabel")
   .setText("TANKS")
   .setPosition(312.5,50)
   .setSize(175,50)
   .setFont(createFont("armalite.ttf",50))
   .setColor(0);
   ;
  playerone = startwindow.addTextlabel("Player One")
  .setText("Player One:")
  .setPosition(width/2 - 125, 125)
  .setFont(createFont("armalite.ttf",15))
  .setColor(0);
  ;
  playeroneinput = startwindow.addTextfield("Player One Input")
  .setWidth(100)
  .setColor(new CColor(0, color(256,256,256), 0, color(135,206,250), 0))
  .setPosition(width/2 - 125, 150);
  ;
  playertwo = startwindow.addTextlabel("Player Two")
  .setText("Player Two:")
  .setPosition(width/2 + 25, 125)
  .setFont(createFont("armalite.ttf",15))
  .setColor(0);
  ;
   playertwoinput = startwindow.addTextfield("Player Two Input")
  .setWidth(100)
  .setColor(new CColor(0, color(256,256,256), 0, color(135,206,250), 0))
  .setPosition(width/2 + 25, 150);
  ;
  start = startwindow.addButton("Start")
  .setLabel("Start")  
  .setSize(100,50)
  .setPosition(width/2 - 50, 200)
  .setColor(new CColor(0, 0xff005000, 0, 0xff999999, 0));
   ;
  howtoplay = startwindow.addButton("How To Play")
  .setLabel("How To Play")
  .setSize(100,50)
  .setPosition(width/2 - 50, 275)
  .setColor(new CColor(0, 0xff005000, 0, 0xff999999, 0));
  ;
  startwindow.setVisible(false);
  
  tankswindow = new ControlP5(this);
  TWtankslabel = tankswindow.addTextlabel("twTANKSlabel")
   .setText("TANKS")
   .setPosition(25,25)
   .setSize(175,50)
   .setFont(createFont("armalite.ttf",25))
   .setColor(255);
   ;
   menulabel = tankswindow.addTextlabel("MenuLabel")
   .setText("MENU")
   .setPosition(650,50)
   .setSize(100,50)
   .setFont(createFont("armalite.ttf",35))
   .setColor(255);
   ;
 htptanks = tankswindow.addButton("How to Play TANKS")
  .setLabel("How To Play")
  .setSize(100,50)
  .setPosition(650, 125)
  .setColor(new CColor(0, 0, 0, 0xff999999, 0));
  ;
  restart = tankswindow.addButton("Restart")
   .setLabel("Restart")
   .setSize(100,50)
   .setColor(new CColor(0, 0, 0, 0xff999999, 0))
   .setPosition(650, 200);
  ;
  tankswindow.setVisible(false);
  
  howtoplaywindow = new ControlP5(this); 
   instructions = howtoplaywindow.addTextarea("instructions")
  .setPosition(width/2 - 125, 125)
  .setSize(300, height - 150)
  .setColor(0)
  .setFont(createFont("arial",18))
  .setText("The aim of Tanks is to destroy your enemy tank before they destroy you. To destroy your enemy tank, you must hit them 5 times with a projectile. To shoot, use your mouse to click on the screen. Holding the mouse will show an arrow, which represents the initial speed and angle of the projectile. Releasing the mouse shoots the projectile based on the arrow.");
  ;
  htptankslabel = howtoplaywindow.addTextlabel("htpTANKSlabel")
 .setText("TANKS")
 .setPosition(25,25)
 .setSize(175,50)
 .setFont(createFont("armalite.ttf",25))
 .setColor(0);
 ;
  howtoplaylabel = howtoplaywindow.addLabel("howtoplay")
  .setPosition(width/2 - 112, 75)
  .setSize(225,50)
  .setColor(0)
  .setText("How To Play")
  .setFont(createFont("armalite.ttf",35));
  ;
  htpstart = howtoplaywindow.addButton("HTPStart")
  .setLabel("Start")
  .setSize(100,50)
  .setPosition(width/2 - 50, height - 62.5)
  .setColor(new CColor(0, 0xff005000, 0, 0xff999999, 0));
  ;
  howtoplaywindow.setVisible(false);

  htptankswindow = new ControlP5(this);
 
  twinstructions = htptankswindow.addTextarea("twinstructions")
  .setPosition(125, 150)
  .setSize(350, 150)
  .setColor(255)
  .setFont(createFont("arial",18))
  .setText("The aim of Tanks is to destroy your enemy tank before they destroy you. To destroy your enemy tank, you must hit them 5 times with a projectile. To shoot, use your mouse to click on the screen. Holding the mouse will show an arrow, which represents the initial speed and angle of the projectile. Releasing the mouse shoots the projectile based on the arrow.");
  ;
  twhowtoplaylabel = htptankswindow.addTextlabel("twhowtoplaylabel")
 .setText("How to Play")
 .setPosition(200, 100)
 .setSize(177,50)
 .setFont(createFont("armalite.ttf",25))
 .setColor(255);
 ;
  resume = htptankswindow.addButton("Resume")
  .setLabel("Resume")
  .setSize(100,50)
  .setPosition(width/2 - 50, 325)
  .setColor(new CColor(0, 0xff005000, 0, 0xff999999, 0));
  ;
  htptankswindow.setVisible(false);
  
  winnerwindow = new ControlP5(this);
  congratslabel = winnerwindow.addTextlabel("congratslabel")
 .setText("Congrats")
 .setPosition(625,50)
 .setSize(175,50)
 .setFont(createFont("armalite.ttf",15))
 .setColor(255);
 ;
  
  playagain = winnerwindow.addButton("Play Again")
  .setLabel("Play Again")
  .setPosition(650, 100)
  .setSize(100,50)
  .setColor(new CColor(0, 0, 0, 0xff999999, 0));
  ;
  exit = winnerwindow.addButton("Exit")
  .setLabel("Exit")
  .setPosition(650, 175)
  .setSize(100,50)
  .setColor(new CColor(0, 0, 0, 0xff999999, 0));
  ;
  winnerwindow.setVisible(false);
}
void setupStartWindow(){
  background(135,206,250);//Sky Blue
  startwindow.setVisible(true);
}

void setupTanksWindow(){
  background(135,206,250); //Sky Blue
  //Randomizes height & width of walls & location of tanks each time a new game is created
  walls = new Wall[3];
  walls[0] = new Wall(random(225,275), random(50,150), random(325, 375) );
  walls[1] = new Wall(0, random(200,350), walls[0].leftX);
  walls[2] = new Wall(walls[0].rightX, random(200,350), width-200);
  yourTank = new Tank( walls[0].rightX + random(50,150), walls[2].leftY - 30, false, "Player 2");
  myTank = new Tank(walls[0].leftX - random(100,200), walls[1].leftY - 30, true, "Player 1");
  
  //Menu bar
  fill(0,100,0);
  stroke(0,100,0);
  rect(600,0,200,400);
  
  
  turn = true;//Starts as player 1s turn
  tankswindow.setVisible(true);
  
  //Adds lives to screen

  fill(256, 0, 0);
   stroke(256, 0, 0);
     image(heart, myTank.xcoor, 75, 15, 15);
rect(myTank.xcoor + 7, 77,60 -12*myTank.numHits, 10);
  image(heart, yourTank.xcoor, 75, 15, 15);
  rect(yourTank.xcoor + 7, 77, 60 - 12*yourTank.numHits, 10);
  //Arrow representing the amount of wind
  stroke(256,256, 256);
  fill(256,256, 256);
  line(300, 25, 300+ 200* wind, 25);
  if(wind>0){
      triangle(300+ 200* wind, 25, 300+ 200* wind - 7, 20, 300+ 200* wind - 7, 30);
  }else{
    triangle(300+ 200* wind, 25, 300+ 200* wind + 7, 20, 300+ 200* wind + 7, 30);
  }

}

void setupHowToPlayWindow(){
  background(135,206,250);
  howtoplaywindow.setVisible(true);
}
void setupHTPTanks(){
  fill(0);
  stroke(0);
  rect(100,75,400, 300);
  htptankswindow.setVisible(true);
}

void setupWinnerWindow(String name){
  fill(0,100,0);
   stroke(0,100,0);
   rect(600,0,200,400);
  congratslabel.setText("Congrats " + name);
  winnerwindow.setVisible(true);
}

//redraws tankswindow so the projectile appears to be moving
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
   
   
   //Draws lives
   fill(256, 0, 0);
   stroke(256, 0, 0);
     image(heart, myTank.xcoor, 75, 15, 15);
rect(myTank.xcoor + 7, 77,60 -12*myTank.numHits, 10);
  image(heart, yourTank.xcoor, 75, 15, 15);
  rect(yourTank.xcoor + 7, 77, 60 - 12*yourTank.numHits, 10);
  
  //Represents wind
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
  //Tried to "pause" the sketch to stop any actions from accidentally being triggered after I pressed a certain button
  if(paused){
    if(pauseframe + 10 >= frameCount){
      paused = false;
    }else{
      return;
    }
  }
  if(tankswindow.isVisible()){
    if(myTank.numHits >= 5 && !myTank.exploding){
      setupWinnerWindow(yourTank.name);
      tankswindow.setVisible(false);
      paused = true;
      pauseframe = frameCount;
      return;
  }
  if(yourTank.numHits >= 5 && !yourTank.exploding){
      setupWinnerWindow(myTank.name);
      tankswindow.setVisible(false);
      paused = true;
      pauseframe = frameCount;
      return;
  }
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
    if(pressed(restart)){
      tankswindow.setVisible(false);
      setupStartWindow();
      paused = true;
      pauseframe = frameCount;
      return;
    }
    if(pressed(htptanks)){
      tankswindow.setVisible(false);
      setupHTPTanks(); 
      paused = true;
      pauseframe = frameCount;
      return;
    }
  }
  if(htptankswindow.isVisible()){
    if(pressed(resume)){
      rescreen();
      htptankswindow.setVisible(false);
      tankswindow.setVisible(true);
       paused = true;
      pauseframe = frameCount;
      return;
    }
  }
  if(startwindow.isVisible()){
    if (pressed(start)){
      startwindow.setVisible(false);
       setupTanksWindow();
        paused = true;
      pauseframe = frameCount;
      if(playeroneinput.getText() == null){
      myTank.name = "Player One";
    }else{
      myTank.name = playeroneinput.getText();
    }if(playertwoinput.getText() == null){
      yourTank.name = "Player Two";
    }else{
      yourTank.name = playertwoinput.getText();
    }
      return;
    }
    if(pressed(howtoplay)){
       startwindow.setVisible(false);
      setupHowToPlayWindow();
       paused = true;
      pauseframe = frameCount;
      if(playeroneinput.getText() == null){
      myTank.name = "Player One";
    }else{
      myTank.name = playeroneinput.getText();
    }if(playertwoinput.getText() == null){
      yourTank.name = "Player Two";
    }else{
      yourTank.name = playertwoinput.getText();
    }
      return;
    }
  }
  if(howtoplaywindow.isVisible()){
    if(pressed(htpstart)){
      howtoplaywindow.setVisible(false);
      setupTanksWindow();
       paused = true;
      pauseframe = frameCount;
      return;
    }
  }
  if(winnerwindow.isVisible()){
    if(pressed(playagain)){
      winnerwindow.setVisible(false);
      setupStartWindow();
       paused = true;
      pauseframe = frameCount;
      return;
      //pausebefore = "SW";
    }
    if(pressed(exit)){
      exit();
    }
  }
}

//Creates arrow representing initial velocity and angle
float startX, startY, endX, endY;
void mousePressed(){
  if(!paused && tankswindow.isVisible() && mouseX < 600 && !p.exists){
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
  if(!paused && tankswindow.isVisible() && mouseX < 600 && !p.exists){
 endX = mouseX;
 endY = mouseY;
 rescreen();
 makeline();
  }
}

//Shoots the projectile
void mouseReleased(){
  if(!paused && tankswindow.isVisible() && mouseX < 600 && !p.exists){
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
  if(!paused && tankswindow.isVisible()){
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

boolean pressed(Button b){
  float[] pos = b.getPosition();
  return mousePressed && mouseX > pos[0] && mouseY > pos[1] && mouseX < (pos[0] + b.getWidth()) && mouseY < (pos[1] + b.getHeight());
}
