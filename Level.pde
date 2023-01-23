class Level {

  // variables
  int name;
  int bugAmount;
  HashMap<String, Integer> bugSpawns = new HashMap(); // keeps track of which enemies to spawn and at what percent
  ArrayList<Bug> bugList = new ArrayList();
  ArrayList<Popup> popUps = new ArrayList();
  Frog frog = new Frog();
  
  Level(int name) {
    
    this.name = name;
    
    switch (name) {
      case 1: // LEVEL 1
      
      bugAmount = 20;
      bugSpawns.put("fly", 75); // 75% chance to spawn fly
      bugSpawns.put("pondskipper", 25); // 75% + 25% chance to spawn pondskipper
      break;
      
      case 2: // LEVEL 2... And so on
      
      bugAmount = 20;
      bugSpawns.put("fly", 50); // 50% chance to spawn fly
      bugSpawns.put("wasp", 0); // 50% + 0% chance to spawn wasp
      bugSpawns.put("pondskipper", 25); // therefore this is 75% chance
      bugSpawns.put("dragonfly", 25); // 100%
      break;
      
      case 3:
      
      bugAmount = 30;
      bugSpawns.put("fly", 25);
      bugSpawns.put("wasp", 25);
      bugSpawns.put("pondskipper", 25);
      bugSpawns.put("dragonfly", 25);
      break;
      
      case 4:
      
      bugAmount = 30;
      break;
      
      case 5:
      
      bugAmount = 35;
      break;
      
      case 6:
      
      bugAmount = 40;
      break;
      
      case 7:
      
      bugAmount = 45;
      break;
      
    }
    
  }
  
  void update(){
    
    frog.update();
    
    for (Bug b : bugList) {
    
      b.update();
    }
  }
  
  void draw(){
    
    frog.draw();
    
    for (Bug b : bugList) {
      b.draw();
    }
  }
  
  void cullBugs(){
    for (int i = bugList.size() - 1; i >= 0; i--){
      if (bugList.get(i).isDead) {
        
        if (bugList.get(i).name.equals("wasp")) for (Bug b : bugList) if (b.name.equals("wasp")) b.isAngry = true; // if dead bug is a wasp, find all wasps and make them angry
        
        bugList.remove(i);
      }
    } 
  }
}
