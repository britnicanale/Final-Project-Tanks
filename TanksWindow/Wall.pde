class Wall{
  //coordinates of top left and right coordinates, others must be bottom of window
  float leftX, leftY, rightX;
  
  Wall(float leftX, float leftY, float rightX){
    this.leftX = leftX;
    this.leftY = leftY;
    this.rightX = rightX;
    fill(139,69,19);
    stroke(139,69,19);
    rect(leftX, leftY, rightX-leftX, height - leftY);
  }
  void redraw(){
    fill(139,69,19);
    stroke(139,69,19);
    rect(leftX, leftY, rightX-leftX, height - leftY);
  }
}
