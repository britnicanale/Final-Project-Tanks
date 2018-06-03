class Projectile{
  float xcoor, ycoor, velocity, angle, xvel, initXvel, yvel, xacc;
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
    initXvel = xvel;
    yvel = velocity * sin(angle);
  }
  
  //returns Object that Projectile collided w/, null if no collisions.
  Object collide(){
    for(int i = 0; i < walls.length; i++){
      if(xcoor >= walls[i].leftX && ycoor >= walls[i].leftY && xcoor < walls[i].rightX){
        if(turn){
          wind = random(-.2, .2);
          xacc = wind;
          xvel = initXvel;
        }
        return walls[i];
      }
    }
      if( xcoor >= myTank.xcoor && ycoor >= myTank.ycoor && xcoor < myTank.xcoor + 60){
        if(turn){
          wind = random(-.2, .2);
          xacc = wind;
          xvel = initXvel;
        }
         return myTank;
      }
      if( xcoor >= yourTank.xcoor && ycoor >= yourTank.ycoor && xcoor < yourTank.xcoor + 60){
        if(turn){
          wind = random(-.2, .2);
          xacc = wind;
          xvel = initXvel;
      }
        return yourTank;
      }
  
    return null;
  }
  void move(){
     yvel += yacc;
    xvel += xacc;
    xcoor += xvel;
    ycoor += yvel;
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
      //obj.setExploding(true); WHY DOESN"T THIS WORK
      Tank t = (Tank) obj;
      tankExplosion.play();
      t.setExploding(true);
      t.explodeFrame = frameCount;
    }
    if((xcoor > width - 200 || xcoor < 0) || ycoor > height){
        explosion.play();
      exists = false;
      rescreen();
      if(turn){
        wind = random(-.2, .2);
        xacc = wind;
        xvel = initXvel;
    }
    }
  }
  
  //Called when Projectile collides

  
  void explode(){
  //insert explode animation
  rescreen();
  image(explode, explodeX - (frameCount - explodeframe)*8, explodeY - (frameCount - explodeframe)*8, (frameCount - explodeframe)*16, (frameCount - explodeframe)*16);
  exploding = frameCount < explodeframe + 12;
  if(frameCount > explodeframe + 12){
  }
  if(!exploding){
    rescreen();  
    exists = false;
  }
  }
  
}
