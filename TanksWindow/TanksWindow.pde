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
  tanks[0] = new Tank( walls[1].rightX + 200, walls[0].leftY - 30);
  myTank = new Tank(walls[1].leftX / 2 - 60, walls[0].leftY - 30);
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
  startX = myTank.xcoor + 60;
  startY = myTank.ycoor;
}


void mouseDragged(){
 endX = mouseX;
 endY = mouseY;
 rescreen();
 makeline();
}

void mouseReleased(){
  endX = mouseX;
  endY = mouseY;
 
  makeline();
  p = myTank.shoot(dist(startX, startY, endX, endY)/ 10, atan((endY-startY)/(endX-startX)));
}

//creates line to represent initial velocity & angle
void makeline(){
stroke(255,255, 255);
  line(startX, startY, endX, endY);
}
