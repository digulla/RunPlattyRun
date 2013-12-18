
int signum(float value) {
  return value < 0 ? -1 : value > 0 ? 1 : 0;
}

void textWithOutline(String message, int x, int y, color outline, color fill) {
  fill(outline);
  text(message, x-1, y);
  text(message, x+1, y);
  text(message, x, y-1);
  text(message, x, y+1);
  
  fill(fill);
  text(message, x, y);
}

class State {
  void setup() {}
  void draw() {}
  void keyPressed() {}
}

