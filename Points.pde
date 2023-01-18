class Points extends Actor {

  // variables
  String text = "";
  Timer duration = new Timer(1);
  boolean isDead = false;



  Points() {
  }

  void update() {
  }

  void draw(float x, float y) {

    pushMatrix();
    translate(x, y);
    fill(BLACK);
    textSize(35);

    popMatrix();
  }
}
