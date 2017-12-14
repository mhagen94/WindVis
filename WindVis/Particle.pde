
class Particle {
  
 int LifeTime;
 int MaxLife;
 int xPos;
 int yPos;
 
 Particle(int tempLife, int tempX, int tempY){
    LifeTime = tempLife;
    MaxLife = tempLife;
    xPos = tempX;
    yPos = tempY;
    
 }

  void decrementLife(){
     LifeTime--;
  }

  void checkLife(){
     if (LifeTime == 0){
       LifeTime = MaxLife;
     }
  }
  
  void adjustX(float xVal){
     xPos += xVal; 
  }
  
  void adjustY(float yVal){
     yPos += yVal; 
  }
}