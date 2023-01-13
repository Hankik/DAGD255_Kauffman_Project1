class Circle extends Component {

  // variables
  float r;

  Circle(float r) {

    this.r = r;
  }

  void update() {
  }

  void draw(float x, float y) {
    if (isVisible) {

      pushMatrix();
      translate(x, y);
      fill(fill);
      circle(0 - r/2, 0 - r/2, r);
      popMatrix();
    }
  }

  // when using, pass in owning actor location for x and y
  boolean checkCollision(float x, float y, float otherX, float otherY) {
    if (dist(x, y, otherX, otherY) <= r) return true;
    else return false;
  }
}
