//stored variables
PImage img;

void setup(){
  
  size(800,600);
  
  img = loadImage("Data/images.png");
  
}

void draw(){
  
  image(img,0,0);
  
  img.resize(width,height);
  
}
