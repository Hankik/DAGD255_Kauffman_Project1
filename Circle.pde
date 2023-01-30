class Circle extends Component {

  // variables
  Actor parent;

  Circle(Actor parent, float r) {

    name = "circle";
    this.parent = parent;
    parent.r = r;
  }

  void update(float x, float y) {
  }

  void draw(float x, float y) {
    if (isVisible) {

      pushMatrix();
      translate(x, y);
      fill(fill);
      circle(0 + parent.r/2, 0 + parent.r/2, parent.r*2);
      popMatrix();
    }
  }

  // when using, pass in owning actor location for x and y
  boolean checkCollision(float x, float y, float otherX, float otherY) {
    if (dist(x + parent.r/2, y + parent.r/2, otherX, otherY) <= parent.r) return true;
    else return false;
  }
  
//  boolean checkCollision(PVector location, PVector otherLocation){
  
//    float dx = otherLocation.x - location.x;
//    float dy = otherLocation.y - location.y;
//    float dist = sqrt(dx 
//    return true;
//  }
}
