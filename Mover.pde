class Mover{
  
  public int y;
  public int x;
  public int dy = 0;
  public int dx = 5;
  public int size = 50;
  
  Mover(){
    
    x = 0 + size;
    y = height/2;
    
  }
  
  public void move(){
    
    y += dy;
    x += dx;
    
  }
  
  public void display(){
    
    ellipse(x,y,size,size);
    
  }
  
}
