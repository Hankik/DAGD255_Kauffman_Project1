class Popup extends Actor {

  // variables
  String text = "";
  float textSize = 35;
  Timer timer = new Timer(.4);
  boolean isDead = false;



  Popup(float x, float y, String text, float size) {
    
    // what to pop up
    this.text = text;
    textSize = size;
    location.x = x;
    location.y = y;
  }

  void update() {
    
    timer.update();
    growAndShrink(0.4, 2);
    if (timer.isDone) isDead = true;
  }

  void draw() {

    pushMatrix();
    translate(location.x - 20, location.y);
    fill(0);
    textSize(textSize);
    text( (int) parseFloat(text), 0, 0);

    popMatrix();
  }
  
  void growAndShrink(float swapPoint, float changeRate ){
    
    if (timer.timeLeft/timer.duration >= swapPoint) textSize += changeRate;
    if (timer.timeLeft/timer.duration < swapPoint) textSize -= changeRate;
  
  }
}
