class RequireObject extends GameObject {
  private Collectable collectable;
  private GameObject replaceWith;
  
  SoundFile file;
  
  public RequireObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, Collectable collectable, GameObject replaceWith, SoundFile sound, boolean hasDialogue, String dialogue) {
    
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, hasDialogue, dialogue);
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
