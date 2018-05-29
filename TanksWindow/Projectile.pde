class Projectile{
  float xcoor, ycoor, velocity, angle;
  Projectile(float xcoor, float ycoor, float initVelocity, float initAngle){
    this.xcoor = xcoor;
    this.ycoor = ycoor;
    velocity = initVelocity;
    angle = initAngle;
  }
  
  //returns Object that Projectile collided w/, null if no collisions.
  Object collide(){
    
  //Called when Projectile collides
  void explode(){
    //insert explode animation
    this = null;
    //insert sound later
  }
  
}
