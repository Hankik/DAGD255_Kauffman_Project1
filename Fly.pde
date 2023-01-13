class Fly extends Actor {

  // variables
  PImage sprite = loadImage("fly.png");
  Circle body = new Circle(32);
  PVector direction;
  float speed = 30;
  Timer changeDirection = new Timer(5);
  boolean collisionEnabled = false;

  // constructor
  Fly() {

    name = "fly";
    addComponent(body);


    int rand = floor(random(4));

    switch (rand) {
      case(0): // LEFT
      location.x = 0 - body.r/2;
      location.y = random(height);
      direction = new PVector(1, random(-1, 1));
      break;
      case(1): // RIGHT
      location.x = width + body.r/2;
      location.y = random(height);
      direction = new PVector(-1, random(-1, 1));
      break;
      case(2): // TOP
      location.x = random(width);
      location.y = 0 - body.r/2;
      direction = new PVector(random(-1, 1), 1);
      break;
      case(3): // BOTTOM
      location.x = random(width);
      location.y = height + body.r/2;
      direction = new PVector(random(-1, 1), -1);
      break;
    }
  }

  void update() {
    super.update();

    changeDirection.update(); // run the clock on changeDirection
    if (changeDirection.isDone) { // if done, give new direction
      collisionEnabled = true; // start checkign for collision
      setDirection(direction.x + random(-.2, .2), direction.y + random(-.2, .2));
      changeDirection.reset();
    }



    move(direction.x, direction.y);

    if (collisionEnabled) checkCollision();

    super.draw();
    draw();
  }

  void draw() {

    pushMatrix();
    translate(location.x, location.y);
    image(sprite, 0 - body.r/2, 0 - body.r/2);
    popMatrix();
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

  void checkCollision() {

    if (location.x + body.r/2 > width) { // RIGHT
      location.x = width - body.r/2;
      setDirection(-1, random(-1, 1));
    }
    if (location.x - body.r/2 < 0) { // LEFT
      location.x = body.r/2;
      setDirection(1, random(-1, 1));
    }
    if (location.y + body.r/2 > height) { // BOTTOM
      location.y = height - body.r/2;
      setDirection(random(-1, 1), -1);
    }
    if (location.y - body.r/2 < 0) { // TOP
      location.y = body.r/2;
      setDirection(random(-1, 1), 1);
    }
  }

  void mouseReleased() {
    changeDirection.isPaused = true;
    setDirection(0, 0);
  }
}
