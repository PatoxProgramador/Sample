class Safe {
  String[] numbers = new String[10];
  PImage gameObjectImage;
  int x;
  int y;
  int size;

  boolean canClick = true;

  int index = 0;


  Safe(int pX, int pY, int pSize) {
    numbers[0] = "zero.png";
    numbers[1] = "one.png";
    numbers[2] = "two.png";
    numbers[3] = "three.png";
    numbers[4] = "four.png";
    numbers[5] = "five.png";
    numbers[6] = "six.png";
    numbers[7] = "seven.png";
    numbers[8] = "eight.png";
    numbers[9] = "nine.png";

    gameObjectImage = loadImage(numbers[0]);

    x = pX;
    y = pY;
    size = pSize;
  }

  public void mouseClicked() {
    if(mouseButton == LEFT && canClick) {
      canClick = false;
      if ((mouseX > x - size/2 && mouseX < x + size/2) && (mouseY > y - size/2 && mouseY < y + size/2)) {
        index++;
        if (index > 9) index = 0;
        gameObjectImage = loadImage(numbers[index]);
      }
    }
  }

  public void mouseReleased() {
    canClick = true;
  }

  public void drawNumber(){
    imageMode(CENTER);
    image(gameObjectImage, x, y, size, size);
  }
  
  public String getCurrentNumber(){
    return numbers[index];
  }
  
  
}
