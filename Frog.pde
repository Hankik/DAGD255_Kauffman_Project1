class Frog extends Actor {

  // variables
  PImage frogShut = loadImage("frog3.png"); // image size is 1024 x 1024 pixels
  PImage frogOpen = loadImage("frog4.png");
  ArrayList<Particle> particles = new ArrayList();
  Circle body = new Circle(this, 32);
  FrogTongue tongue = new FrogTongue(this);
  Effects effects = new Effects(this);
  Timer mouthTimer = new Timer(.1);
  String prevBug = "";
  int successiveBugs = 0;


  // constructor
  Frog() {

    frogShut.resize(64, 64);
    frogOpen.resize(64, 64);
    name = "frog";
    addComponent(body)
      .addComponent(tongue)
      .addComponent(effects);

    //body.setVisibility(true); // THIS DOESNT WORK FOR SOME REASON
  }

  void update() {
    super.update(); // perform actor super class updates

    mouthTimer.update();
    for (Particle p : particles) {
      p.update();
    }

    for (int i = particles.size() - 1; i >= 0; i--) {

      if (particles.get(i).lifetime.isDone) particles.remove(i);
    }
  }

  void draw() {

    pushMatrix();
    imageMode(CENTER);
    if (tongue.state == TongueState.IDLE && mouthTimer.isDone) image(frogShut, location.x, location.y);
    else image(frogOpen, location.x, location.y);
    popMatrix();
    super.draw(); // perform actor super class draws
    
    for (Particle p : particles) {
      p.draw();
    }
    imageMode(CORNER);
  }

  void mousePressed() {
    if (body.checkCollision(location.x, location.y, mouseX, mouseY, getTipSize() )) { // check if mouse is over frog
      //tongue.tongueLength = 1;
      tongue.state = TongueState.ATTACK;
    }
  }

  void setTipSize(float size) {

    tongue.tipSize = size;
  }

  float getTipSize() {

    return tongue.tipSize;
  }

  void eatBug(Bug b) {
    
    crunch.play();

    effects.give(b.name, b.effectDuration);
    println("Frog ate a " + b.name +"!");

    // spawn blood particles
    int rand = floor(random(5, 8));
    for (int i = 0; i < rand; i++) {

      Particle p = new Particle(location.x, location.y, random(35, 55), new PVector( random(-1, 1), random(-1, 1) ).normalize(), .7);
      particles.add(p);
    }
    
    if (prevBug.equals(b.name)) {
    
      successiveBugs++;
    } else {
      successiveBugs = 1;
    }
    prevBug = b.name;
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
      if (tongueLength <= 0 ) { // until gone completely
        this.state = TongueState.IDLE; // and enters idle state
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
