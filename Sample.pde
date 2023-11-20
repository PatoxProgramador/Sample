//stored variables
PImage img;

Mover move;

PImage character;

void setup(){
  
  size(800,600);
  imageMode(CENTER);
  character = loadImage("Data/guy.png");
  
  move = new Mover(character);
  
  img = loadImage("Data/images.png");
  
}

void draw(){
  
  image(img,width/2,height/2);
  
  img.resize(width,height);
  
  move.display();
  move.move();
  
}
