class Level {

  // variables
  int name;
  HashMap<String, Integer> bugSpawns = new HashMap(); // keeps track of which enemies to spawn and how many
  ArrayList<Bug> bugList = new ArrayList();
  ArrayList<Popup> popUps = new ArrayList();
  Frog frog = new Frog();
  
  Level(int name) {
    
    this.name = name;
    
    switch (name) {
      case 1:
      
      bugSpawns.put("fly", 75);
      bugSpawns.put("dragonfly", 100);
      
      
      
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
