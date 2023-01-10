class Frog extends Actor {
  
  // variables
  PImage sprite = loadImage("frog.png");
  
  Frog(){
  
    name = "frog";
  }
  
  void update(){
    super.update();
    
    
    super.draw();
    draw();
  }
  
  void draw(){
  
    pushMatrix();
    image(sprite, location.x - 32, location.y - 32);
    popMatrix();
  }
}
