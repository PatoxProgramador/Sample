class GameObject {
  protected int x;
  protected int y;
  protected int owidth;
  protected int oheight;
  private String identifier;
  private boolean hasImage;
  private boolean hasHoverImage;
  private PImage gameObjectImage;
  private PImage gameObjectImageHover;
  protected boolean mouseIsHovering;
  private String text;
  boolean hasDialogue;

  public GameObject(String identifier, int x, int y, int owidth, int oheight){
    this(identifier, x, y, owidth, oheight, "", false, "");
  }

  public GameObject(String identifier, int x, int y, int owidth, int oheight, boolean hasDialogue, String dialogue) {
    this(identifier, x, y, owidth, oheight, "", hasDialogue, dialogue);
  }

  public GameObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, boolean hasDialogue, String dialogue) {
    this.identifier = identifier;
    this.x = x;
    this.y = y;
    this.owidth = owidth;
    this.oheight = oheight;
    this.hasImage = !gameObjectImageFile.equals("");
    if (this.hasImage) {
      this.gameObjectImage = loadImage(gameObjectImageFile);
    }
    hasHoverImage = false;
    mouseIsHovering = false;
    this.hasDialogue = hasDialogue;
    text = dialogue;
  }

  public void setHoverImage(String gameObjectImageHoverFile) {
    this.gameObjectImageHover = loadImage(gameObjectImageHoverFile);
    hasHoverImage = true;
  }

  public void draw() {
    if (hasImage) {
      
      if (mouseIsHovering && hasHoverImage) {
        
        
        
        image(gameObjectImageHover, x, y, owidth, oheight);
        
         //cursor(HAND);
         
      } else {
        image(gameObjectImage, x, y, owidth, oheight);
        
        //cursor(ARROW);
      }
    }
    
    if(hasDialogue && mouseIsHovering && sceneManager.getCurrentScene().getSceneName() != "intro" && sceneManager.getCurrentScene().sceneName != "start") new Dialogue(text).draw();
    
  }

  public void mouseMoved() {
    
    mouseIsHovering = false;
    
    if (mouseX >= x - owidth/2 && mouseX <= x + owidth/2 &&
      mouseY >= y - oheight/2 && mouseY <= y + oheight/2) {
      mouseIsHovering = true;
      
    }
    
  }

  public void mouseClicked() {
  }

  public String getIdentifier() {
    return this.identifier;
  }

  @Override
    public boolean equals(Object obj) {
    if (obj == this) {
      return true;
    }
    if (obj == null || obj.getClass() != this.getClass()) {
      return false;
    }
    GameObject otherGameObject = (GameObject) obj;
    return otherGameObject.getIdentifier().equals(this.identifier);
  }

  @Override
    public int hashCode() {
    final int prime = 11;
    return prime * this.identifier.hashCode();
  }

  
  
}
