class Level {

  // variables
  int name;
  int bugAmount;
  Frog frog = new Frog();
  HashMap<String, Integer> bugSpawns = new HashMap(); // keeps track of which enemies to spawn and at what percent
  ArrayList<Bug> bugList = new ArrayList();
  ArrayList<Popup> popups = new ArrayList();

  Level(int name) {

    this.name = name;

    switch (name) {
    case 0: // LEVEL 1

      bugAmount = 20;
      bugSpawns.put("fly", 75); // 75% chance to spawn fly
      bugSpawns.put("pondskipper", 25); // 75% + 25% chance to spawn pondskipper
      break;

    case 1: // LEVEL 2... And so on

      bugAmount = 20;
      bugSpawns.put("fly", 50); // 50% chance to spawn fly
      bugSpawns.put("wasp", 0); // 50% + 0% chance to spawn wasp
      bugSpawns.put("pondskipper", 25); // therefore this is 75% chance
      bugSpawns.put("dragonfly", 25); // 100%
      break;

    case 2:

      bugAmount = 30;
      bugSpawns.put("fly", 25);
      bugSpawns.put("wasp", 75);
      //bugSpawns.put("pondskipper", 0);
      //bugSpawns.put("dragonfly", 0);
      break;

    case 3:

      bugAmount = 30;
      break;

    case 4:

      bugAmount = 35;
      break;

    case 5:

      bugAmount = 40;
      break;

    case 6:

      bugAmount = 45;
      break;
    }
    
    for (int i = 0; i < bugAmount; i++){
    
      Bug b = new Bug(bugSpawns);
      bugList.add(b);
    }
  }

  void update() {

    frog.update();

    for (Bug b : bugList) {
      b.getDistances(frog);
      b.update();
    }

    cullBugs();

    for (Popup p : popups) {
      p.update();
    }

    cullPopups();
  }

  void draw() {

    frog.draw();

    for (Bug b : bugList) {
      b.draw();
    }

    for (Popup p : popups) {
      p.draw();
    }
  }

  void mousePressed() {
    frog.mousePressed();
  }

  void mouseReleased() {
    frog.mouseReleased();
    if (frog.tongue.state == TongueState.ATTACK) { // only do if tongue was pulled
      for (Bug fly : bugList) {
        if (fly.body.checkCollision(fly.location.x, fly.location.y, mouseX, mouseY)) {
          frog.tongue.target = fly; // frog tongue can only target one at a time. 
          fly.mouseReleased();
          break; // this break prevents pulling multiple at the same time
        }
      }
    }
  }

  void cullBugs() {
    for (int i = bugList.size() - 1; i >= 0; i--) {
      if (bugList.get(i).isDead) {

        if (bugList.get(i).name.equals("wasp")) for (Bug b : bugList) if (b.name.equals("wasp")) b.getAngry(); // if dead bug is a wasp, find all wasps and make them angry
        popups.add(new Popup(bugList.get(i).location.x, bugList.get(i).location.y, Float.toString(bugList.get(i).value), 20));

        bugList.remove(i);
      }
    }
  }

  void cullPopups() {

    for (int i = popups.size() - 1; i >= 0; i--) {

      if (popups.get(i).isDead) {

        popups.remove(i);
      }
    }
  }
}
