class Collision extends Component {

  // variables
  Actor parent;
  ArrayList<Actor> collidedActors = new ArrayList();
  
  Collision(Actor parent){
  
    name = "collision";
    this.parent = parent;
  }
  
  void update(float x, float y){
  }
  
  void draw(float x, float y){
  }
  
  void findCollisions(Level l){
    
    for(PVector p : l.frog.tongue.rayPoints){
    
      if (dist(p.x, p.y, parent.location.x, parent.location.y) < parent.r) {
      
        l.frog
      }
    }
  }
  
  void dropActors(){
  
    for (int i = collidedActors.size() - 1; i >= 0; i--){
    
      collidedActors.remove(i);
    }
  }
}
