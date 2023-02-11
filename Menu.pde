class Menu {

  // variables
  float x = 0;
  float y = 0;
  boolean playAgainMode = false;

  Button upgradeTongue = new Button(width * .05, height * .05, "Bigger Tongue", data.tongueCost);
  Button fasterSpawns = new Button(width * .05, height * .05 + 90, "Faster Spawns", data.fasterSpawnsCost);
  Button moreFlies = new Button(width * .05, height * .05 + 180, "+Flies", data.moreFliesCost);
  Button morePondskippers = new Button(width * .05, height * .05 + 270, "+Pondskippers", data.morePondskippersCost);
  Button moreDragonflies = new Button(width * .05, height * .05 + 360, "+Dragonflies", data.moreDragonfliesCost);
  Button moreWasps = new Button(width * .05, height * .05 + 450, "+Wasps", data.moreWaspsCost);
  Button moreBugs = new Button(width * .05, height * .05 + 540, "+Bugs", data.moreBugsCost);
  Button autoEat = new Button(width * .05, height * .05 + 630, "Auto Eat", data.autoEatCost);

  Button playAgain = new Button(width *.5 - 200, height * .5, "Play Again", 0);
  Button exit = new Button(width * .5 + 60, height * .5, "Exit", 0);
  Button swapGameMode = new Button(width *.85, height * .9, "Change Gamemode", 0);


  Menu() {
  }

  void update() {
    
    swapGameMode.update(x, y);
    
    if (swapGameMode.isPressed) {
      if (currentLevel == 1) {
        levels[0] = new Level(0);
        currentLevel = 0;
        levels[currentLevel].hasFirstClickHappened = false;
        isPaused = false;
      } else {
        currentLevel = 1;
        isPaused = false;
      }
    }

    if (!playAgainMode) {

      Frog frog = levels[currentLevel].frog;

      upgradeTongue.update(x, y);
      fasterSpawns.update(x, y);
      moreFlies.update(x, y);
      morePondskippers.update(x, y);
      moreDragonflies.update(x, y);
      moreWasps.update(x, y);
      moreBugs.update(x, y);
      autoEat.update(x, y);

      if (upgradeTongue.isPressed && levels[currentLevel].xp >= upgradeTongue.cost) {
        levels[currentLevel].xp -= upgradeTongue.cost;
        frog.setTipSize(frog.getTipSize() + 4);
        upgradeTongue.cost *= data.tongueCostMultiplier;
      }
      if (fasterSpawns.isPressed && levels[currentLevel].xp >= fasterSpawns.cost) {
        levels[currentLevel].xp -= fasterSpawns.cost;
        levels[currentLevel].spawnTimer.duration *= .9;
        fasterSpawns.cost *= data.spawnCostMultiplier;
      }
      if (moreFlies.isPressed && levels[currentLevel].xp >= moreFlies.cost) {
        levels[currentLevel].xp -= moreFlies.cost;
        levels[currentLevel].addSpawns("fly", 5);
        moreFlies.cost *= data.flyCostMultiplier;
      }
      if (morePondskippers.isPressed && levels[currentLevel].xp >= morePondskippers.cost) {
        levels[currentLevel].xp -= morePondskippers.cost;
        levels[currentLevel].addSpawns("pondskipper", 2);
        morePondskippers.cost *= data.pondskipperCostMultiplier;
      }
      if (moreDragonflies.isPressed && levels[currentLevel].xp >= moreDragonflies.cost) {
        levels[currentLevel].xp -= moreDragonflies.cost;
        levels[currentLevel].addSpawns("dragonflies", 1);
        moreDragonflies.cost *= data.dragonflyCostMultiplier;
      }
      if (moreWasps.isPressed && levels[currentLevel].xp >= moreWasps.cost) {
        levels[currentLevel].xp -= moreWasps.cost;
        levels[currentLevel].addSpawns("wasps", 1);
        moreWasps.cost *= data.waspCostMultiplier;
      }
      if (moreBugs.isPressed && levels[currentLevel].xp >= moreBugs.cost) {
        levels[currentLevel].xp -= moreBugs.cost;
        levels[currentLevel].waveSize++;
        moreBugs.cost *= data.bugsCostMultiplier;
      }
      if (autoEat.isPressed && levels[currentLevel].xp >= autoEat.cost) {
        levels[currentLevel].xp -= autoEat.cost;
        levels[currentLevel].autoEat = true;
        autoEat.canBePressed = false;
      }
    } else {

      playAgain.update(x, y);
      exit.update(x, y);
      text("Score: " + levels[currentLevel].xpTotal, width*.5, height*.3);
      
      if (playAgain.isPressed) {
        currentLevel = 0;
        levels[0] = new Level(0);
        
        playAgainMode = false;
        isPaused = false;
        
      }
      
      if (exit.isPressed) {
        exit();
      }
    }
  }

  void draw() {
    
    swapGameMode.draw(x,y);

    if (!playAgainMode) {

      upgradeTongue.draw(x, y);
      fasterSpawns.draw(x, y);
      moreFlies.draw(x, y);
      morePondskippers.draw(x, y);
      moreDragonflies.draw(x, y);
      moreWasps.draw(x, y);
      moreBugs.draw(x, y);
      autoEat.draw(x, y);
    } else {
      
      playAgain.draw(x,y);
      exit.draw(x,y);
    }
  }
}
