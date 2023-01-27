abstract class Component {

  // variables
  String name = "";
  color fill = WHITE;
  float angleToTarget = 0;
  boolean isVisible = false;
  
  abstract void update(float x, float y);
  
  abstract void draw(float x, float y);
  
  // a method to determine if component needs drawn
  void setVisibility(boolean isVisible){
  
    this.isVisible = isVisible;
  }
  
  void setColor(color fill){
  
    this.fill = fill;
  }
  
  float findAngleToTarget(PVector target, float x, float y) { 
    float dx = target.x - x;
    float dy = target.y - y;
    angleToTarget = atan2(dy, dx);
    return angleToTarget;
  }
}
