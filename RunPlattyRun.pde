// Version 9: Intro

int tileSize = 20;
State current;
Highscore highscore;

void mousePressed() {  
  saveFrame("frame-######.png");
  println("Saved frame.");
}

void changeState(State next) {
  current = next;
  current.setup();
}

void setup() {
  size(640, 480); //VGA for those old enough to remember
  
  highscore = new Highscore();
  highscore.load();
  
  changeState(new IntroState());
}

void draw() {
  current.draw();
}

void keyPressed() {
  current.keyPressed();
}

