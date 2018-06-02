import processing.sound.*;
class Tank{
  float xcoor, ycoor;
  boolean exploding;
  boolean direction; //direction tank is facing: true is right, false is left
  PImage tank;
  float explodeFrame = 0;
  PImage explode = loadImage("explosion.png");
  
  Tank(float xcoor, float ycoor, boolean dir){
    this.xcoor = xcoor;
    this.ycoor = ycoor;
    direction = dir;
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
    shoot.play();
    return new Projectile(xcoor + 60, ycoor, velocity, angle);
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
  }
  
  void explode(){
image(explode, xcoor - (frameCount - explodeFrame)*16, ycoor - (frameCount - explodeFrame)*16, (frameCount - explodeFrame)*32, (frameCount - explodeFrame)*32);
  exploding = frameCount < explodeFrame + 12;
  if(!exploding){
    rescreen();
  }
  }
}
