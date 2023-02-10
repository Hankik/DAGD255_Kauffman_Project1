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
      circle(0, 0, parent.r*2);
      popMatrix();
    }
  }

  // when using, pass in owning actor location for x and y
  boolean checkCollision(float x, float y, float otherX, float otherY, float tongueSize) {
    if (dist(x, y, otherX, otherY) < parent.r + tongueSize*.5 ) return true;
    else return false;
  }
  
  boolean checkCollision(Actor parent, Actor other){
  
    if ( dist(parent.location.x, parent.location.y, other.location.x, other.location.y) < parent.r + other.r) return true;
    else return false;
  }
  
//  boolean checkCollision(PVector location, PVector otherLocation){
  
//    float dx = otherLocation.x - location.x;
//    float dy = otherLocation.y - location.y;
//    float dist = sqrt(dx 
//    return true;
//  }
}
