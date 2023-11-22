int wwidth = 800;
int wheight = 800;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

Timer timer;

boolean showTimer = false;

void settings()
{

  size(wwidth, wheight);
}

void setup()
{

  timer = new Timer(2, false);

  

  Collectable apple = new Collectable("apple", "back04_apple.png");

  Scene start = new Scene("start", "images.png");

  MoveToSceneObject startGame = new MoveToSceneObject("start", width/2, height/2, 50, 50, "arrowUp.png", "intro");

  startGame.setHoverImage("Blue.png");

  start.addGameObject(startGame);


  Scene introduction = new Scene("intro", "white.png");


//---------------------------------------------------

  //Creating the scene
  Scene spawn = new Scene("spawn", "back01.png");

  //Move scenes arrows
  MoveToSceneObject object2 = new MoveToSceneObject("goToHallway_spawn", 708, 445, 50, 50, "arrowRight.png", "hallway");
  spawn.addGameObject(object2);
  MoveToSceneObject restaurantSceneMoveTo = new MoveToSceneObject("goToCards_spawn", 388, 440, 50, 50, "arrowUp.png", "cards");
  spawn.addGameObject(restaurantSceneMoveTo);

  //Replacement when apple is obtained
  MoveToSceneObject object7 = new MoveToSceneObject("goToScene04_scene01", 206, 461, 50, 50, "arrowUp.png", "forest");

  //Requires apple puzzle
  RequireObject loupe01 = new RequireObject("requiresApple_scene01", 206, 461, 50, 50, "zoom.png", "You need an Apple before getting here!", apple, object7);
  loupe01.setHoverImage("zoomIn.png");
  spawn.addGameObject(loupe01);
  
  

//-----------------------------------------------------

  Scene hallway = new Scene("hallway", "back02.png");
  MoveToSceneObject object3 = new MoveToSceneObject("goBack_spawn", 350, 700, 50, 50, "arrowDown.png", true);
  hallway.addGameObject(object3);
  MoveToSceneObject object4 = new MoveToSceneObject("goToSceneHouse_hallway", 441, 494, 50, 50, "arrowUp.png", "house");
  hallway.addGameObject(object4);


//-------------------------------------------------------


  Scene house = new Scene("house", "back04.png");
  MoveToSceneObject object5 = new MoveToSceneObject("goBack_house", 203, 673, 50, 50, "arrowDown.png", true);
  house.addGameObject(object5);
  CollectableObject object6 = new CollectableObject("apple", 325, 366, 123, 101, apple);
  house.addGameObject(object6);
  
//-----------------------------------------------------

  Scene forest = new Scene("forest", "back03.png");

  MoveToSceneObject winObject = new MoveToSceneObject("win object", width/2, height/2, 100, 100, "medal1.png", "win scene");
  forest.addGameObject(winObject);


//------------------------------------------------------
  Scene winScene = new Scene("win scene", "trophy.png");
  
//-----------------------------------------------------

  Scene cards = new Scene("cards", "back05.png");
  MoveToSceneObject object8 = new MoveToSceneObject("goBack_spawn", 203, 753, 50, 50, "arrowDown.png", true);
  cards.addGameObject(object8);
  
//--------------------------------------------------------


  sceneManager.addScene(start);
  sceneManager.addScene(introduction);
  sceneManager.addScene(spawn);
  sceneManager.addScene(hallway);
  sceneManager.addScene(house);
  sceneManager.addScene(forest);
  sceneManager.addScene(cards);
  sceneManager.addScene(winScene);
}

void draw()
{
  if (sceneManager.getCurrentScene().getSceneName() == "intro") {
    timer.timerStarted = true;

    if (timer.getTime() <= 0) {
      try {
        sceneManager.goToScene("spawn");
        timer.setTimer(65);
        showTimer = true;
      }
      catch(Exception e) {
        println(e.getMessage());
      }
    }
  }
  if (timer.timerStarted) {
    timer.countDown();
  }



  sceneManager.getCurrentScene().draw(wwidth, wheight);
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
  inventoryManager.showInventory();

  if (showTimer) {
    if (timer.getTime() > 60) {
      fill(0);
    } else {
      fill(second()%2==0 ? 0 : color(255,0,0));
    }
    textSize(24);
    text("Time left: " + nf((int)timer.getTime(), 1), 10, 25);
  }
}

void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  sceneManager.getCurrentScene().mouseClicked();
}
