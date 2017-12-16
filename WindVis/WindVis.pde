// uwnd stores the 'u' component of the wind.
// The 'u' component is the east-west component of the wind.
// Positive values indicate eastward wind, and negative
// values indicate westward wind.  This is measured
// in meters per second.
Table uwnd;

// vwnd stores the 'v' component of the wind, which measures the
// north-south component of the wind.  Positive values indicate
// northward wind, and negative values indicate southward wind.
Table vwnd;

// An image to use for the background.  The image I provide is a
// modified version of this wikipedia image:
//https://commons.wikimedia.org/wiki/File:Equirectangular_projection_SW.jpg
// If you want to use your own image, you should take an equirectangular
// map and pick out the subset that corresponds to the range from
// 135W to 65W, and from 55N to 25N
PImage img;
ArrayList<Particle> particles;

void setup() {
  // If this doesn't work on your computer, you can remove the 'P3D'
  // parameter.  On many computers, having P3D should make it run faster
  size(700, 400, P3D);
  pixelDensity(displayDensity());
  particles = new ArrayList<Particle>();
  int numParticles = 5000;
  int lifeTimeMax = 200;
  int lifeTimeMin = 50;
  
  for (int i = 0; i < numParticles; i++){
    int randLife = (int) random(lifeTimeMin, lifeTimeMax);
    int randXPos = (int) random(0, width);
    int randYPos = (int) random(0, height);
    particles.add(new Particle(randLife, width, height, randXPos, randYPos));
  }
  
  
  img = loadImage("background.png");
  uwnd = loadTable("uwnd.csv");
  vwnd = loadTable("vwnd.csv");
  
}

void draw() {
  background(255);
  image(img, 0, 0, width, height);
  drawMouseLine();
  Particle currentParticle;
  stroke(0,0,0);
  beginShape(POINTS);
  for (int i = 0; i < particles.size(); i++){
    currentParticle = particles.get(i);
    currentParticle.checkLife();
    float currentX = ((float) currentParticle.getXPos()/width) * uwnd.getColumnCount() ;
    float currentY = ((float) currentParticle.getYPos()/height) * vwnd.getRowCount() ;
    
    float dx = readInterp(uwnd, currentX, currentY);
    float dy = readInterp(vwnd, currentX, currentY);
    
    if (i==0){
      //print("(", currentX,",",currentY, ") -> ");
    }
    currentParticle.adjustX(dx);
    currentParticle.adjustY(dy);
    currentParticle.decrementLife();
    
    vertex(currentParticle.getXPos(), currentParticle.getYPos());
  }
  endShape();
}

void drawMouseLine() {
  // Convert from pixel coordinates into coordinates
  // corresponding to the data.
  float a = mouseX * uwnd.getColumnCount() / width;
  float b = mouseY * vwnd.getRowCount() / height;
  
  // Since a positive 'v' value indicates north, we need to
  // negate it so that it works in the same coordinates as Processing
  // does.
  float dx = readInterp(uwnd, a, b) * 10;
  float dy = -readInterp(vwnd, a, b) * 10;
  stroke(255, 0, 0);
  line(mouseX, mouseY, mouseX + dx, mouseY + dy);
}

// Reads a bilinearly-interpolated value at the given a and b
// coordinates.  Both a and b should be in data coordinates.
float readInterp(Table tab, float a, float b) {
  float x = a;
  float y = b;
  
  int floorX = floor(x);
  int ceilX = ceil(x);
  int floorY = floor(y);
  int ceilY = ceil(y);
  
  float xRatio1 = a - floorX;
  float xRatio2 = 1 - xRatio1;
  float yRatio1 = b - floorY;
  float yRatio2 = 1 - yRatio1;
  
  float upperLeft  = readRaw(tab, floorX, floorY);
  float upperRight = readRaw(tab, ceilX, floorY);
  float lowerLeft  = readRaw(tab, floorX, ceilY);
  float lowerRight = readRaw(tab, ceilX, ceilY);
  
  float upperInterp = (upperLeft * xRatio2) + (upperRight * xRatio1);
  float lowerInterp = (lowerLeft * xRatio2) + (lowerRight * xRatio1);
  
  float verticalInterp = (upperInterp * yRatio2) + (lowerInterp * yRatio1);
  
  //readRaw(tab, (int) a, (int) b);
  return verticalInterp;
}

// Reads a raw value 
float readRaw(Table tab, int x, int y) {
  if (x < 0) {
    x = 0;
  }
  if (x >= tab.getColumnCount()) {
    x = tab.getColumnCount() - 1;
  }
  if (y < 0) {
    y = 0;
  }
  if (y >= tab.getRowCount()) {
    y = tab.getRowCount() - 1;
  }
  return tab.getFloat(y,x);
}