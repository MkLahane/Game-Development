class Game {
  ArrayList<Snake> snakes;
  int cols = 5;
  int spacingCol;
  int currentTailLength = 0;
  //Food food;
  ArrayList<Item> items;
  //ArrayList<ArrayList<Item>> listOfItems;
  Game() {
    snakes = new ArrayList<Snake>();
    spacingCol = width / cols;
    float y = height - 250;
    float x = cols / 2 * spacingCol + spacingCol / 2;
    snakes.add(new Snake(x, y));
    currentTailLength++;
    for (int i = 0; i < 6; i++) {
      snakes.add(new Snake(snakes.get(currentTailLength - 1)));
      currentTailLength++;
    }
    //listOfItems = new ArrayList<ArrayList<Item>>();
    items = new ArrayList<Item>();
    initItems();

    //initFood();
  } 

  void initItems() {
    items = new ArrayList<Item>();
    //all 5 blocks 
    if (random(1) < 0.1) {
      for (int i = 0; i < cols; i++) {
        float blockX = i * spacingCol;
        int num = floor(random(3, 10));
        items.add(new Block(blockX, -100, spacingCol, spacingCol, num));
      }
    } else if (random(1) < 0.6) { //4 blocks and 1 food
      for (int i = 0; i < cols - 1; i++) {
        float blockX = i * spacingCol;
        int num = floor(random(3, 10));
        items.add(new Block(blockX, -100, spacingCol, spacingCol, num));
      }
      float foodX = (cols - 1) * spacingCol + spacingCol / 2;
      float y = -100 + spacingCol / 2;
      items.add(new Food(foodX, y));
    } else {  //only food
      items.add(initFood());
    }
  } 


  Food initFood() {
    float foodX = floor(random(0, cols - 1)) * spacingCol + spacingCol / 2;
    return new Food(foodX, random(-100, 0) + spacingCol / 2);
  } 
  void run() {
    for (int j = 0; j < cols; j++) {
      strokeWeight(1);
      stroke(0);
      line(j * spacingCol, 0, j * spacingCol, height);
    }
    boolean obstruction = false;
    for (int i = items.size() - 1; i >= 0; i--) {
      Item item = items.get(i);
      if (item.tag == "Block") {
        if (snakes.get(0).collided(item)) {
          currentTailLength -= item.number;
          if (currentTailLength <= 0) {
            noLoop();
          } else {
            for (int j = snakes.size() - 1; j >= currentTailLength; j--) {
              snakes.remove(j);
            }
          }
          items.remove(i);
          break;
        }
      }
    } 
    for (Item item : items) {
      item.show();
      item.update();
    }


    int foodIndex = -1;
    for (int i = 0; i < items.size(); i++) {
      Item item = items.get(i);
      if (item.tag == "Food") {
        foodIndex = i;
        break;
      }
    } 
    for (Snake snake : snakes) {
      snake.show();
      snake.update();
    } 

    if (foodIndex != -1) {
      if (snakes.get(0).checkEaten(items.get(foodIndex))) {
        items.remove(foodIndex);
        snakes.add(new Snake(snakes.get(currentTailLength - 1)));
        currentTailLength++;
      }
    }
    for (int i = 0; i < items.size(); i++) { 
      if (items.get(0).y + spacingCol >= height) {
        items.clear();
        break;
      }
    }
    if (items.size() <= 0) {
      initItems();
    }
  } 

  void move(float dir) {
    int j = floor(snakes.get(0).x / spacingCol);
    j += dir;
    if (j >= 0 && j <= cols - 1) {
      float x = j * spacingCol + spacingCol / 2;
      snakes.get(0).parent = new Snake(x, snakes.get(0).y - 20);
    }
  }
} 