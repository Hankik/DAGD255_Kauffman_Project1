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
      
    body.setVisibility(true); // THIS DOESNT WORK FOR SOME REASON 
  }

  void update() {
    super.update(); // perform actor super class updates
    
  }

  void draw() {

    pushMatrix();
    image(sprite, location.x - body.r, location.y - body.r);
    popMatrix();
    super.draw(); // perform actor super class draws
  }

  void mousePressed() {
    if (body.checkCollision(location.x - body.r/2, location.y - body.r/2, mouseX, mouseY)) {
      tongue.tongueLength = 1;
      tongue.state = TongueState.ATTACK;
    }
  }

  void mouseReleased() {
  }
}

class FrogTongue extends Component {  // NEEDS MORE COMMENTING

  // variables
  PVector targetLocation = new PVector(0, 0);
  PVector tip = new PVector(0,0);
  Actor target = null;
  TongueState state = TongueState.IDLE;
  float tongueWidth = 4;
  float tongueLength = 1;

  FrogTongue() {
  }

  void update(float x, float y) {
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
      circle(tip.x, tip.y, 6);
      rotate(findAngleToTarget(targetLocation, x, y));
      if (target == null) rect(2, -2, dist(x, y, targetLocation.x, targetLocation.y) * tongueLength, tongueWidth);
      else rect(2, -2, dist(x, y, target.location.x, target.location.y) * tongueLength, tongueWidth);
      
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
      tongueLength -= dt * 1.5;
      findTip();
      if (tongueLength <= 0 ) {
        this.state = TongueState.IDLE;
      }
      break;
    case IDLE:
      target = null;
      tongueLength = 1;
      setVisibility(false);
      break;
    }
  }

  void findTarget() {
      targetLocation.x = mouseX;
      targetLocation.y = mouseY;
  }
  
  void findTip(){
    if (target != null) {
      
      target.location.x = lerp(target.location.x, frog.location.x , 1 - tongueLength);
      target.location.y = lerp(target.location.y, frog.location.y , 1 - tongueLength);
    }
  }
}

public enum TongueState {
  ATTACK,
    PULL,
    IDLE
}
