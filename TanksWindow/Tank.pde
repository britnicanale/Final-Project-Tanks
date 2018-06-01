import processing.sound.*;
class Tank{
  float xcoor, ycoor;
  boolean isHit;
  PImage tank = loadImage("tank.png");
  
  Tank(float xcoor, float ycoor){
    this.xcoor = xcoor;
    this.ycoor = ycoor;
    isHit = false;
    image(tank, xcoor, ycoor, 60, 30);
  }
  
  Projectile shoot(float velocity, float angle){
    shoot.play();
    return new Projectile(xcoor + 60, ycoor, velocity, angle);
  }
  void redraw(){
     image(tank, xcoor, ycoor, 60, 30);
  }
  void explode(){
    if(isHit){
      //explode stuff
    }
  }
}
