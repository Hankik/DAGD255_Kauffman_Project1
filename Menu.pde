class Menu {

  // variables
  float x = 0;
  float y = 0;
  Button upgradeTongue = new Button(width * .05, height * .05, "Upgrade Tongue", 30);
  Button upgradeHealth = new Button(width * .05, height * .05 + 90, "Upgrade Health", 30);
  Button moreFlies = new Button(width * .05, height * .05 + 180, "+Flies", 30);
  Button morePondskippers = new Button(width * .05, height * .05 + 270, "+Pondskippers", 30);
  Button moreDragonflies = new Button(width * .05, height * .05 + 360, "+Dragonflies", 30);
  Button moreWasps = new Button(width * .05, height * .05 + 450, "+Wasps", 30);
  Button moreBugs = new Button(width * .05, height * .05 + 540, "+Bugs", 30);


  Menu() {
  }

  void update() {

    Frog frog = levels[currentLevel].frog;

    upgradeTongue.update(x, y);
    upgradeHealth.update(x, y);
    moreFlies.update(x, y);
    morePondskippers.update(x, y);
    moreDragonflies.update(x, y);
    moreWasps.update(x, y);
    moreBugs.update(x, y);

    if (upgradeTongue.isPressed && levels[currentLevel].xp >= upgradeTongue.cost) {
      levels[currentLevel].xp -= upgradeTongue.cost;
      frog.setTipSize(frog.getTipSize() + 4);
      upgradeTongue.cost *= 1.1;
    }
    if (upgradeHealth.isPressed && levels[currentLevel].xp >= upgradeHealth.cost) {
      levels[currentLevel].xp -= upgradeHealth.cost;
      upgradeHealth.cost *= 1.1;
    }
    if (moreFlies.isPressed && levels[currentLevel].xp >= moreFlies.cost) {
      levels[currentLevel].xp -= moreFlies.cost;
      moreFlies.cost *= 1.1;
    }
    if (morePondskippers.isPressed && levels[currentLevel].xp >= morePondskippers.cost) {
      levels[currentLevel].xp -= morePondskippers.cost;
      morePondskippers.cost *= 1.1;
    }
    if (moreDragonflies.isPressed && levels[currentLevel].xp >= moreDragonflies.cost) {
      levels[currentLevel].xp -= moreDragonflies.cost;
      moreDragonflies.cost *= 1.1;
    }
    if (moreWasps.isPressed && levels[currentLevel].xp >= moreWasps.cost) {
      levels[currentLevel].xp -= moreWasps.cost;
      moreWasps.cost *= 1.1;
    }
    if (moreBugs.isPressed && levels[currentLevel].xp >= moreBugs.cost) {
      levels[currentLevel].xp -= moreBugs.cost;
      levels[currentLevel].waveSize++;
      moreBugs.cost *= 1.1;
    }
  }

  void draw() {

    upgradeTongue.draw(x, y);
    upgradeHealth.draw(x, y);
    moreFlies.draw(x, y);
    morePondskippers.draw(x, y);
    moreDragonflies.draw(x, y);
    moreWasps.draw(x, y);
    moreBugs.draw(x, y);
  }
}
