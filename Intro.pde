
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
    
    if(newX > maxX) {
      newX = maxX;
      dx = 0;
      dy = tileSize;
      newY += dy;
    } else if(newY > maxY) {
      newY = maxY;
      dx = -tileSize;
      dy = 0;
      newX += dx; 
    } else if(newX < minX) {
      newX = minX;
      dx = 0;
      dy = -tileSize;
      newY += dy;
    } else if(newY < minY) {
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
  HighscoreRenderer highscoreRenderer;
  int startFrame;
  
  void setup() {
    
    playerStep = new Step();
    playerStep.x += + 3*tileSize;
    
    p = new Player();
    
    e = new Enemy("Kenny");

    enemyStep = new Step();
    
    frameRate(10);
    
    highscoreRenderer = new HighscoreRenderer();
    highscoreRenderer.setup();
    highscoreRenderer.x = tileSize * 5;
    highscoreRenderer.y = tileSize * 5;
    
    startFrame = frameCount;
  }
  
  void drawBackground() {
    textAlign(CENTER, TOP);
    textSize(40);
    color outline = color(255,255,255);
    color fill = color(0,0,0);
    int y = height/2 - 60;
    textWithOutline("Run, Platty, Run!", width/2, y, outline, fill);
    y += 50;
    
    textSize(20);
    textWithOutline("Use cursor keys to evade the hungry crocodiles", width/2, y, outline, fill);
    y += 40;
    
    outline = color(0,0,255);
    fill = color(255,255,255);
    textWithOutline("Press any key to start", width/2, y, outline, fill);
    y += 20;
  }
  
  void drawHighscore() {
    highscoreRenderer.draw();
  }
  
  void draw() {
    movePlayer();
    moveEnemy();

    background(174, 204, 27);
    
    if(showHighscore()) {
      drawHighscore();
    } else {
      drawBackground();
    }
    
    p.draw();
    e.draw();
  }
  
  boolean showHighscore() {
    int frame = frameCount - startFrame;
    return (frame / 20 % 2) == 1;
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
