
class GameOverState extends State {
  MainGame main;
  String mainMessage;
  String subMessage;
  
  GameOverState(MainGame main, String mainMessage, String subMessage) {
    this.main = main;
    this.mainMessage = mainMessage;
    this.subMessage = subMessage;
  }

  void draw() {
    main.draw();
  
    textAlign(CENTER, TOP);
    textSize(40);
    color outline = color(255,255,255);
    color fill = color(255,0,0);
    textWithOutline(mainMessage, width/2, 200, outline, fill);
    
    textSize(20);
    textWithOutline(subMessage, width/2, 240, outline, fill);
    
    outline = color(0,0,0);
    fill = color(255,255,255);

    textSize(20);
    textWithOutline("Try again (Y/N)?", width/2, 280, outline, fill);
  }
  
  void keyPressed() {
    if(key == 'y' || key == 'Y') {
      changeState(new MainGame());
    } else if(key == 'n' || key == 'N') {
      changeState(new IntroState());
    }
  } 
}

class EnterNameState extends State {
  MainGame main;
  TypedInput input;
  GameOverState nextState;
  
  EnterNameState(MainGame main, GameOverState nextState) {
    this.main = main;
    this.nextState = nextState;
  }
  
  void setup() {
    input = new TypedInput();
    input.setup();
    
    textSize(24);
    input.x = 20 + (int)textWidth("Your name?");
    input.y = 30 + 40 + 10;
  }
  
  void draw() {
    main.draw();
  
    textAlign(LEFT, TOP);
    textSize(36);
    color outline = color(255,255,255);
    color fill = color(255,0,0);
    textWithOutline("You made a new highscore: " + main.score, 10, 30, outline, fill);
    
    fill(color(0,0,0));
    textSize(24);
    text("Your name?", 10, input.y);
    
    input.draw();
  }
  
  void keyPressed() {
    input.keyPressed();
    
    if(input.done) {
      highscore.add(main.score, input.text);
      highscore.save();
      
      changeState(nextState);
    }
  }
}

class GameOverWonState extends GameOverState {
  GameOverWonState(MainGame main, int numberOfEnemies) {
    super(main, "YOU WON!", "The cute platypus outsmarted "+numberOfEnemies+" crocodiles!");
  }
}

class GameOverLostState extends GameOverState {
  GameOverLostState(MainGame main, Enemy e) {
    super(main, "GAME OVER", "The poor platypus was eaten by "+e.name+"!");
  }
}

