// Version 9: Intro

int tileSize = 20;
State current;

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
  
  changeState(new IntroState());
}

void draw() {
  current.draw();
}

void keyPressed() {
  current.keyPressed();
}

