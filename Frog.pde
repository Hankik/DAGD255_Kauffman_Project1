class Frog extends Actor {

  // variables
  PImage sprite = loadImage("frog2.png"); // image size is 64 x 64 pixels
  Circle body = new Circle(this, 32);
  FrogTongue tongue = new FrogTongue(this);
  Effects effects = new Effects(this);


  // constructor
  Frog() {

    name = "frog";
    addComponent(body)
      .addComponent(tongue)
      .addComponent(effects);

    //body.setVisibility(true); // THIS DOESNT WORK FOR SOME REASON
  }

  void update() {
    super.update(); // perform actor super class updates
  }

  void draw() {

    pushMatrix();
    image(sprite, location.x - r, location.y - r);
    popMatrix();
    super.draw(); // perform actor super class draws
  }

  void mousePressed() {
    if (body.checkCollision(location.x, location.y, mouseX, mouseY, getTipSize() )) { // check if mouse is over frog
      //tongue.tongueLength = 1;
      tongue.state = TongueState.ATTACK;
    }
  }
  
  void setTipSize(float size){
  
    tongue.tipSize = size;
  }
  
  float getTipSize() {
  
    return tongue.tipSize;
  }

  void eatBug(Bug b) {

    effects.give(b.name, b.effectDuration);
    println("Frog ate a " + b.name +"!");
  }

  void mouseReleased() {
  }
}

class FrogTongue extends Component {  // NEEDS MORE COMMENTING

  // variables
  Actor parent;
  Actor target = null;
  TongueState state = TongueState.IDLE;
  Tip tip = new Tip(0, 0);
  PVector targetLocation = new PVector(0, 0);
  float tipSize = 8;
  float tongueWidth = 4;
  float tongueLength = 1;

  FrogTongue(Actor parent) {

    name = "tongue";
    this.parent = parent;
  }

  void update(float x, float y) {
    handleState(state);
    
    tongueWidth = tipSize*.5;
  }

  void draw(float x, float y) {


    if (state == TongueState.ATTACK) {

      pushMatrix();
      noStroke();
      fill(TONGUE);
      circle(parent.location.x, parent.location.y, tipSize);
      circle(tip.location.x, tip.location.y, tipSize);
      translate(x, y);
      rotate(findAngleToTarget(targetLocation, x, y));
      rect(2, -2, dist(x, y, targetLocation.x, targetLocation.y), tongueWidth);

      stroke(4);
      popMatrix();
    } else if (state == TongueState.PULL) {

      pushMatrix();
      noStroke();
      fill(TONGUE);
      circle(parent.location.x, parent.location.y, tipSize);
      circle(tip.location.x, tip.location.y, tipSize);
      translate(x, y);
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
      setVisibility(true); // shows tongue
      if (mousePressed) findTarget(); // mouse input to enter attack state
      else this.state = TongueState.PULL; // ending mouse input enters pull state
      break;
    case PULL:
      if (target != null) tongueLength -= dt * .3; // tongue is shortened
      else tongueLength -= dt * 3;
      findTip();
      println(tongueLength);
      if (tongueLength <= 0 ) { // until gone completely
        this.state = TongueState.IDLE; // and enters idle state
        println("target removed!");
      }
      break;
    case IDLE:
      target = null; // removes target
      tongueLength = 1; // resets tongue size
      setVisibility(false); // hides tongue
      break;
    }
  }

  void findTarget() {
    targetLocation.x = mouseX;
    targetLocation.y = mouseY;
    tip.location.x = mouseX;
    tip.location.y = mouseY;
  }

  void findTip() {
    if (target != null) {

      target.location.x = lerp(target.location.x, parent.location.x, 1 - tongueLength);
      target.location.y = lerp(target.location.y, parent.location.y, 1 - tongueLength);
      tip.location = target.location;
    } else {
      target = tip;
    }
    
    // fixes odd artifact where tongueLength resets before switching state
    if ( dist(tip.location.x, tip.location.y, parent.location.x, parent.location.y) < parent.r) tongueLength = 0; 
  }
}

class Tip extends Actor { // used to draw and locate frog tongue tip
  Tip(float x, float y) {
    location.x = x;
    location.y = y;
  }
}

public enum TongueState {
  ATTACK,
    PULL,
    IDLE
}
