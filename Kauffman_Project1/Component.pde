abstract class Component {

  // variables
  String name = "";
  boolean isVisible = false;
  color fill = WHITE;
  
  abstract void update();
  
  abstract void draw(float x, float y);
  
  // a method to determine if component needs drawn
  void setVisibility(boolean isVisible){
  
    this.isVisible = isVisible;
  }
  
  void setColor(color fill){
  
    this.fill = fill;
  }
}
