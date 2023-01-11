class Frog extends Actor {

  // variables
  PImage sprite = loadImage("frog.png"); // image size is 64 x 64 pixels
  Circle body = new Circle(32);
  FrogTongue tongue = new FrogTongue();

  // constructor
  Frog() {

    name = "frog";
    addComponent(body)
      .addComponent(tongue);
  }

  void update() {
    super.update(); // perform actor super class updates



    draw();
    super.draw(); // perform actor super class draws
  }

  void draw() {

    pushMatrix();
    image(sprite, location.x - 32, location.y - 32);
    popMatrix();
  }

  void mousePressed() {
    if (body.checkCollision(location.x, location.y, mouseX, mouseY)) {
      tongue.state = TongueState.ATTACK;
    }
  }

  void mouseReleased() {
  }
}

class FrogTongue extends Component {  // NEEDS MORE COMMENTING

  // variables
  PVector targetLocation = new PVector(0, 0);
  Actor target = null;
  TongueState state = TongueState.IDLE;
  float tongueWidth = 4;
  float tongueLength = 1;

  FrogTongue() {
  }

  void update() {
    handleState(state);
  }

  void draw(float x, float y) {
    if (state == TongueState.ATTACK) {

      pushMatrix();
      translate(x, y);
      noStroke();
      fill(TONGUE);
      rotate(findAngleToTarget(targetLocation, x, y));
      rect(2, -2, dist(x, y, targetLocation.x, targetLocation.y), tongueWidth);
      stroke(4);
      popMatrix();
    } else if (state == TongueState.PULL) {

      pushMatrix();
      translate(x, y);
      noStroke();
      fill(TONGUE);
      rotate(findAngleToTarget(targetLocation, x, y));
      rect(2, -2, dist(x, y, targetLocation.x, targetLocation.y) * tongueLength, tongueWidth);
      stroke(4);
      popMatrix();
    }
  }

  void handleState(TongueState state) {

    switch (state) {

    case ATTACK:
      setVisibility(true);
      if (mousePressed) findTarget();
      else this.state = TongueState.PULL;
      break;
    case PULL:
      tongueLength -= dt * 2.2;
      if (tongueLength <= 0) {
        this.state = TongueState.IDLE;
      }
      break;
    case IDLE:
      tongueLength = 1;
      setVisibility(false);
      break;
    }
  }

  void findTarget() {
    if (target == null) {
      targetLocation.x = mouseX;
      targetLocation.y = mouseY;
    } else {
      targetLocation.x = target.location.x;
      targetLocation.y = target.location.y;
    }
  }
}

public enum TongueState {
  ATTACK,
    PULL,
    IDLE
}
