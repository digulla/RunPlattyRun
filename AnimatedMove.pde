
class AnimatedMove {
  float dx, dy;
  int startFrame, endFrame;
  int sx, sy, x, y;
  boolean finished = false;
  
  public AnimatedMove(int sx, int sy, int ex, int ey, int cycles) {
    startFrame = frameCount;
    endFrame = startFrame + cycles;
    dx = ex - sx;
    dy = ey - sy;
    this.sx = sx;
    this.sy = sy;
    update();
  }
  
  public void update() {
    int currentFrame = frameCount;
    if(currentFrame >= endFrame) {
      x = sx + (int)dx;
      y = sy + (int)dy;
      finished = true;
    } else {
      float w = ((float)(currentFrame - startFrame)) / (endFrame - startFrame);
      x = sx + (int)(w * dx);
      y = sy + (int)(w * dy);
    }
  }
}
