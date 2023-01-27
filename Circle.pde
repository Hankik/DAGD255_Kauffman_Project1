class Circle extends Component {

  // variables
  float r;

  Circle(float r) {

    name = "circle";
    this.r = r;
  }

  void update(float x, float y) {
  }

  void draw(float x, float y) {
    if (isVisible) {

      pushMatrix();
      translate(x, y);
      fill(fill);
      circle(0 + r/2, 0 + r/2, r*2);
      popMatrix();
    }
  }

  // when using, pass in owning actor location for x and y
  boolean checkCollision(float x, float y, float otherX, float otherY) {
    if (dist(x + r/2, y + r/2, otherX, otherY) <= r) return true;
    else return false;
  }
  
//  boolean checkCollision(PVector location, PVector otherLocation){
  
//    float dx = otherLocation.x - location.x;
//    float dy = otherLocation.y - location.y;
//    float dist = sqrt(dx 
//    return true;
//  }
}
