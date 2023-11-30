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
 cursor, music
 
 */
import processing.sound.*;

boolean canClick = true;

Light l1;
Light l2;
Light l3;

Switch s1;
Switch s2;
Switch s3;

String cabinetString = "cabinet_closed.png";

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
float spawnInterval = 20000;

Safe safe1;
Safe safe2;
Safe safe3;

MoveToSceneObject toBed;
Scene hallway;

String code = "one.pngone.pngthree.png";
//Sound
SoundFile bMusic;
SoundFile scream;
SoundFile lobby;
SoundFile safeOpen;
SoundFile switching;
SoundFile fishy;
SoundFile collect;
SoundFile bang;

boolean scared;

boolean scenePlaying = false;

float startScene;
boolean itemScene = false;
boolean doesntmatter;

Collectable fishKey;

Scene fish;

CollectableObject doorKeyObject;
Collectable doorKey;

boolean keyScene = false;
float keyStarted;

void settings()
{
  //fullScreen();
  size(wwidth, wheight);
}

void setup()
{

  doorKey = new Collectable("door key", "doorkeyinventory.png");
  doorKeyObject = new CollectableObject("door key object", width/2, height/2, 50, 50, doorKey);
  
  switching = new SoundFile(this, "switch.wav");

  l1 = new Light(635, 400, 50, "light_on.png", "light_off.png");
  l2 = new Light(935, 400, 50, "light_on.png", "light_off.png");
  l3 = new Light(1235, 400, 50, "light_on.png", "light_off.png");

  s1 = new Switch(635, 550, 150, 200, l1, l2, l3, true, true, false, "switch_on.png", "switch_off.png",switching);
  s2 = new Switch(935, 550, 150, 200, l1, l2, l3, false, true, true, "switch_on.png", "switch_off.png",switching);
  s3 = new Switch(1235, 550, 150, 200, l1, l2, l3, false, true, false, "switch_on.png", "switch_off.png",switching);

  doesntmatter = false;

  fishKey = new Collectable("safe key", "fishkeyinventory.png");

  bMusic = new SoundFile(this, "soundbackground.wav");
  scream = new SoundFile(this, "scream.wav");
  lobby = new SoundFile(this, "Menu.wav");
  safeOpen = new SoundFile(this, "vault.wav");
  fishy = new SoundFile(this, "fish.wav");
  collect = new SoundFile(this, "collecting.wav");
  bang = new SoundFile(this, "lockDoor.wav");

  scared = false;

  lobby.loop();

  safe1 = new Safe(width/2 - 150, height/2 - 250, 100);
  safe2 = new Safe(width/2 - 10, height/2 - 250, 100);
  safe3 = new Safe(width/2 + 130, height/2 - 250, 100);

  lastSpawnTime = 0;
  tintAmount = 255;
  startTime = 100;
  division = spawnInterval/1000;
  ratio = startTime/division;
  red = tintAmount;
  change = tintAmount/ratio;

  timer = new Timer(1, false);

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
  Scene bed = new Scene("bed", "bed.jpg");



  //Move scenes arrows

  MoveToSceneObject toHallway = new MoveToSceneObject("goToHallway_spawn_door", 990, 535, 250, 500, "hallway");

  RequireObject needKey = new RequireObject("needDoorKey", 990, 535, 250, 500, "transparent.png", doorKey, toHallway, bang);
  bed.addGameObject(needKey);


  MoveToSceneObject toCurtain = new MoveToSceneObject("goToCurtain_spawn", 300, height/2, 650, height, "curtain");
  bed.addGameObject(toCurtain);

  MoveToSceneObject toBoard = new MoveToSceneObject("goToBoard_spawn", 1550, 360, 300, 300, "board");
  bed.addGameObject(toBoard);

  //---------------------------------------------------

  Scene board = new Scene("board", "board.png");

  MoveToSceneObject backToBed_board = new MoveToSceneObject("backToBed_board", width/2, height - 100, 50, 50, "blue.png", true);
  board.addGameObject(backToBed_board);


  //----------------------------------------------------

  Scene curtain = new Scene("curtain", "curtain.jpg");

  MoveToSceneObject toSafe = new MoveToSceneObject("goToSafe_curtain", 1690, 800, 150, 150, "safe");
  curtain.addGameObject(toSafe);

  MoveToSceneObject backToBed = new MoveToSceneObject("goBack_bed", width/2, height - 100, 50, 50, "blue.png", true);
  curtain.addGameObject(backToBed);

  MoveToSceneObject toFish = new MoveToSceneObject("goToFish_curtain", 1240, 440, 300, 350, "fish");
  curtain.addGameObject(toFish);

  //----------------------------------------------------

  fish = new Scene("fish", cabinetString);

  MoveToSceneObject backToCurtain = new MoveToSceneObject("goBack_bed", width/2, height - 100, 50, 50, "blue.png", true);
  fish.addGameObject(backToCurtain);

  //-----------------------------------------------------

  Scene safe = new Scene("safe", "safecloseup.png");

  MoveToSceneObject backToCurtain_fish = new MoveToSceneObject("goBack_curtain", width/2, height - 100, 50, 50, "blue.png", true);
  safe.addGameObject(backToCurtain_fish);

  //-----------------------------------------------------

  hallway = new Scene("hallway", "hallway.jpg");

  toBed = new MoveToSceneObject("goBack_bed_door", 980, 550, 160, 220, true);

  MoveToSceneObject toCamera = new MoveToSceneObject("goToSceneHouse_hallway_door", 710, 595, 120, 365, "camera");
  hallway.addGameObject(toCamera);


  //-------------------------------------------------------


  Scene camera = new Scene("camera", "surveillance.png");

  MoveToSceneObject backToHallway = new MoveToSceneObject("goBack_camera_door", width/2, height-100, 50, 50, "blue.png", true);
  camera.addGameObject(backToHallway);

  MoveToSceneObject toSwitchPuzzle = new MoveToSceneObject("goToSwitchPuzzle", 100, height/2, 250, 250, "switch");
  camera.addGameObject(toSwitchPuzzle);
  //----------------------------------------------------

  Scene switchPuzzle = new Scene("switch", "switch_pannel.png");

  //------------------------------------------------------
  Scene winScene = new Scene("win scene", "trophy.png");

  //--------------------------------------------------------


  sceneManager.addScene(start);
  sceneManager.addScene(introduction);
  sceneManager.addScene(bed);
  sceneManager.addScene(curtain);
  sceneManager.addScene(board);
  sceneManager.addScene(safe);
  sceneManager.addScene(fish);
  sceneManager.addScene(hallway);
  sceneManager.addScene(camera);
  sceneManager.addScene(switchPuzzle);
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

      if (!scared) {
        scream.play();
        lobby.loop();

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

  if (keyScene) {
    image(loadImage("key.png"), width/2, height/2, 1920, 1080);
  }

  if (itemScene) {
    image(loadImage("fishkey.png"), width/2, height/2, 1920, 1080);
  }

  if (itemScene && (millis() - startScene > 2500)) {
    itemScene = false;
    sceneManager.goToPreviousScene();
    inventoryManager.addCollectable(fishKey);
    collect.play();
    
  }
  
  if(keyScene && (millis() - keyStarted > 2500)){
    keyScene = false;
    sceneManager.goToPreviousScene();
    inventoryManager.addCollectable(doorKey);
    collect.play();
    
  }

  if (sceneManager.getCurrentScene().getSceneName() == "bed" && !doesntmatter) {

    bMusic.play();
    
    lobby.stop();

    doesntmatter = true;
  }

  if (sceneManager.getCurrentScene().getSceneName() == "switch") {
    switchPuzzle();
  }



  println("X: " + mouseX + " Y: " + mouseY);
}

void mouseMoved() {

  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {

  if (sceneManager.getCurrentScene().getSceneName() == "curtain") {
    if (inventoryManager.containsCollectable(fishKey)) {
      inventoryManager.removeCollectable(fishKey);
    }
  }

  sceneManager.getCurrentScene().mouseClicked();


  if (sceneManager.getCurrentScene().getSceneName() == "safe") {

    safe1.mouseClicked();
    safe2.mouseClicked();
    safe3.mouseClicked();



    if ((mouseX > width/2 - 100 && mouseX < width/2 + 100) && (mouseY > 760 - 100 && mouseY < 760 + 100)) {

      String input = safe1.getCurrentNumber() + safe2.getCurrentNumber() + safe3.getCurrentNumber();

      if (input.equals(code)) {
        itemScene = true;
        startScene = millis();
        
        safeOpen.play();

        fish.changeImage("cabinet_open.png");
        
        fish.addGameObject(doorKeyObject);
      }
    }
  }

  if (sceneManager.getCurrentScene().getSceneName() == "fish" && canClick) {
    keyScene = true;
    keyStarted = millis();
    
    fishy.play();
    
  }

  if (sceneManager.getCurrentScene().getSceneName() == "switch" && canClick) {
    s1.mouseClicked();
    s2.mouseClicked();
    s3.mouseClicked();

    canClick = false;
  }
}

void mouseReleased() {

  safe1.mouseReleased();
  safe2.mouseReleased();
  safe3.mouseReleased();

  canClick = true;
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

void switchPuzzle() {
  l1.draw();
  l2.draw();
  l3.draw();

  s1.draw();
  s2.draw();
  s3.draw();

  if (l1.lightActive && l2.lightActive && l3.lightActive) {
    sceneManager.goToPreviousScene();
    hallway.addGameObject(toBed);
  }
}
