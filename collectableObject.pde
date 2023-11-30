class CollectableObject extends GameObject { 
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean willReplaceByAnotherGameObject;
  
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, Collectable collectable, boolean hasDialogue, String dialogue) {
    this(identifier, x, y, owidth, oheight, collectable, null, hasDialogue, dialogue);
  }
  
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, Collectable collectable, GameObject replaceWith, boolean hasDialogue, String dialogue) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile(), hasDialogue, dialogue);
    this.collectable = collectable;
    if(replaceWith != null) {
      this.replaceWith = replaceWith;
      this.willReplaceByAnotherGameObject = true;
    } else {
      this.willReplaceByAnotherGameObject = false;
    }
  }
  
  @Override
  public void draw() {
    super.draw();
  }
  
  @Override
  public void mouseClicked() {
    if(mouseIsHovering && !inventoryManager.containsCollectable(collectable)) {
      inventoryManager.addCollectable(collectable);
      sceneManager.getCurrentScene().removeGameObject(this);
      if(willReplaceByAnotherGameObject) {
        sceneManager.getCurrentScene().addGameObject(replaceWith);  
      }
    }
  }
}
