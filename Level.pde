class Level {

  // variables
  int name;
  int bugAmount;
  int waveSize = 1;
  float xp = 0;
  float xpTotal = 0;
  String gamemode = "";
  Menu menu = new Menu();
  Frog frog = new Frog();
  Timer spawnTimer = new Timer(8);
  Timer gameOverTimer;
  ArrayList<String> spawns = new ArrayList();
  ArrayList<Bug> bugList = new ArrayList();
  ArrayList<Popup> popups = new ArrayList();
  boolean autoEat = false;
  boolean hasFirstClickHappened = false;

  Level(int name) {

    this.name = name;

    switch (name) {
    case 0: // Timed mode

      gamemode = "timed";
      gameOverTimer = new Timer(60);

      addSpawns("fly", 10);
      addSpawns("wasp", 3);
      addSpawns("dragonfly", 2);
      addSpawns("pondskipper", 5);
      bugAmount = 20;
      break;

    case 1: // Endless mode

      gamemode = "endless";

      addSpawns("fly", 10);
      addSpawns("wasp", 3);
      addSpawns("dragonfly", 2);
      addSpawns("pondskipper", 5);
      bugAmount = 20;
      break;
    }

    for (int i = 0; i < bugAmount; i++) {

      Bug b = new Bug(spawns);
      bugList.add(b);
    }
  }

  void update() {

    if (gamemode.equals("timed") && hasFirstClickHappened || gamemode.equals("endless")) {

      if (gameOverTimer != null) gameOverTimer.update(); // only spawns if in endless mode
      spawnTimer.update();

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
      
      if (gameOverTimer != null && gameOverTimer.isDone) {
        menu.playAgainMode = true;
        isPaused = true;
      }

      if (spawnTimer.isDone) {

        spawn(waveSize);
        spawnTimer.reset();
      }
    } else {
    
      textSize(30);
      text("Click anywhere to start.", width*.4, height*.4);
    }
  }

  void draw() {

    frog.draw();

    for (Bug b : bugList) {
      b.draw();
    }

    for (Popup p : popups) {
      p.draw();
    }

    pushMatrix();
    fill(0);
    textSize(35);
    text((int) xp + "XP", width * .9, 60);
    textSize(40);
    if (gameOverTimer != null) text((int) gameOverTimer.timeLeft + "s", width*.5, 60);
    popMatrix();
  }

  void updateMenu() {

    menu.update();
    menu.draw();
  }

  void mousePressed() {
    frog.mousePressed();
    hasFirstClickHappened = true;
  }

  void mouseReleased() {
    frog.mouseReleased();
    if (frog.tongue.state == TongueState.ATTACK) { // only do if tongue was pulled
      for (Bug b : bugList) {
        if (b.body.checkCollision(b.location.x, b.location.y, mouseX, mouseY, frog.getTipSize() )) {
          frog.tongue.target = b; // frog tongue can only target one at a time.
          b.mouseReleased();
          break; // this break prevents pulling multiple at the same time
        }
      }
    }
  }

  void spawn(float bugAmount) {

    for (int i = 0; i < bugAmount; i++) {

      Bug b = new Bug(spawns);
      bugList.add(b);
    }
  }

  void addSpawns(String bug, int amount) {

    for (int i = 0; i < amount; i++) {

      spawns.add(bug);
    }
  }

  void cullBugs() {
    for (int i = bugList.size() - 1; i >= 0; i--) {
      if (bugList.get(i).isDead) {

        frog.eatBug( bugList.get(i) );
        if (bugList.get(i).name.equals("wasp")) for (Bug b : bugList) if (b.name.equals("wasp")) b.getAngry(); // if dead bug is a wasp, find all wasps and make them angry
        popups.add(new Popup(bugList.get(i).location.x, bugList.get(i).location.y, "+" + (int) bugList.get(i).getValue((int)frog.successiveBugs) + "XP", 20));
        xp += bugList.get(i).getValue((int)frog.successiveBugs);
        xpTotal += bugList.get(i).getValue((int)frog.successiveBugs);
        popups.add(new Popup(width*.05, height*.95, frog.successiveBugs + "x", 20));

        frog.tongue.tongueLength = 0; // fixes tongueLength artifact
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
