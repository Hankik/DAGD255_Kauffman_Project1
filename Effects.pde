class Effects extends Component {

  // variables
  Actor parent;
  HashMap<String, Integer> effects = new HashMap();
  HashMap<String, Timer> effectTimers = new HashMap();


  Effects(Actor parent) {

    name = "effects";
    this.parent = parent;
  }

  void update(float _x, float _y) {

    try {
      for (Map.Entry<String, Timer> entry : effectTimers.entrySet()) {

        entry.getValue().update();
        if (entry.getValue().isDone) { // if timer is done, remove effect

          // use debuffs to remove effects within this class
          if (entry.getKey().equals("pondskipper")) give("pondskipperCD", 1.0);
          
          
          effects.remove(entry.getKey());
          effectTimers.remove(entry.getKey());
        }
      }
    }
    catch (Exception e) {

      println(e);
    }
  }

  void draw(float _x, float _y) {
  }

  void setEffectTimer(String effect, float duration) {

    effectTimers.put(effect, new Timer(duration));
  }

  void give(String effect, float duration) {

    effects.put(effect, 1);
    if (duration > 0) setEffectTimer(effect, duration);
    apply(effect);
  }

  boolean contains(String name) {
    if (effects.containsKey(name)) return true;
    return false;
  }

  void apply(String effect) {

    switch (effect) {
    case "largeSpeedBoost":
      parent.speed += 150;
      break;
    case "pondskipper":
      if (parent instanceof Frog) {
        ((Frog) parent).setTipSize(16);
      }
      break;
    case "pondskipperCD":
      if (parent instanceof Frog) {
        ((Frog) parent).setTipSize(8);
      }
    }
  }
}
