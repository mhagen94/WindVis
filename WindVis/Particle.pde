
class Particle {
  
 int LifeTime;
 int MaxLife;
 int MaxWidth;
 int MaxHeight;
 int xPos;
 int yPos;
 
 Particle(int tempLife, int tempWidth, int tempHeight, int tempX, int tempY){
    LifeTime = tempLife;
    MaxLife = tempLife;
    MaxWidth = tempWidth;
    MaxHeight = tempHeight;
    xPos = tempX;
    yPos = tempY;
    
 }
 
 int getXPos(){
  return xPos; 
 }
 
 int getYPos(){
  return yPos; 
 }

  void decrementLife(){
     LifeTime--;
  }

  void checkLife(){
     
     if (LifeTime == 0){
       LifeTime = MaxLife;
       xPos = (int) random(0, MaxWidth);
       yPos = (int) random(0, MaxHeight);
     }
  }
  
  void adjustX(float xVal){
     xPos += 0.1 * xVal; 
  }
  
  void adjustY(float yVal){
     yPos += 0.1 * yVal; 
  }
}