class Dialogue {
  //String s[] = {"INT DAY\nPlayer wakes up in a hospital bed. ",
  //  "(VOICE OVER)\nWhat the fuck!",
  //  "The door is locked",
  //  "This room is bigger then I thought",
  //  "Different species of what...?",
  //  "AGHH what is that!",
  //  "Oh theres something in here",
  //  "this might be usefull later",
  //  "Now i can get out",
  //  "Its locked"};

  String s;




  int index = 0;

  int x = width/2;
  int y = height-100;

  int sizeW = 650;
  int sizeH = 150;

  Dialogue() {
  }

  Dialogue(String in) {
    s = in;
  }

  void draw() {
      pushMatrix();
      fill(0);
      translate(x, y);
      rectMode(CENTER);
      rect(0, 0, sizeW, sizeH);

      textAlign(LEFT, CENTER);
      fill(255);
      text(s, 15, 0, sizeW, sizeH);
      popMatrix();
      
    
  }

  void setIndex(int input) {
    index = input;
  }
}
