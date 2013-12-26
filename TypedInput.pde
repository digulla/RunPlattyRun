
class TypedInput {
  
  PFont font;
  int x = 0, y = 0;
  String text = "";
  color background = color(255);
  color textColor = color(0,0,0);
  boolean done = false;
  int maxLength = 20;
  
  void setup() {
    font = createFont("monospaced", 24);
    text = "";
  }
  
  void draw() {
    pushStyle();
    
    fill(textColor);
    textFont(font);
    text(text + "_", x, y);
    
    popStyle();
  }
  
  void keyPressed() {
    switch(key) {
      case BACKSPACE:
        text = text.substring(0,max(0,text.length()-1));
        break;
      case ENTER:
      case RETURN:
        done = true;
        break;
      case CODED:
      case ESC:
      case DELETE:
        break;
      default:
        if(text.length() < maxLength) {
          text += key;
        }
    }
  }
}
