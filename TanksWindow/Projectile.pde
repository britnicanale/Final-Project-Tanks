class Projectile{
  float xcoor, ycoor, velocity, angle, xvel, yvel;
  static final float yacc = .5;
  boolean exists = true;
  boolean exploding = false;
   PImage explode = loadImage("explosion.png");
   float explodeframe = 0;
  float explodeX, explodeY;
  
  Projectile(float xcoor, float ycoor, float initVelocity, float initAngle){
    this.xcoor = xcoor;
    this.ycoor = ycoor;
    velocity = initVelocity;
    angle = initAngle;
    fill(255,69,0);
    ellipse(xcoor, ycoor, 15, 15);
    xvel = velocity * cos(angle);
    yvel = velocity * sin(angle);
  }
  
  //returns Object that Projectile collided w/, null if no collisions.
  Object collide(){
    for(int i = 0; i < walls.length; i++){
      if(xcoor >= walls[i].leftX && ycoor >= walls[i].leftY && xcoor < walls[i].rightX){
        return walls[i];
      }
    }
      if( xcoor >= myTank.xcoor && ycoor >= myTank.ycoor && xcoor < myTank.xcoor + 60){
        return myTank;
      }
      if( xcoor >= yourTank.xcoor && ycoor >= yourTank.ycoor && xcoor < yourTank.xcoor + 60){
        return yourTank;
      }
  
    return null;
  }
  void move(){
    xcoor += xvel;
    ycoor += yvel;
    yvel += yacc;
    fill(255,69,0);
    ellipse(xcoor, ycoor, 15, 15);
    Object obj = collide();
    if(obj != null){
      explosion.play();
      exists = false;
      explodeframe = frameCount;
      explodeX = xcoor;
      explodeY = ycoor;
      exploding = true;
    } 
    if(obj instanceof Tank){
      //
    }
    if((xcoor > width + 10|| xcoor < 0) || ycoor > height){
      exists = false;
    }
  }
  
  //Called when Projectile collides

  
  void explode(){
  //insert explode animation
  rescreen();
  image(explode, explodeX - (frameCount - explodeframe)*8, explodeY - (frameCount - explodeframe)*8, (frameCount - explodeframe)*16, (frameCount - explodeframe)*16);
  exploding = frameCount < explodeframe + 12;
  if(!exploding){
    rescreen();  
    exists = false;
  }
  }
  
}
