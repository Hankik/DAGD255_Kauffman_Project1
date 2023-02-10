abstract class Component {

  // variables
  HashMap<String, Component> components = new HashMap();
  String name = "";
  color fill = WHITE;
  float angleToTarget = 0;
  boolean isVisible = false;
  
  abstract void update(float x, float y);
  
  abstract void draw(float x, float y);
  
  // a method to determine if component needs drawn
  void setVisibility(boolean isVisible){
  
    this.isVisible = isVisible;
  }
  
  void setColor(color fill){
  
    this.fill = fill;
  }
  
    // A method to call each sub-component's update method
  void updateComponents(float x, float y){
    
    //components.forEach((name, c) -> c.update()); // Procesing 3 can't do lambda expressions
    for (Map.Entry<String, Component> entry : components.entrySet()) {
      entry.getValue().update(x, y);
    }
  }
  
  // A method to call each sub-component's draw method
  void drawComponents(float x, float y){
    
    //components.forEach((name, c) -> c.draw(x, y)); // Processing 3 can't do lambda expressions
    for (Map.Entry<String, Component> entry : components.entrySet()) {
    
      entry.getValue().draw(x, y);
    }
  }
  
  // A method to add components to actor
  Component addComponent(Component c){
    
    components.put(c.name, c);
    
    return this; // Actor return type allows for chaining addComponent() calls
  }
  
  // If using method to receive component, always account for possibility of NULL
  Component getComponent(String name){
  
    if (components.containsKey(name)) return components.get(name);
    
    println(this.name + " could not find component '" + name + "'.");
    return null;
  }
  
  float findAngleToTarget(PVector target, float x, float y) { 
    float dx = target.x - x;
    float dy = target.y - y;
    angleToTarget = atan2(dy, dx);
    return angleToTarget;
  }
}
