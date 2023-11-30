class Light {

  boolean lightActive;

  int x;
  int y;
  int size;
  
  PImage active;
  PImage inactive;


  Light(int pX, int pY, int pSize, String inactiveIMG, String activeIMG) {

    x = pX;
    y = pY;
    size = pSize;

    lightActive = false;
    
    active = loadImage(activeIMG);
    inactive = loadImage(inactiveIMG);
  }


  void toggle() {
    lightActive = !lightActive;
  }

  void draw() {
    imageMode(CENTER);
    image(lightActive ? inactive : active, x, y, size, size);
  }
}
