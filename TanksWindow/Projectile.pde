class Projectile{
  float xcoor, ycoor, velocity, angle, xvel, yvel;
  static final float yacc = .5;
  boolean exists = true;
  
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
    for(int i = 0; i < tanks.length; i++){
      if( xcoor >= tanks[i].xcoor && ycoor >= tanks[i].ycoor && xcoor < tanks[i].xcoor + 60){
        return tanks[i];
      }
    }
    return null;
  }
  void move(){
    xcoor += xvel;
    ycoor += yvel;
    yvel += yacc;
    ellipse(xcoor, ycoor, 15, 15);
    Object obj = collide();
    if(obj != null){
      explode();
    }
      
    
  }
  //Called when Projectile collides
  void explode(){
    //insert explode animation
    //insert sound later
    exists = false;
  }
  
}
