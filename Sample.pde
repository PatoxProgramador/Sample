//stored variables
PImage img;

PImage character;

void setup(){
  
  size(800,600);
  imageMode(CENTER);
  img = loadImage("Data/images.png");
  
}

void draw(){
  
  image(img,width/2,height/2);
  
  img.resize(width,height);
  
}
