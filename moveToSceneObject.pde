class MoveToSceneObject extends GameObject {
  
  private String nextSceneIdentifier;
  private boolean moveBack;
  int em;
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, boolean moveBack) {
    this(identifier, x, y, owidth, oheight, "", moveBack);
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, boolean moveBack) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, false, "");
    this.moveBack = moveBack;
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier) {
    this(identifier, x, y, owidth, oheight, "", nextSceneIdentifier, false, "");
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String nextSceneIdentifier, boolean hasDialogue, String dialogue) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, hasDialogue, dialogue);
    this.nextSceneIdentifier = nextSceneIdentifier;
    this.moveBack = false;
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier, boolean hasDialogue, String dialogue) {
    super(identifier, x, y, owidth, oheight, "", hasDialogue, dialogue);
    this.nextSceneIdentifier = nextSceneIdentifier;
    this.moveBack = false;
  }
  
  
  @Override
  public void mouseClicked() {
    if(mouseIsHovering) {
      
      if(getIdentifier().contains("door")){
        
        SoundFile opening = new SoundFile(Sample.this,"door.wav");
        
        opening.play();
        
      }
      
      if(this.getIdentifier().equals("goToFish_curtain") && inventoryManager.containsCollectable(syringe)){
        try {
          sceneManager.goToScene(nextSceneIdentifier);
          mouseIsHovering = false;
          return;
        } catch(Exception e) { 
          println(e.getMessage());
        }
      }
      
      if(moveBack) {
        sceneManager.goToPreviousScene();
        mouseIsHovering = false;
      } else {
        try {
          sceneManager.goToScene(nextSceneIdentifier);
          mouseIsHovering = false;
        } catch(Exception e) { 
          println(e.getMessage());
        }
      }
    }
  }
}
