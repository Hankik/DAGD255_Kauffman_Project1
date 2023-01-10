class Actor {
  
  // variables
  String name = "";
  HashMap<String, Component> components = new HashMap();
  PVector location = new PVector(width/2,height/2);
  float angleToTarget = 0;
  
  Actor(){
    
    name = "actor";
  }
  
  void update(){
    updateComponents(); // update all components
  }
  
  void draw(){
    
    drawComponents(location.x, location.y);  // draw components
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
  
  // If using method to receive component, always account for possibility of NULL
  Component getComponent(String name){
  
    if (components.containsKey(name)) return components.get(name);
    
    println(this.name + " could not find component '" + name + "'.");
    return null;
  }
  
  void findAngleToTarget(float x, float y) {
    float dx = x - location.x;
    float dy = y - location.y;
    angleToTarget = atan2(dy, dx);
  }
  
}
