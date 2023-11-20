//stored variables
PImage img;

Mover move;

void setup(){
  
  size(800,600);
  
  move = new Mover();
  
  img = loadImage("Data/images.png");
  
}

void draw(){
  
  image(img,0,0);
  
  img.resize(width,height);
  
  move.display();
  move.move();
  
}
