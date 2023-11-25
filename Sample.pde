/*Objectives
**Enough sound to make game scary:
*- sound for clicking?
*- sound to inform the time (faster, different background music?)
*- background music
**
** Visuals in what is being clicked (visual feedback maybe (object and the pathways))
**
** story (in a form of instructions to help the players know what the hell they are doing)
** clues?
**
** time shown a more interactive way (watching the clock on pulse...)
**
** start screen polishment
** GameOver fix and polishment (tweak with time)
** introduction polishment
**
** quantity and style of puzzle and rooms (target audience? (to define difficulty and complexity))
** blood?
**
** inventory shown?
** type more requirements if needed here ---> 
*/
 
 import processing.sound.*;
 
int wwidth = 1920;
int wheight = 1080;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();
//timer
Timer timer;

float startTime;

boolean showTimer = false;
boolean gameStarted = false;
//equation of time and tintamount change in colour correlation
int red;
int tintAmount;
int ratio;
int division;
int change;
//counter for tint to work variables
float lastSpawnTime = 0;
//SpawnInterval is in milliseconds
float spawnInterval = 10000;

Safe safe1;
Safe safe2;
Safe safe3;

String code = "one.pngone.pngthree.png";
//Sound
SoundFile bMusic;


void settings()
{
  fullScreen();
  //size(wwidth, wheight);
}

void setup()
{
  
  bMusic = new SoundFile(this, "music.wav");
  
  bMusic.loop();

  safe1 = new Safe(width/2 - 100, height/2 - 200, 100);
  safe2 = new Safe(width/2, height/2 - 200, 100);
  safe3 = new Safe(width/2 + 100, height/2 - 200, 100);

  //safe.submitCode("one.pngone.pngthree.png");
  //println(safe.code);

  lastSpawnTime = 0;
  tintAmount = 255;
  red = tintAmount;
  startTime = 60;
  division = 10;
  ratio = (int)startTime/division;
  change = tintAmount/ratio;

  timer = new Timer(1, false);

  Collectable apple = new Collectable("apple", "Note.png");

  Scene start = new Scene("start", "start.png");
  Scene gameOver = new Scene("gameOver", "white.png");

  MoveToSceneObject startGame = new MoveToSceneObject("start", width/2, height/2, 50, 50, "arrowUp.png", "intro");

  startGame.setHoverImage("Blue.png");

  start.addGameObject(startGame);

  Scene introduction = new Scene("intro", "white.png");


  //---------------------------------------------------

  //Creating the scene
  Scene spawn = new Scene("spawn", "spawn.png");

  //Move scenes arrows
  MoveToSceneObject toHallway = new MoveToSceneObject("goToHallway_spawn", 1826, 600, 50, 50, "arrowRight.png", "hallway");
  spawn.addGameObject(toHallway);
  
  MoveToSceneObject toCards = new MoveToSceneObject("goToCards_spawn", 850, 610, 50, 50, "arrowUp.png", "cards");
  spawn.addGameObject(toCards);

  //Replacement when apple is obtained
  MoveToSceneObject toForest = new MoveToSceneObject("goToForest_spawn", 500, 590, 50, 50, "arrowUp.png", "forest");

  //Requires apple puzzle
  RequireObject requireApple = new RequireObject("requiresApple_spawn", 500, 590, 50, 50, "zoom.png", "You need an Apple before getting here!", apple, toForest);
  requireApple.setHoverImage("zoomIn.png");
  spawn.addGameObject(requireApple);



  //-----------------------------------------------------

  Scene hallway = new Scene("hallway", "hallway.png");
  
  MoveToSceneObject toSpawn = new MoveToSceneObject("goBack_spawn", 900, 1000, 50, 50, "arrowDown.png", true);
  hallway.addGameObject(toSpawn);
  
  MoveToSceneObject toHouse = new MoveToSceneObject("goToSceneHouse_hallway", 1115, 700, 50, 50, "arrowUp.png", "house");
  hallway.addGameObject(toHouse);


  //-------------------------------------------------------


  Scene house = new Scene("house", "house.png");
  
  MoveToSceneObject backToHallway = new MoveToSceneObject("goBack_house", 550, 860, 50, 50, "arrowDown.png", true);
  house.addGameObject(backToHallway);
  
  CollectableObject grabApple = new CollectableObject("apple", 930, 550, 200, 170, apple);
  house.addGameObject(grabApple);

  //-----------------------------------------------------

  Scene forest = new Scene("forest", "forest.png");

  //MoveToSceneObject winObject = new MoveToSceneObject("win object", width/2, height/2, 100, 100, "medal1.png", "win scene");
  //forest.addGameObject(winObject);

  GameObject submitButton = new GameObject("submit", width/2, height/2-100, 300, 100, "submit.png");
  forest.addGameObject(submitButton);



  //------------------------------------------------------
  Scene winScene = new Scene("win scene", "trophy.png");

  //-----------------------------------------------------

  Scene cards = new Scene("cards", "cards.png");
  MoveToSceneObject backToSpawn = new MoveToSceneObject("goBack_spawn", 1100, 1000, 50, 50, "arrowDown.png", true);
  cards.addGameObject(backToSpawn);

  //--------------------------------------------------------


  sceneManager.addScene(start);
  sceneManager.addScene(introduction);
  sceneManager.addScene(spawn);
  sceneManager.addScene(hallway);
  sceneManager.addScene(house);
  sceneManager.addScene(forest);
  sceneManager.addScene(cards);
  sceneManager.addScene(winScene);
  sceneManager.addScene(gameOver);
  
}

