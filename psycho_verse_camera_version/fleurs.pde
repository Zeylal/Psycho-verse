

SoundFile musicf;

int numRows = 30; //ligne de fleurs
int numColumns = 40; //colone de fleurs
int numFlowers = 30;
float gridSpacing = 40;
int[] counter;
int offsetX, offsetY;

shapeClass thing;
int[] numPetals;
float[] shapeWidth, shapeHeight;
float[] rotation;
int[] rotationDirection;
float[] xpos, ypos;
color[] colour;

void setup_fleurs() {

  musicf = new SoundFile(this, "bloom.mp3");
  //musicf.play();

  counter = new int[numRows*numColumns];
  numPetals = new int[numRows*numColumns];
  shapeWidth = new float[numRows*numColumns];
  shapeHeight = new float[numRows*numColumns];
  rotation = new float[numRows*numColumns];
  rotationDirection = new int[numRows*numColumns];
  xpos = new float[numRows*numColumns];
  ypos = new float[numRows*numColumns];
  colour = new color[numRows*numColumns];

  offsetX = int((width - (numColumns * gridSpacing)) / 2 + gridSpacing / 2);
  offsetY = int((height - (numRows * gridSpacing)) / 2 + gridSpacing / 2);

  for (int f = 0; f < numFlowers; f++)
  {
    setInitialValues(f);
  }
}


void draw_fleurs() {
  
  pushStyle();
  fill(0, 5);
  noStroke();
  rect(0, 0, width, height);
  
  for(int f = 0; f < numFlowers; f++)
  {
    thing = new shapeClass(shapeWidth[f], shapeHeight[f], colour[f], 255);
    pushMatrix();
    translate(xpos[f], ypos[f]);
    rotate(rotation[f]);
    thing.display();
    popMatrix();
    rotation[f] += (PI / numPetals[f] * 2) * rotationDirection[f];
  
    if(counter[f] < numPetals[f]) counter[f]++;
    else setInitialValues(f);
  }
  
  if(musicf.isPlaying() == false){
      musicf.play();
  }
  
  popStyle();
 
}



void setInitialValues(int f)
{
  //background(255);
  fill(0, 10); //couleur + transparence
  noStroke();
  rect(0, 0, width, height);
 

  counter[f] = 1;
  numPetals[f] = (int)random(5, 11);
  
  shapeWidth[f] = (int)random(gridSpacing / 3, gridSpacing / 2);
  shapeHeight[f] = (int)random(gridSpacing / 6, gridSpacing / 8);
  
  int tempColour = (int)random(20);
  if(tempColour == 17) colour[f] = color(0, random(128, 255), 0, 100);
  else colour[f] = color(random(128, 255), 0, random(128, 255), 100);
  
  int position = (int)random(numRows * numColumns);
  xpos[f] = offsetX + ((position % numColumns) * gridSpacing);
  ypos[f] = offsetY + (int(position / numColumns) * gridSpacing);  
  
  int tempValue = int(random(2));
  if(tempValue == 0) rotationDirection[f] = -1;
  else rotationDirection[f] = 1;
  rotation[f] = random(PI);
}


class shapeClass
{
  float shapeWidth;
  float shapeHeight;
  color colour;
  float shapeAlpha;
  
  shapeClass(float shapeWidth, float shapeHeight, color colour, float shapeAlpha)
  {
    this.shapeHeight = shapeHeight;
    this.shapeWidth = shapeWidth;
    this.colour = colour;
    this.shapeAlpha = shapeAlpha;
  }
  void display()
  {
    rectMode(CORNER);
    ellipseMode(CENTER);
    noStroke();
    fill(colour, shapeAlpha);
    ellipse(-shapeWidth/2, 0, shapeWidth, shapeHeight);
  }
}
