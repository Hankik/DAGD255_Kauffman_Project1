class Circle extends Component {

  // variables
  float r;
  
  Circle(float r){
    
    this.r = r;
  }

  void update() {
  }

  void draw(float x, float y) {
    
    circle(x, y, r);
  }
  
  // when using, pass in owning actor location for x and y
  boolean checkCollision(float x, float y, float otherX, float otherY){
    if (dist(x, y, otherX, otherY) <= r) return true;
    else return false;
  }
}
