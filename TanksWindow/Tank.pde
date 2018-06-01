import processing.sound.*;
class Tank{
  float xcoor, ycoor;
  boolean isHit;
  boolean direction; //direction tank is facing: true is right, false is left
  PImage tank;
  
  
  Tank(float xcoor, float ycoor, boolean dir){
    this.xcoor = xcoor;
    this.ycoor = ycoor;
    isHit = false;
    direction = dir;
    if(direction){
      tank = loadImage("tankright.png");
    }
    else{
      tank = loadImage("tankleft.png");
    }
    image(tank, xcoor, ycoor, 60, 30);
  fill(0,100,0);
    if(direction){
    rect(myTank.xcoor + 33, myTank.ycoor, 30, 7);
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
       rect(myTank.xcoor + 33, myTank.ycoor, 30, 7);
     }
  }
  void explode(){
    if(isHit){
      //explode stuff
    }
  }
}
