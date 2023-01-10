class Frog extends Actor {

  // variables
  PImage sprite = loadImage("frog.png"); // image size is 64 x 64 pixels
  Circle body = new Circle(32);
  FrogTongue tongue = new FrogTongue();

  // constructor
  Frog() {

    name = "frog";
    addComponent(body);
    addComponent(tongue);
  }

  void update() {
    super.update(); // perform actor super class updates

    if (mousePressed && body.checkCollision(location.x, location.y, mouseX, mouseY)) {  // MOVE THIS TO ITS OWN METHOD
      tongue.setVisibility(true);
      tongue.targetLocation = new PVector(mouseX, mouseY);
    } else {
      tongue.setVisibility(false);
    }


      super.draw(); // perform actor super class draws
    draw();
  }

  void draw() {

    pushMatrix();
    image(sprite, location.x - 32, location.y - 32);
    popMatrix();
  }
}

class FrogTongue extends Component {

  // variables
  PVector targetLocation = new PVector();
  Actor target = null;
  float tongueWidth = 20;

  FrogTongue() {
  }

  void update() {
  }

  void draw(float x, float y) {
    if (isVisible) {

      pushMatrix();
      fill(TONGUE);
      rect(x, y, dist(x, y, targetLocation.x, targetLocation.y), tongueWidth);
      rotate(findAngleToTarget(targetLocation, x, y));
      popMatrix();
    }
  }
}
