import processing.sound.*;
/*  //musiques pas utilisées en VR  
SoundFile music0;
SoundFile music1;
SoundFile music2;
SoundFile music3;
SoundFile music4;
 */

import processing.vr.*;

AccelerometerManager accel;  // acceleromètre

float ax, ay, az;

//textures
PGraphics top;    //texture top
PGraphics right;    //texture right
PGraphics bottom;  //texture bottom
PGraphics back;  //texture back
PGraphics left;  //texture left
PGraphics front;  //texture front 

int mode = 0;  //debut à l'intro (mode 0)

float target_x = 0;
float target_y = 0;

float vib = 1;

void settings() {
  fullScreen(VR);
}


void setup() {

  println("start ");  //verif. fonctionnement n°1
  
  //textures
  //top = createGraphics(1500, 1500); 
  //right = createGraphics(1500, 1500);
  // bottom = createGraphics(1500, 1500);
  back = createGraphics(1500, 1500);  //pour 5 faces de l'intro
  //left = createGraphics(1500, 1500);
  front = createGraphics(1500, 1500);  //pour 1 face de l'intro, et toutes les faces des autres modes


  accel = new AccelerometerManager(this);

  //musiques
  //music0 = new SoundFile(this, ".aiff"); //musique intro
  //music1 = new SoundFile(this, "flowers.aiff"); //musique flowers
  //music2 = new SoundFile(this, "sea.aiff"); //musique sea
  //music3 = new SoundFile(this, "eyes.aiff"); //musique eyes
  //music4 = new SoundFile(this, ".aiff"); //musique circle

  //music0.play();  //jouer la musique

  setup_flowers();
  println("setup");  //verif. fonctionnement n°2
  setup_sea();

  setup_eyes();

  setup_circle();
  println("setupfinid");  //verif. fonctionnement n°3
}


void draw() {
  background(0);
  ambientLight(255, 255, 255);  //lumières ambientes
  //strokeWeight(50);
  stroke(0);

  /*
   top.beginDraw();  
   
   top.endDraw();
   
   
   right.beginDraw();
   
   right.endDraw();
   
   
   bottom.beginDraw();
   
   bottom.endDraw();
   
   
   left.beginDraw();
   
   left.endDraw();
   */

  if (mode == 0) {
    front.beginDraw();  //1 face
    drawIntro(front); 
    front.endDraw();


    back.beginDraw();  //5 faces
    back.background(0);
    back.endDraw();
  }

  if (mode == 1) {
    front.beginDraw();
    drawFlowers(front);
    front.endDraw();
  }

  if (mode == 2) {
    front.beginDraw();
    drawSea(front);
    front.endDraw();

    back.beginDraw();
    back.background(0);
    back.endDraw();
  }

  if (mode == 3) {

    front.beginDraw();
    front.strokeWeight(50);
    drawEyes(front);
    front.endDraw();

    back.beginDraw();
    back.background(0);
    back.endDraw();
  }

  if (mode == 4) {
    front.beginDraw();
    drawCircle(front);
    front.endDraw();

    back.beginDraw();
    back.background(0);
    back.endDraw();
  }


//cube -> 6 faces
  beginShape();  //face carrée bottom
  texture(front);
  if (mode == 0) {
    texture(back);
  }
  vertex(0, 0, 0, 0, 1500);
  vertex(1600, 0, 0, 1500, 1500);
  vertex(1600, 0, 1600, 1500, 0);
  vertex(0, 0, 1600, 0, 0);
  endShape(CLOSE);


  beginShape();  //face carrée left
  texture(front);
  if (mode == 0) {
    texture(back);
  }
  vertex(1600, 0, 0, 1500, 0);
  vertex(1600, 0, 1600, 0, 0);
  vertex(1600, 1600, 1600, 0, 1500);
  vertex(1600, 1600, 0, 1500, 1500);
  endShape(CLOSE);


  beginShape();  //face carrée top
  texture(front);
  if (mode == 0) {
    texture(back);
  }
  vertex(1600, 1600, 0, 1500, 1500);
  vertex(1600, 1600, 1600, 1500, 0);
  vertex(0, 1600, 1600, 0, 0);
  vertex(0, 1600, 0, 0, 1500);
  endShape(CLOSE);


  beginShape();  //face carrée back
  texture(front);
  if (mode == 0) {
    texture(back);
  }
  vertex(1600, 1600, 0, 0, 1500);
  vertex(0, 1600, 0, 1500, 1500);
  vertex(0, 0, 0, 1500, 0);
  vertex(1600, 0, 0, 0, 0);
  endShape(CLOSE);


  beginShape();  //face carrée right
  texture(front);
  if (mode == 0) {
    texture(back);
  }
  vertex(0, 0, 0, 0, 0);
  vertex(0, 0, 1600, 1500, 0);
  vertex(0, 1600, 1600, 1500, 1500);
  vertex(0, 1600, 0, 0, 1500);
  endShape(CLOSE);


  beginShape();  //face carrée front
  texture(front);
  vertex(1600, 1600, 1600, 0, 1500);
  vertex(0, 1600, 1600, 1500, 1500);
  vertex(0, 0, 1600, 1500, 0);
  vertex(1600, 0, 1600, 0, 0);
  endShape(CLOSE);
}


void drawTarget(int x, int y) {
  line(x, y-15, x, y-4);
  line(x, y+15, x, y+4);
  line(x-15, y, x-4, y);
  line(x+15, y, x+4, y);
}


void keyReleased() {  //interactions changement de mode
  if (key == CODED) {
    if (keyCode == UP) {  //touche haut

      mode ++;
    } else if (keyCode == DOWN) {  //touche bas
      mode --;
    }
  }
  if (mode<0) {  //pas de mode<0
    mode = 0;
  }
  if (mode>4) {  //pas de mode>4
    mode = 4;
  }

  back = createGraphics(1500, 1500);
  front = createGraphics(1500, 1500);

  //println(mode);
}


void keyPressed() {  //interaction vibration circle
  if (key == CODED) {
    if (keyCode == LEFT) {  //touche gauche
      vib = random(55);
    }
  }
}
