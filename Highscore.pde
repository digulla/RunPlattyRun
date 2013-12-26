
import java.util.Collections;

class HighscoreItem implements Comparable {
  int score;
  String name;
  
  HighscoreItem(int score, String name) {
    this.score = score;
    this.name = name;
  }
  
  int compareTo(Object o) {
    HighscoreItem other = (HighscoreItem) o;
    return signum(other.score - score); 
  }
}

class Highscore {
  ArrayList<HighscoreItem> scores = new ArrayList<HighscoreItem>();
  File dataFile = new File(dataPath("highscore.dat"));
  
  void add(int score, String name) {
    HighscoreItem item = new HighscoreItem(score, name);
    scores.add(item);
    Collections.sort(scores);
    
    while(scores.size() > 10) {
      scores.remove(scores.size() - 1);
    }
  }
  
  boolean goodEnough(int score) {
    return scores.isEmpty() || score > scores.get(scores.size() - 1).score; 
  }
  
  void load() {
    scores.clear();
    
    if(dataFile.exists()) {
      JSONObject json = loadJSONObject(dataFile);
      JSONArray values = json.getJSONArray("scores");
      for(int i=0; i<values.size(); i ++) {
        JSONObject item = values.getJSONObject(i);
        int score = item.getInt("score");
        String name = item.getString("name");
        
        add(score, name);
      }
    }
    
    for(int i=scores.size(); i<10; i++) {
      add(0, "Nobody");
    }
  }
  
  void save() {
    JSONArray values = new JSONArray();
    for(int i=0; i<scores.size(); i ++) {
      JSONObject item = new JSONObject();
      item.setInt("score", scores.get(i).score);
      item.setString("name", scores.get(i).name);
      
      values.setJSONObject(i, item);
    }
    
    JSONObject json = new JSONObject();
    json.setJSONArray("scores", values);
    
    saveJSONObject(json, dataFile.getPath());
  }
}

class HighscoreRenderer {
  
  PFont font;
  int lineHeight = 28;
  color fill = color(0, 0, 0);
  int x = 0, y = 0;
  
  void setup() {
    font = createFont("monospaced", 24, true);
  }
  
  void draw() {
    pushStyle();

    int y = this.y;
    
    textAlign(CENTER, TOP);
    textSize(32);
    color outline = color(255,255,255);
    color fill = color(0,0,0);
    textWithOutline("HIGHSCORES", width/2, y, outline, fill);
    y += 40;
    
    fill(fill);
    textFont(font);
    textAlign(LEFT, TOP);
    
    for(int i=0; i<highscore.scores.size(); i++) {
      HighscoreItem item = highscore.scores.get(i);
      String text = String.format("%2d. %5d %s", i+1, item.score, item.name);
      text(text, x, y);
      y += lineHeight;
    }
    
    popStyle();
  }
}
