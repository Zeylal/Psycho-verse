int numRows = 30;  //nombre de rangées
int numColumns = 30;  //nombre de colonnes
int numFlowers = 5;
float gridSpacing = 50;
int[] counter;
int offsetX, offsetY;

shapeClass thing;
int[] numPetals;
float[] shapeWidth, shapeHeight;
float[] rotation;
int[] rotationDirection;
float[] xpos, ypos;
color[] colour;


void setup_flowers() {
  //smooth();
  //frameRate(12);
  //music1.play();
  
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

  for (int f = 0; f < numFlowers; f++) {
    setInitialValues(f);
  }
}

void setInitialValues(int f) {
  //front.fill(0, 10);
  //front.noStroke();
  //front.rect(0, 0, front.width, front.height);

  counter[f] = 1;
  numPetals[f] = (int)random(5, 11);

  shapeWidth[f] = (int)random(gridSpacing / 3, gridSpacing / 2);
  shapeHeight[f] = (int)random(gridSpacing / 6, gridSpacing / 8);

  int tempColour = (int)random(20);
  if (tempColour == 17) colour[f] = color(0, random(128, 255), 0, 100);
  else colour[f] = color(random(128, 255), 0, random(128, 255), 100);

  int position = (int)random(numRows * numColumns);
  xpos[f] = offsetX + ((position % numColumns) * gridSpacing);
  ypos[f] = offsetY + (int(position / numColumns) * gridSpacing);  

  int tempValue = int(random(2));
  if (tempValue == 0) rotationDirection[f] = -1;
  else rotationDirection[f] = 1;
  rotation[f] = random(PI);
}

void drawFlowers (PGraphics front) {
  
  front.fill(0, 5);
  front.noStroke();
  front.rect(0, 0, front.width, front.height);

  for (int f = 0; f < numFlowers; f++) {
    thing = new shapeClass(shapeWidth[f], shapeHeight[f], colour[f], 255);
    front.pushMatrix();
    front.translate(xpos[f], ypos[f]);
    front.rotate(rotation[f]);
    thing.display(front);
    front.popMatrix();
    rotation[f] += (PI / numPetals[f] * 2) * rotationDirection[f];

    if (counter[f] < numPetals[f]) counter[f]++;
    else setInitialValues(f);
  }
}


class shapeClass {
  float shapeWidth;
  float shapeHeight;
  color colour;
  float shapeAlpha;

  shapeClass(float shapeWidth, float shapeHeight, color colour, float shapeAlpha) {
    this.shapeHeight = shapeHeight;
    this.shapeWidth = shapeWidth;
    this.colour = colour;
    this.shapeAlpha = shapeAlpha;
  }


  void display(PGraphics front) {
    front.rectMode(CORNER);
    front.ellipseMode(CENTER);
    front.noStroke();
    front.fill(colour, shapeAlpha);
    front.ellipse(-shapeWidth/2, 0, shapeWidth, shapeHeight);
  }
}
