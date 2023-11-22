class Timer{
   
  float time;
  
  Timer(float initial){ //cunstructor initialize a timer
    
    time = initial;
    
  }
  
  float getTime(){ //returns the current time
    
    return time;
    
  }
  
  void setTimer(float initial){ //restart initialize, without having to redeclare it
    
    time = initial;
    
  }
  //count up or down
  void countUp(){
    
    time += 1/frameRate;
    
  }
  void countDown(){
    
    time -= 1/frameRate;
    
  }
  
}
