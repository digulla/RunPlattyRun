
class Player {
  int x = 320, y = 240;

  void draw() {
    fill(235,220,160);
    rect(x, y, tileSize, tileSize);
    
    fill(0);
    textSize(tileSize-2);
    textAlign(CENTER, CENTER);
    text("P", x+tileSize/2, y+tileSize/2-2);
  }
  
  void move(int dx, int dy) {
    dx *= tileSize;
    dy *= tileSize;
    
    int newX = x + dx;
    int newY = y + dy;
    if(newX >= 0
      && newX < width
      && newY >= 0
      && newY < height
    ) {
      x = newX;
      y = newY;
    }
  }
}

class Enemy {
  color c;
  int x, y;
  String name;
  boolean fighting;
  
  Enemy(String name) {
    this.name = name;
    c = color(222,40,107);
  }
  
  void draw() {
    fill(c);
    ellipse(x + tileSize/2, y + tileSize/2, tileSize, tileSize);
    
    fill(0);
    textAlign(CENTER, TOP);
    textSize(12);
    text(name, x + tileSize/2, y + tileSize + 2);
  }
  
  void hunt(int px, int py) {
    int dx = signum(px - x) * tileSize;
    int dy = signum(py - y) * tileSize;
    
    x += dx;
    y += dy;
  }
  
  boolean closeTo(int tx, int ty) {
    int dx = abs(x - tx) / tileSize;
    int dy = abs(y - ty) / tileSize;
    println(name+" dx="+dx+" dy="+dy);
    return dx <= 1 && dy <= 1;
  }
}

class MainGame extends State {
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  Player player;
  int score = 0;

  void addEnemy(int x, int y, String name) {
    Enemy enemy = new Enemy(name);
    enemy.x = x;
    enemy.y = y;
    enemies.add(enemy);
  }
  
  void drawEnemies() {
   for(Enemy e: enemies) {
      e.draw();
    }
  }

  void setup() {
    score = 0;
    
    player = new Player();
  
    addEnemy(20, 20, "Kenny");
    addEnemy(600, 20, "Benny");
  }

  void drawBackground() {
    fill(174, 204, 27);
    rect(0, 0, width, height);
      
    fill(0);
    textAlign(LEFT, TOP);
    textSize(20);
    text("Scrore: "+score, 2, 2);
  }
  
  void draw() {
    drawBackground();
    player.draw();
    drawEnemies();
  }
  
  void moveEnemies() {
    for(Enemy e: enemies) {
      e.hunt(player.x, player.y);
    }
  }
  
  void checkCollisions() {
    ArrayList<Enemy> enemiesToCheck = new ArrayList<Enemy>();
    
    for(Enemy e: enemies) {
      if(e.closeTo(player.x, player.y)) {
        gameOver(e);
        return;
      }
      
      for(Enemy e2: enemiesToCheck) {
        if(e.closeTo(e2.x, e2.y)) {
          e.fighting = true;
          e2.fighting = true;
        }
      }
      
      enemiesToCheck.add(e);
    }
    
    int notFighting = 0;
    for(Enemy e: enemies) {
      if(!e.fighting) {
        notFighting ++;
      }
    }
    
    score ++;
    if(notFighting == 0) {
      youWon();
    }
  }
  
  void gameOver(Enemy e) {
    changeState(new GameOverLostState(this, e));
  }
  
  void youWon() {
    changeState(new GameOverWonState(this, enemies.size())); 
  }
  
  void movePlayer(int dx, int dy) {
    player.move(dx, dy);
    moveEnemies();
    checkCollisions();
  }
  
  void keyPressed() {
    if(key == CODED) {
      if(keyCode == UP) {
        movePlayer(0, -1);
      } else if(keyCode == DOWN) {
        movePlayer(0, 1);
      } else if(keyCode == LEFT) {
        movePlayer(-1, 0);
      } else if(keyCode == RIGHT) {
        movePlayer(1, 0);
      }
    } else if(key == ' ') {
      movePlayer(0, 0);
    }  
  }  
}

