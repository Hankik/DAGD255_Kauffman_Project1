class Button {

  float x, y, w = 150, h = 60;
  String name;
  String text = "";
  float cost = 0;

  boolean isHovered = false;
  boolean isPressed = false;
  boolean canBePressed = true;

  Button(float xPos, float yPos, String name, float cost) {
    x = xPos;
    y = yPos;
    this.name = name;
    this.cost = cost;
    text = name;
  }

  void update(float parentX, float parentY) {

    if (cost > 0) text = name + ": " + cost + "xp";

    if (canBePressed) {
      if (mouseX > parentX + x && mouseX < parentX + x + w && mouseY > parentY + y && mouseY < parentY + y + h) {
        isHovered = true;
      } else {
        isHovered = false;
      }
    }

    if (isHovered) {
      if (leftPressed) {
        if (!select.isPlaying()) {
          select.play();
          isPressed = true;
        }
      } else {
        isPressed = false;
      }
    } else {

      isPressed = false;
    }
  }

  void draw(float parentX, float parentY) {
    pushMatrix();
    translate(parentX, parentY);
    if (isHovered) fill(BLUE);
    else fill(LIGHTBLUE);
    if (isPressed) fill(BLACK);
    if (!canBePressed) fill(BLACK);
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h, 14);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(text, x + 75, y + 30);
    popMatrix();
  }

  void setText(String text) {

    this.text = text;
  }
}
