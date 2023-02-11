class Data {
  
  private static Data data = null;
  
  // Declare variablesfloat tongueCost;
    float tongueCost;
    float fasterSpawnsCost;
    float moreFliesCost;
    float morePondskippersCost;
    float moreDragonfliesCost;
    float moreWaspsCost;
    float moreBugsCost;
    float autoEatCost;
    
    float comboMultiplier;
    
    float flyStartValue;
    float pondskipperStartValue;
    float dragonflyStartValue;
    float waspStartValue;
    
    float tongueCostMultiplier;
    float spawnCostMultiplier;
    float flyCostMultiplier;
    float pondskipperCostMultiplier;
    float dragonflyCostMultiplier;
    float waspCostMultiplier;
    float bugsCostMultiplier;
  
  
  // Creating private constructor 
  // restricted to this class itself
  private Data() {
  
    // Instantiate variables
    tongueCost = 30f;
    fasterSpawnsCost = 15f;
    moreFliesCost = 5f;
    morePondskippersCost = 10f;
    moreDragonfliesCost = 20f;
    moreWaspsCost = 20f;
    moreBugsCost = 30f;
    autoEatCost = 5000f;
    
    comboMultiplier = 1.3f;
    
    flyStartValue = 1f;
    pondskipperStartValue = 2f;
    dragonflyStartValue = 9f;
    waspStartValue = 6f;
    
    tongueCostMultiplier = 1.1f;
    spawnCostMultiplier = 1.1f;
    flyCostMultiplier = 1.1f;
    pondskipperCostMultiplier = 1.1f;
    dragonflyCostMultiplier = 1.1f;
    waspCostMultiplier = 1.1f;
    bugsCostMultiplier = 1.1f;
    
  }
  
  // static method to create instance of singleton class
  public static Data getInstance() {
  
    if (data == null) {
    
      data = new Data();
    }
    
    return data;
  }
}
