class Actor {
  
  // variables
  String name = "";
  HashMap<String, Component> components = new HashMap();
  PVector location = new PVector(width/2,height/2);
  float angleToTarget = 0;
  float speed;
  float r;
  boolean isDead = false;
  
  Actor(){
    
    name = "actor";
  }
  
  void update(){
    updateComponents(location.x, location.y); // update all components
  }
  
  void draw(){
    
    drawComponents(location.x, location.y);  // draw components
  }
  
  // A method to call each component's update method
  void updateComponents(float x, float y){
    
    //components.forEach((name, c) -> c.update()); // Procesing 3 can't do lambda expressions
    for (Map.Entry<String, Component> entry : components.entrySet()) {
      entry.getValue().update(x, y);
      
      if (entry.getValue().components.size() > 0){ // if component has sub-components, update them too
        for (Map.Entry<String, Component> subEntry : entry.getValue().components.entrySet()) {
          subEntry.getValue().update(x, y);
        }
      }
    }
  }
  
  void drawComponents(float x, float y){
    
    //components.forEach((name, c) -> c.draw(x, y)); // Processing 3 can't do lambda expressions
    for (Map.Entry<String, Component> entry : components.entrySet()) {
    
      entry.getValue().draw(x, y);
      
      if (entry.getValue().components.size() > 0){ // if component has sub-components draw them too
        for (Map.Entry<String, Component> subEntry : entry.getValue().components.entrySet()) {
          subEntry.getValue().draw(x, y);
        }
      }
    }
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
