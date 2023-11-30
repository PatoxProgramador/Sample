/*Objectives
 **Enough sound to make game scary:
 *- sound for clicking?
 **
 ** Visuals in what is being clicked (visual feedback maybe (object and the pathways))
 **
 ** story (in a form of instructions to help the players know what the hell they are doing)
 ** clues?
 **
 ** time shown a more interactive way (watching the clock on pulse...)
 *- clicking somewhere to look at watch/ hover somewheer to look at watch, or time stays in a fixed place
 **
 ** start screen polishment
 ** GameOver fix and polishment (tweak with time)
 ** introduction polishment
 **
 ** inventory shown?
 **
 ** type more requirements if needed here ---> |
 V
 
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
float ratio;
float division;
float change;
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
SoundFile scream;

boolean scared;

void settings()
{
  //fullScreen();
  size(wwidth, wheight);
}

void setup()
{

  bMusic = new SoundFile(this, "soundbackground.wav");
  scream = new SoundFile(this, "scream.wav");
  
  scared = false;

  bMusic.loop();

  safe1 = new Safe(width/2 - 150, height/2 - 250, 100);
  safe2 = new Safe(width/2 - 10, height/2 - 250, 100);
  safe3 = new Safe(width/2 + 130, height/2 - 250, 100);

  //safe.submitCode("one.pngone.pngthree.png");
  //println(safe.code);

  lastSpawnTime = 0;
  tintAmount = 255;
  startTime = 100;
  division = spawnInterval/1000;
  ratio = startTime/division;
  red = tintAmount;
  change = tintAmount/ratio;

  timer = new Timer(1, false);

  //Collectable apple = new Collectable("apple", "note.png");

  Scene start = new Scene("start", "titlescreen.png");
  Scene gameOver = new Scene("gameOver", "white.png");

  MoveToSceneObject startGame = new MoveToSceneObject("start", width/2, height - 500, 300, 150, "startButton.png", "intro");
  //DID NOT DO IT CORRECTLY - HELP NEEDED
  MoveToSceneObject quitGame = new MoveToSceneObject("start", width/2, height - 300, 300, 150, "quitButton.png", "quit");

  startGame.setHoverImage("startButtonHighlight.png");
  quitGame.setHoverImage("quitButtonHighlighted.png");

  start.addGameObject(startGame);
  start.addGameObject(quitGame);

  Scene introduction = new Scene("intro", "white.png");


  //---------------------------------------------------

  //Creating the scene
  Scene bed = new Scene("bed", "scene_1.jpg");

  //Move scenes arrows
  MoveToSceneObject toHallway = new MoveToSceneObject("goToHallway_spawn", 991, 530, 100, 200, "hallway");
  bed.addGameObject(toHallway);

  MoveToSceneObject toCurtain = new MoveToSceneObject("goToCurtain_spawn", 300, height/2, 650, height, "curtain");
  bed.addGameObject(toCurtain);


  //MoveToSceneObject toCards = new MoveToSceneObject("goToCards_spawn", 850, 610, 50, 50, "arrowUp.png", "cards");
  //bed.addGameObject(toCards);

  //Replacement when apple is obtained
  //MoveToSceneObject toForest = new MoveToSceneObject("goToForest_spawn", 500, 590, 50, 50, "arrowUp.png", "forest");

  //Requires apple puzzle
  //RequireObject requireApple = new RequireObject("requiresApple_spawn", 500, 590, 50, 50, "zoom.png", "You need an Apple before getting here!", apple, toForest);
  //requireApple.setHoverImage("zoomIn.png


  //----------------------------------------------------

  Scene curtain = new Scene("curtain", "scene_2.jpg");
  
  MoveToSceneObject toSafe = new MoveToSceneObject("goToSafe_curtain", 1690, 800, 150, 150, "safe");
  curtain.addGameObject(toSafe);

  MoveToSceneObject backToBed = new MoveToSceneObject("goBack_bed", width/2, height - 100, 50, 50, "blue.png", true);
  curtain.addGameObject(backToBed);

  //-----------------------------------------------------

  Scene safe = new Scene("safe", "safecloseup.png");

  MoveToSceneObject backToCurtain = new MoveToSceneObject("goBack_curtain", width/2, height - 100, 50, 50, "blue.png", true);
  safe.addGameObject(backToCurtain);


  //-----------------------------------------------------

  Scene hallway = new Scene("hallway", "hallway.png");

  MoveToSceneObject toBed = new MoveToSceneObject("goBack_bed", 980, 550, 160, 220, true);
  hallway.addGameObject(toBed);

  MoveToSceneObject toCamera = new MoveToSceneObject("goToSceneHouse_hallway", 710, 595, 120, 365, "camera");
  hallway.addGameObject(toCamera);


  //-------------------------------------------------------


  Scene camera = new Scene("camera", "screens.png");

  MoveToSceneObject backToHallway = new MoveToSceneObject("goBack_camera", width/2, height-100, 50, 50, "blue.png", true);
  camera.addGameObject(backToHallway);

  MoveToSceneObject toCloseUp = new MoveToSceneObject("goToCloseUp", 830, 550, 500, 500, "close up");
  camera.addGameObject(toCloseUp);

  //CollectableObject grabApple = new CollectableObject("apple", 930, 550, 200, 170, apple);
  //house.addGameObject(grabApple);

  //-----------------------------------------------------

  //Scene forest = new Scene("forest", "forest.png");

  //MoveToSceneObject winObject = new MoveToSceneObject("win object", width/2, height/2, 100, 100, "medal1.png", "win scene");
  //forest.addGameObject(winObject);

  //GameObject submitButton = new GameObject("submit", width/2, height/2-100, 300, 100, "submit.png");
  //forest.addGameObject(submitButton);

  Scene closeUp = new Scene("close up", "cameraClose.png");

  MoveToSceneObject backToCamera = new MoveToSceneObject("toCamera_back", width/2, height-200, 50, 50, "blue.png", true);
  closeUp.addGameObject(backToCamera);


  //------------------------------------------------------
  Scene winScene = new Scene("win scene", "trophy.png");

  //-----------------------------------------------------

  //Scene cards = new Scene("cards", "cards.png");
  //MoveToSceneObject backToSpawn = new MoveToSceneObject("goBack_spawn", 1100, 1000, 50, 50, "arrowDown.png", true);
  //cards.addGameObject(backToSpawn);

  //--------------------------------------------------------


  sceneManager.addScene(start);
  sceneManager.addScene(introduction);
  sceneManager.addScene(bed);
  sceneManager.addScene(curtain);
  sceneManager.addScene(safe);
  sceneManager.addScene(hallway);
  sceneManager.addScene(camera);
  sceneManager.addScene(closeUp);
  //sceneManager.addScene(forest);
  //sceneManager.addScene(cards);
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

        sceneManager.goToScene("bed");
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
      
      bMusic.stop();
      
      if(!scared){
      scream.play();
      
      scared = true;
      
      }

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

  if (sceneManager.getCurrentScene().getSceneName() == "safe") {

    safe1.drawNumber();
    safe2.drawNumber();
    safe3.drawNumber();
    
    image(loadImage("illegal.png"), width/2 - 40, height/2 + 250, 470, 470);
  }

  //println("X: " + mouseX + " Y: " + mouseY);
}

void mouseMoved() {

  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {

  sceneManager.getCurrentScene().mouseClicked();


  if (sceneManager.getCurrentScene().getSceneName() == "safe") {

    safe1.mouseClicked();
    safe2.mouseClicked();
    safe3.mouseClicked();
  
    
    
    if ((mouseX > width/2 - 150 && mouseX < width/2 + 150) && (mouseY > height/2-150 && mouseY < height/2 + 150)) {

      String input = safe1.getCurrentNumber() + safe2.getCurrentNumber() + safe3.getCurrentNumber();

      if (input.equals(code)) {

        println("You won!");

        gameStarted = false;
        timer.timerStarted = false;

        try {

          sceneManager.goToScene("safe open");
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

    tint(red, tintAmount, tintAmount);
    //System.out.println(tintAmount);
  }
}
