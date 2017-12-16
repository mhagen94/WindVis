
class Particle {
  
 int LifeTime;
 int MaxLife;
 int MaxWidth;
 int MaxHeight;
 float xPos;
 float yPos;
 
 Particle(int tempLife, int tempWidth, int tempHeight, float tempX, float tempY){
    LifeTime = tempLife;
    MaxLife = tempLife;
    MaxWidth = tempWidth;
    MaxHeight = tempHeight;
    xPos = tempX;
    yPos = tempY;
    
 }
 
 float getXPos(){
  return xPos; 
 }
 
 float getYPos(){
  return yPos; 
 }

  void decrementLife(){
     LifeTime--;
  }

  void checkLife(){
     
     if (LifeTime == 0 || xPos <=1 || yPos <=1 || xPos >= MaxWidth - 1 || yPos >= MaxHeight - 1){
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