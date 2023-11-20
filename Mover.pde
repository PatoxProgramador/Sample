class Mover{
  
  public float y;
  public float x;
  public float dy = 0;
  public float dx = 5;
  public float sizex = 50;
  public float sizey = 70;
  public PImage f;
  
  Mover(PImage a){
    
    x = 0 + sizex;
    y = height - sizey/2;
    
    f = a;
    
  }
  
  public void move(){
    
    y += dy;
    x += dx;
    
    if(x <= 0 + (sizex/2) || x >= width - (sizex/2)){
      
      dx = dx * -1;
      
    }
    
  }
  
  public void display(){
    
    image(f,x,y,sizex,sizey);
    
  }
  
}
