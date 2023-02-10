class Bug extends Actor {

  // variables
  Circle body = new Circle(this, 16);
  Effects effects = new Effects(this);
  Timer angerTimer; // timer for wasps' anger mechanic
  Timer changeDirection = new Timer(5); // used for changing dir every 5 sec
  PImage sprite = loadImage("fly.png");
  PImage angerImg = loadImage("angry.png");
  PVector direction;
  float distFromFrog; // used for determining isDead
  float defaultValue = 3;
  float value = defaultValue; // point value of bug
  float effectDuration = 10;
  boolean collisionEnabled = false; // allows the bug to be in the wall on spawn
  boolean isFacingRight = true;
  boolean isAngry = false;

  Bug(ArrayList<String> spawns) {

    addComponent(body)
      .addComponent(effects);

    speed = 30;

    //body.setVisibility(true);


    int rand = floor( random(0, spawns.size()) );
    name = spawns.get(rand);

    angerImg.resize(24, 24);

    switch (name) {

    case "wasp":
      sprite = loadImage("wasp.png");
      sprite.resize(32, 32);
      angerTimer = new Timer(random(6, 8));
      defaultValue = 6;
      value = defaultValue;
      break;
      
    case "fly":
      sprite = loadImage("fly.png");
      defaultValue = 1;
      value = defaultValue;
      break;
      
    case "dragonfly":
      sprite = loadImage("dragonfly.png");
      speed *= 3;
      defaultValue = 9;
      value = defaultValue;
      sprite.resize(32, 32);
      break;
      
    case "pondskipper":
      sprite = loadImage("pondskipper.png");
      sprite.resize(32, 32);
      defaultValue = 2;
      value = defaultValue;
      break;
    }

    getSpawnLocation();
  }

  void update() {
    super.update();

    if (name.equals("wasp") && isAngry) {
      angerTimer.update();

      if (angerTimer.isDone) {
        speed = 30;
        value = defaultValue;
        isAngry = false;
      }
    }

    changeDirection.update(); // run the clock on changeDirection
    if (changeDirection.isDone) { // if done, give new direction
      collisionEnabled = true; // start checkign for collision
      setDirection(direction.x + random(-.2, .2), direction.y + random(-.2, .2));
      changeDirection.reset();
    }
    flipSprite();



    move(direction.x, direction.y);

    if (collisionEnabled) checkCollision();
    if (distFromFrog < 32 && direction.x == 0 && direction.y == 0) {

      death();
      isDead = true;
    }
  }

  void draw() {

    super.draw();
    pushMatrix();
    translate(location.x, location.y);
    if (!isFacingRight) {
      translate(sprite.width/2, 0);
      scale(-1, 1);
      image(sprite, 0, 0 - r); // if facing left (mirrored) offset x value by not calculating in radius
      if (name.equals("wasp") && isAngry) image(angerImg, 0, 0 - r*2);
    } else {
      image(sprite, 0 - r, 0 - r);
      if (name.equals("wasp") && isAngry) image(angerImg, 0 - r, 0 - r*2);
    }

    popMatrix();
  }

  void getSpawnLocation() {

    int spawnSwitcher = floor(random(4));

    switch (spawnSwitcher) {
      case(0): // LEFT
      location.x = 0 - r/2;
      location.y = random(height);
      direction = new PVector(1, random(-1, 1));
      break;
      case(1): // RIGHT
      location.x = width + r/2;
      location.y = random(height);
      direction = new PVector(-1, random(-1, 1));
      flipSprite();
      break;
      case(2): // TOP
      location.x = random(width);
      location.y = 0 - r/2;
      direction = new PVector(random(-1, 1), 1);
      flipSprite();
      break;
      case(3): // BOTTOM
      location.x = random(width);
      location.y = height + r/2;
      direction = new PVector(random(-1, 1), -1);
      flipSprite();
      break;
    }
  }
  
  float getValue(int n){
  
    if (n > 1) return pow(1.2, n) * value;
    return value;
  }

  void getAngry() {

    isAngry = true;
    effects.give("largeSpeedBoost", random(6, 8));
    angerTimer.reset();
  }

  void setDirection(float x, float y) {

    direction.x = x;
    direction.y = y;
  }

  void move(float x, float y) {

    PVector moveAmt = new PVector(x, y);
    moveAmt.normalize();
    location.x += moveAmt.x * dt * speed;
    location.y += moveAmt.y * dt * speed;
    moveAmt.mult(0);
  }

  // A method to calculate distance from frog
  void getDistances(Actor f) {
    if (f.name.equals("frog")) {
      distFromFrog = dist(f.location.x, f.location.y, location.x, location.y);
      return;
    }
    println("Frog not found.");
  }

  void checkCollision() {

    if (location.x + r/2 > width) { // RIGHT
      location.x = width - r/2;
      setDirection(-1, random(-1, 1));
    }
    if (location.x - r/2 < 0) { // LEFT
      location.x = r/2;
      setDirection(1, random(-1, 1));
    }
    if (location.y + r > height) { // BOTTOM
      location.y = height - r;
      setDirection(random(-1, 1), -1);
    }
    if (location.y - r/2 < 0) { // TOP
      location.y = r/2;
      setDirection(random(-1, 1), 1);
    }
  }

  void death() {
    if (name.equals("wasp") && isAngry) value = 3;
  }

  void flipSprite() {

    if (isFacingRight && direction.x < 0) {

      isFacingRight = false;
    }
    if (!isFacingRight && direction.x > 0) {

      isFacingRight = true;
    }
  }

  void mouseReleased() {
    changeDirection.isPaused = true;
    setDirection(0, 0);
  }
}
