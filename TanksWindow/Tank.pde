class Tank{
  float xcoor, ycoor;
  boolean isHit;
  
  Tank(float xcoor, float ycoor){
    this.xcoor = xcoor;
    this.ycoor = ycoor;
    isHit = false;
    PImage tank = loadImage("tank.png");
    image(tank, xcoor, ycoor, 60, 30);
  }
  
  Projectile shoot(float velocity, float angle){
    return new Projectile(xcoor + 60, ycoor, velocity, angle);
  }
  void explode(){
    if(isHit){
      //explode stuff
    }
  }
}
