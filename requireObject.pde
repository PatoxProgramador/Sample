class RequireObject extends GameObject {
  private Collectable collectable;
  private GameObject replaceWith;
  
  SoundFile file;
  
  public RequireObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, Collectable collectable, GameObject replaceWith, SoundFile sound) {
    
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
    
    file = sound;
    
  }
  
  @Override
  public void mouseClicked() {
    
    if(mouseIsHovering && inventoryManager.containsCollectable(collectable)) {
      
      inventoryManager.removeCollectable(collectable);
      sceneManager.getCurrentScene().removeGameObject(this);
      sceneManager.getCurrentScene().addGameObject(replaceWith);
      
    }
    else if(mouseIsHovering && !inventoryManager.containsCollectable(collectable)){
      
      file.play();
      
    }
    else {
      
      super.mouseClicked();
      
    }
  } 
}
