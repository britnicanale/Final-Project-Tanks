import processing.sound.*;
class Tank{
  float xcoor, ycoor;
  boolean exploding = false;
  boolean direction; //direction tank is facing: true is right, false is left
  PImage tank;
  float explodeFrame = 0;
  PImage explode = loadImage("explosion.png");
  float numHits;
  String name;
  
  Tank(float xcoor, float ycoor, boolean dir, String n){
    this.xcoor = xcoor;
    this.ycoor = ycoor;
    direction = dir;
    name = n;
    if(direction){
      tank = loadImage("tankright.png");
    }
    else{
      tank = loadImage("tankleft.png");
    }
    image(tank, xcoor, ycoor, 60, 30);
  fill(0,100,0);
  stroke(0,100,0);
    if(direction){
    rect(xcoor + 33, ycoor, 30, 7);
    }else{
      rect(xcoor+ 25, ycoor, -30, 7);
    }
  }
  
  Projectile shoot(float velocity, float angle){
    print(p.xacc);
    shoot.play();
    if(direction){
    return new Projectile(xcoor+33, ycoor + 7, velocity, angle);
    }else{
      return new Projectile(xcoor + 25, ycoor + 7, velocity, angle);
    }
  }
  void redraw(){
     image(tank, xcoor, ycoor, 60, 30);
     if(!mousePressed){
        fill(0,100,0);
        stroke(0,100,0);
        if(direction){
       rect(xcoor + 33, ycoor, 30, 7);
        }
        else{
           rect(xcoor+ 25, ycoor, -30, 7);
        }
     }
  }
  void setExploding(boolean exp){
    exploding = exp;
    numHits++;
    
  }
  
  //called while the tank is still exploding
  void explode(){
  image(explode, xcoor - (frameCount - explodeFrame)*8, ycoor - (frameCount - explodeFrame)*8, (frameCount - explodeFrame)*16, (frameCount - explodeFrame)*16);
  exploding = frameCount < explodeFrame + 48;
  if(!exploding){
    if(numHits >= 5){
      /*htptanks.setVisible(false);
      htptanks.remove();
      restart.setVisible(false);
      restart.remove();
      tanks.remove();*/
      tankswindow.setVisible(false);
      setupWinnerWindow(name);
    }else{
    rescreen();
    }
    
  }
  }
}
