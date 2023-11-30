class Switch {
  
  PImage active;
  PImage inactive;

  Light light1;
  Light light2;
  Light light3;

  int x;
  int y;
  
  int sizeX;
  int sizeY;
    
  boolean switchActive = false;

  boolean toggle1;
  boolean toggle2;
  boolean toggle3;
  SoundFile sound;

  Switch(int pX, int pY, int pSizeX, int pSizeY, Light l1, Light l2, Light l3, boolean t1, boolean t2, boolean t3, String activeIMG, String inactiveIMG, SoundFile a) {
    x = pX;
    y = pY;
    sizeX = pSizeX;
    sizeY = pSizeY;

    toggle1 = t1;
    toggle2 = t2;
    toggle3 = t3;

    light1 = l1;
    light2 = l2;
    light3 = l3;
    
    sound = a;
    
    active = loadImage(activeIMG);
    inactive = loadImage(inactiveIMG);
  }

  void draw() {
    imageMode(CENTER);
    image(switchActive ? active : inactive, x, y, sizeX, sizeY);
  }

  void mouseClicked() {
    if (dist(mouseX, mouseY, x, y) < sizeY && switchPuzzleEnabled) {
      sound.play();
      switchActive = !switchActive;
      if (toggle1) {
        light1.toggle();
      }
      if (toggle2) {
        light2.toggle();
      }
      if (toggle3) {
        light3.toggle();
      }
    }
  }
}
