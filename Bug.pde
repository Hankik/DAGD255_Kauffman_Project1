class Bug extends Actor {

  // variables
  PImage sprite = loadImage("fly.png");
  PImage angerImg = loadImage("angry.png");
  Timer angerTimer; // timer for wasps' anger mechanic
  Circle body = new Circle(16);
  PVector direction;
  float speed = 30;
  float distFromFrog; // used for determining isDead
  Timer changeDirection = new Timer(5); // used for changing dir every 5 sec
  boolean collisionEnabled = false; // allows the bug to be in the wall on spawn
  boolean isFacingRight = true;
  boolean isAngry = false;
  float defaultValue = 3;
  float value = defaultValue; // point value of bug

  Bug(HashMap<String, Integer> spawns) {
    
    addComponent(body);
    
    int accumulator = 0; // adds previous spawn chance to the next bug type
    
    for (Map.Entry<String, Integer> spawn : spawns.entrySet()) {


      int rand = floor(random(100));
      if (rand <= spawn.getValue() + accumulator) {
        name = spawn.getKey();
      } else {
        accumulator += spawn.getValue();
      }
    }
    
    angerImg.resize(24, 24);

    switch (name) {

      case "wasp":
      sprite = loadImage("wasp.png");
      sprite.resize(32, 32);
      angerTimer = new Timer(7);
      defaultValue = 6;
      value = defaultValue;
      break;
      case "fly":
      sprite = loadImage("fly.png");
      break;
      case "dragonfly":
      sprite = loadImage("dragonfly.png");
      speed *= 3;
      sprite.resize(32, 32);
      break;
      case "pondskipper":
      sprite = loadImage("pondskipper.png");
      sprite.resize(32, 32);
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
      image(sprite, 0 - body.r/2, 0 - body.r/2);
    } else image(sprite, 0 - body.r/2, 0 - body.r/2);
    if (name.equals("wasp") && isAngry) image(angerImg, 0 - body.r, 0 - body.r);

    popMatrix();
  }

  void getSpawnLocation() {

    int spawnSwitcher = floor(random(4));

    switch (spawnSwitcher) {
      case(0): // LEFT
      location.x = 0 - body.r/2;
      location.y = random(height);
      direction = new PVector(1, random(-1, 1));
      break;
      case(1): // RIGHT
      location.x = width + body.r/2;
      location.y = random(height);
      direction = new PVector(-1, random(-1, 1));
      flipSprite();
      break;
      case(2): // TOP
      location.x = random(width);
      location.y = 0 - body.r/2;
      direction = new PVector(random(-1, 1), 1);
      flipSprite();
      break;
      case(3): // BOTTOM
      location.x = random(width);
      location.y = height + body.r/2;
      direction = new PVector(random(-1, 1), -1);
      flipSprite();
      break;
    }
  }
  
  void getAngry(){
  
    isAngry = true;
    speed = 180;
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
  float getDistanceFromFrog(Actor f) {
    if (f.name.equals("frog")) {
      distFromFrog = dist(f.location.x, f.location.y, location.x, location.y);
      return distFromFrog;
    }
    println("Frog not found.");
    return 0;
  }

  void checkCollision() {

    if (location.x + body.r/2 > width) { // RIGHT
      location.x = width - body.r/2;
      setDirection(-1, random(-1, 1));
    }
    if (location.x - body.r/2 < 0) { // LEFT
      location.x = body.r/2;
      setDirection(1, random(-1, 1));
    }
    if (location.y + body.r > height) { // BOTTOM
      location.y = height - body.r;
      setDirection(random(-1, 1), -1);
    }
    if (location.y - body.r/2 < 0) { // TOP
      location.y = body.r/2;
      setDirection(random(-1, 1), 1);
    }
    
  }

  void death() {
    if (name.equals("wasp") && isAngry) value = -3;
    
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
