class Collision extends Component {

  // variables
  Actor parent;
  ArrayList<Actor> collidedActors = new ArrayList();
  boolean hitTongue = false;

  Collision(Actor parent) {

    name = "collision";
    this.parent = parent;
  }

  void update(float x, float y) {

    findCollisions(levels[currentLevel]);
  }

  void draw(float x, float y) {
  }

  void findCollisions(Level l) {

    if (l.frog.tongue.state == TongueState.PULL) { // only worry about this type of collision if frog tongue is pulling
    
      PMatrix matrix = new PMatrix2D();
      
      l.frog.findAngleToTarget(mouseX, mouseY);
      PVector frog = l.frog.location;
      PVector mouse = new PVector(mouseX, mouseY);
      PVector me = parent.location;
      
      matrix.reset();
      matrix.translate(frog.x, frog.y);
      matrix.rotate(l.frog.angleToTarget);
      
      PVector frogToMe = new PVector(0,0);
      PVector frogToMouse = new PVector(0,0);
      
      matrix.mult(me, frogToMe);
      matrix.mult(mouse, frogToMouse);
      
      PVector mouseToMe = new PVector(frogToMe.x - frogToMouse.x, frogToMe.y - frogToMouse.y);
      PVector mouseToFrog = new PVector(0, 0);

      if (frogToMouse.dot(frogToMe) > 0 && mouseToFrog.dot(mouseToMe) > 0) { // parent is within length of line

        PVector frogToMouseLeftNormal = new PVector(-frogToMouse.y, frogToMouse.x); // USE WITH MIDPOINTTOME?
        PVector frogToMouseRightNormal = new PVector(frogToMouse.y, -frogToMouse.x);
        frogToMouseLeftNormal.normalize();
        frogToMouseRightNormal.normalize();

        PVector frogToMouseMidpoint = new PVector(mouse.x*.5, mouse.y*.5);
        
        
        PVector midPointToMe = new PVector(me.x - frogToMouseMidpoint.x, me.y - frogToMouseMidpoint.y);
        
        //if (midPointToMe.dot(frogToMouseLeftNormal) > parent.r || midPointToMe.dot(frogToMouseRightNormal) > parent.r) l.frog.tongue.isHitByWasp = true;
        
      }
    }
  }
  
  void dropActors() {

    for (int i = collidedActors.size() - 1; i >= 0; i--) {

      collidedActors.remove(i);
    }
  }
}
