import processing.sound.*;

Tank myTank;
Tank[] tanks;
Wall[] walls;
Projectile p;
SoundFile shoot, explosion;


void setup(){
  size(800, 600);
  background(135,206,250);
  walls = new Wall[2];
  walls[0] = new Wall(0, height * 2 / 3, width);
  walls[1] = new Wall(225, 150, 275);
  tanks = new Tank[1];
  tanks[0] = new Tank( walls[1].rightX + 200, walls[0].leftY - 30, false);
  myTank = new Tank(walls[1].leftX / 2 - 60, walls[0].leftY - 30, true);
  fill(0,100,0);
  stroke(0,100,0);
  rect(myTank.xcoor + 33, myTank.ycoor, 30, 7);
  shoot = new SoundFile(this, "tanksound.mp3");
  explosion = new SoundFile(this, "explodesound.mp3");
}

void rescreen(){
   background(135,206,250);
   for(int i = 0; i < walls.length;i++){
     walls[i].redraw();
   }
   for(int i = 0; i < tanks.length;i++){
     tanks[i].redraw();
   }
   myTank.redraw();
}
   
void draw(){
  if(p!= null && p.exists){
    rescreen();
    p.move();
  }else if(p != null && !p.exists && p.exploding){
      p.explode();
  }  
}

float startX, startY, endX, endY;
void mousePressed(){
  endX = mouseX;
  endY = mouseY;
  startX = myTank.xcoor+33;
  startY = myTank.ycoor + 7;
  makeline();
}


void mouseDragged(){
 endX = mouseX;
 endY = mouseY;
 rescreen();
 makeline();
}

void mouseReleased(){
  if(myTank.direction && (endY-startY) < 0 && endX - startX > 0){
    p = myTank.shoot(dist(startX, startY, endX, endY)/ 10, atan((endY-startY)/(endX-startX)));
  }else if(!myTank.direction && endY - startY < 0 && endX - startX < 0){
    p = myTank.shoot(-dist(startX, startY, endX, endY)/ 10, PI + atan((endY-startY)/(endX-startX)));
  }
}

//creates line to represent initial velocity & angle
void makeline(){
  //Makes arrow representing initial velocity
  stroke(255,69,0);
  pushMatrix();
  translate(endX, endY);
  rotate(atan((endY-startY)/(endX-startX)));
  triangle(-10,-7, -10,7, 0,0);
  popMatrix();
  line(startX, startY, endX, endY);
  pushMatrix();
  translate(myTank.xcoor+33, myTank.ycoor + 7);
  if(myTank.direction && (endY-startY) < 0 && endX - startX > 0){
    rotate(atan((endY-startY)/(endX-startX)));
  }
  fill(0,100,0);
  stroke(0,100,0);
  rect(0,0, 30, 7);
  popMatrix();
}
