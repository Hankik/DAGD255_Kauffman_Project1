class Fly extends Actor {

  // variables
  PImage sprite = loadImage("fly.png");
  Circle body = new Circle(32);
  PVector direction;
  float speed = 30;
  
  // constructor
  Fly(){
  
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
  
  void update(){
    super.update();
    move(direction.x, direction.y);
    
    super.draw();
    draw();
  }
  
  void draw(){
  
    pushMatrix();
    translate(location.x, location.y);
    image(sprite, 0 - body.r, 0 - body.r);
    popMatrix();
  }
  
  void move(float x, float y){
  
    PVector moveAmt = new PVector(x,y);
    moveAmt.normalize();
    location.x += moveAmt.x * dt * speed;
    location.y += moveAmt.y * dt * speed;
  }
}
