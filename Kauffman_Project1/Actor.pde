class Actor {
  
  // variables
  String name = "";
  HashMap<String, Component> components = new HashMap();
  
  Actor(){
    
    name = "actor";
  }
  
  void update(){
    updateComponents();
  }
  
  void draw(){
    
    pushMatrix();
    drawComponents();  // by drawing components within matrix, all component transforms should be relative
    popMatrix();
  }
  
  void updateComponents(){
    
    components.forEach((name, c) -> c.update());
  }
  
  void drawComponents(){
    
    components.forEach((name, c) -> c.draw());
  }
  
  // A method to add components to actor
  Actor addComponent(Component c){
    
    components.put(c.name, c);
    
    return this; // Actor return type allows for chaining addComponent() calls
  }
  
  // If using this method, always check for possibility of NULL
  Component getComponent(String name){
  
    if (components.containsKey(name)) return components.get(name);
    
    println(this.name + " could not find component '" + name + "'.");
    return null;
  }
}
