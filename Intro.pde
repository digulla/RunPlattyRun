
class Step {
  int minX = tileSize * 3;
  int minY = tileSize * 3;
  int maxX = width - (tileSize * 3);
  int maxY = height - (tileSize * 3);

  int x = minX;
  int y = minY;
  int dx = tileSize;
  int dy = 0;
  
  void next() {
    int newX = x + dx;
    int newY = y + dy;
    
    if(dy == 0 && y == minY && newX > maxX) {
      newX = maxX;
      dx = 0;
      dy = tileSize;
      newY += dy;
    } else if(dx == 0 && x == maxX && newY > maxY) {
      newY = maxY;
      dx = -tileSize;
      dy = 0;
      newX += dx; 
    } else if(dy == 0 && y == maxY && newX < minX) {
      newX = minX;
      dx = 0;
      dy = -tileSize;
      newY += dy;
    } else if(dx == 0 && x == minX && newY < minY) {
      newY = minY;
      dx = tileSize;
      dy = 0;
      newX += dx; 
    }
    
    x = newX;
    y = newY;
  }
}

class IntroState extends State {
  
  Player p;
  Enemy e;
  Step playerStep;
  Step enemyStep;
  
  void setup() {
    
    playerStep = new Step();
    playerStep.x += + 3*tileSize;
    
    p = new Player();
    
    e = new Enemy("Kenny");

    enemyStep = new Step();
    
    frameRate(10);
  }
  
  void drawBackground() {
    fill(174, 204, 27);
    rect(0, 0, width, height);
    
    textAlign(CENTER, TOP);
    textSize(40);
    color outline = color(255,255,255);
    color fill = color(0,0,0);
    textWithOutline("Run, Platty, Run!", width/2, height/2 - 40, outline, fill);
    
    textSize(20);
    outline = color(0,0,255);
    fill = color(255,255,255);
    textWithOutline("Press any key to start", width/2, height/2 + 20, outline, fill);
  }
  
  void draw() {
    movePlayer();
    moveEnemy();
    
    drawBackground();
    p.draw();
    e.draw();
  }
  
  void movePlayer() {
    playerStep.next();
    p.x = playerStep.x;
    p.y = playerStep.y;
  }
  
  void moveEnemy() {
    enemyStep.next();   
    e.x = enemyStep.x;
    e.y = enemyStep.y;
  }
  
  void keyPressed() {
    changeState(new MainGame());
  }
}
