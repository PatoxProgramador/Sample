class Timer {

  float time;
  boolean timerStarted;

  Timer(float initial, boolean started) { //cunstructor initialize a timer
    timerStarted = started;
    time = initial;
  }


  float getTime() { //returns the current time

    return time;
  }

  void setTimer(float initial) { //restart initialize, without having to redeclare it

    time = initial;
  }
  //count up or down
  void countUp() {

    time += 1/frameRate;
  }
  void countDown() {

    time -= 1/frameRate;
  }
}
