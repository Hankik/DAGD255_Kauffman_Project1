class Data {
  
  private static Data data = null;
  
  // variables
  
  
  // Creating private constructor 
  // restricted to this class itself
  private Data() {
  
    // Instantiate variables
    
  }
  
  // static method to create instance of singleton class
  public static Data getInstance() {
  
    if (data == null) {
    
      data = new Data();
    }
    
    return data;
  }
}
