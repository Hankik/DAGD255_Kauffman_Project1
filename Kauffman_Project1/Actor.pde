class Actor {
  
  // variables
  String name = "";
  HashMap<String, Component> components = new HashMap();
  PVector location = new PVector(width/2,height/2);
  
  Actor(){
    
    name = "actor";
  }
  
  void update(){
    updateComponents();
  }
  
  void draw(){
    
    pushMatrix();
    drawComponents(location.x, location.y);  // by drawing components within matrix, all component transforms should be relative
    popMatrix();
  }
  
  // A method to call each component's update method
  void updateComponents(){
    
    components.forEach((name, c) -> c.update());
  }
  
  void drawComponents(float x, float y){
    
    components.forEach((name, c) -> c.draw(x, y));
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