void draw()
{

  background(122, 122, 122);
  
  if (sceneManager.getCurrentScene().getSceneName() == "intro") {
    
    timer.timerStarted = true;

    if (timer.getTime() <= 0) {
      
      try {

        sceneManager.goToScene("spawn");
        timer.setTimer(startTime);
        showTimer = true;
        gameStarted = true;
        lastSpawnTime = millis();
        
      }
      catch(Exception e) {
        
        println(e.getMessage());
        
      }
    }
  }
  if (timer.timerStarted && timer.getTime() > 0) {

    timer.countDown();
    
  } else if (gameStarted && timer.getTime() <= 0) {

    try {

      sceneManager.goToScene("gameOver");

      tint(255);
    }
    catch(Exception e) {

      println(e.getMessage());
    }
  }

  sceneManager.getCurrentScene().draw(wwidth, wheight);
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
  inventoryManager.showInventory();

  if (showTimer) {
    
    if (timer.getTime() > 60) {
      
      fill(0);
      
    } else {
      
      fill(second()%2==0 ? 0 : color(255, 0, 0));
      
    }
    
    textSize(24);
    text("Time left: " + nf((int)timer.getTime(), 1), 10, 25);
    
  }
  //another way of working with time flow (extracted from apple project)

  if (millis() - lastSpawnTime > spawnInterval) {

    lastSpawnTime = millis();

    if (gameStarted) tintImage();
    
  }

  if (sceneManager.getCurrentScene().getSceneName() == "forest") {
    
    safe1.drawNumber();
    safe2.drawNumber();
    safe3.drawNumber();
    
  }
}

void mouseMoved() {
  
  sceneManager.getCurrentScene().mouseMoved();
  
}

void mouseClicked() {
  
  sceneManager.getCurrentScene().mouseClicked();
  
  safe1.mouseClicked();
  safe2.mouseClicked();
  safe3.mouseClicked();

  if (sceneManager.getCurrentScene().getSceneName() == "forest") {
    
    if ((mouseX > width/2 - 150 && mouseX < width/2 + 150) && (mouseY > height/2-150 && mouseY < height/2 - 50)) {
      
      String input = safe1.getCurrentNumber() + safe2.getCurrentNumber() + safe3.getCurrentNumber();
      
      if (input.equals(code)) {
        
        println("You won!");
        
        gameStarted = false;
        timer.timerStarted = false;
        
        try {
          
          sceneManager.goToScene("win scene");
          
        }
        catch(Exception e) {
          
          println(e.getMessage());
          
        }
      }
    }
  }
}

void mouseReleased() {
  
  safe1.mouseReleased();
  safe2.mouseReleased();
  safe3.mouseReleased();
  
}

void tintImage() {

  tintAmount -= change;
  red -= change*0.4;

  //prevents colour from being glitchy yellow
  if (tintAmount > 0) {

    tint(red,tintAmount,tintAmount);

    //System.out.println(tintAmount);
  }
}
