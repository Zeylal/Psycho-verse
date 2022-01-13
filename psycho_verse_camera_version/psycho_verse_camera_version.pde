/*Musique
 National Geographic - Time-Lapse: Watch Flowers Bloom Before Your Eyes
 Ocean Sounds - Calm Ocean Sounds
 Sound Effects Factory - Small Group Whispering Sound Effect
 
 */
/*References Codes
 Waves_practice - Thiya - Univers 2_Mer
 Circle Packing - Christopher Hallet - Univers 3_Yeux
 uncomfortable shape - jordi - Univers 4_Circle
 allonestring - flowers - Univers 1_Fleurs
 */



import processing.sound.*;

import processing.video.*;


boolean debug = false;


// detection webcam
float target_x = 0;
float target_y = 0;
int numPixels;
float []previousFrame;
Capture  cam;
float pixAverage;
int drawTarget = 0;


// mode de selection des tableaux
int mode = 0;


void setup() {

  fullScreen();
  background(0);


  // webcam
  cam = new Capture(this, width, height);
  cam.start();
  numPixels = cam.width * cam.height;
  previousFrame = new float[numPixels];
  loadPixels();

  setup_cercle();
  setup_fleurs();
  setup_yeux();
  setup_Mer();
  setup_screen();


  //music.play();
}




void draw() {

  // webcam
  if (mode !=1) {
    updateTarget();
  }


  if (mode == 0) {
    draw_screen();
  } else if (mode == 4) {
    draw_cercle();
  } else if (mode == 1) {
    draw_fleurs();
  } else if (mode ==3) {
    draw_yeux();
  } else if (mode ==2) {
    draw_Mer();
  }


  //music stop selection
  if (mode != 4) {
    music.stop();
  }
  if (mode != 1) {
    musicf.stop();
  }
  if (mode != 2) {
    musicm.stop();
  }
  if (mode != 3) {
    musicy.stop();
  }
  if (mode != 0) {
    musics.stop();
  }

  //debug
  if (debug) {
    ellipse(target_x, target_y, 50, 20);
  }
}

//motion detection target / debug
void updateTarget() {
  if (cam.available()) {
    cam.read();
    cam.loadPixels();
    int x = 0;
    int y = 0;
    int sum = 0;
    for (int i = 0; i < numPixels; i++) {
      float currColor = red(cam.pixels[i]);
      float prevColor = previousFrame[i];
      float d = abs(prevColor-currColor);
      if (d>50) {
        int xt = i % cam.width;
        int yt = i / cam.width;
        x += xt;
        y += yt;
        sum ++;
        pixels[i] = color(currColor, 0, 0);
      } else
        pixels[i] = color(currColor);
      previousFrame[i] = currColor;
    }
    if (sum>1000) {
      updatePixels();
      x /= sum;
      y /= sum;
      //fill(0);
      //rect(0, 0, width, height);
      // drawTarget(x, y);
      //target_x = width-x;
      //target_y = y;
    }

    target_x = width-x;
    target_y = y;
  }
}

void drawTarget(int x, int y)
{
  line(x, y-15, x, y-4);
  line(x, y+15, x, y+4);
  line(x-15, y, x-4, y);
  line(x+15, y, x+4, y);
}


//MakeyMakey
void keyReleased() {

  if (key == CODED) {
    if (keyCode == UP) {
      println("ok");
      mode ++;
    }


    if (keyCode == DOWN) {
      mode --;
    }
  }



  if (mode < 0) {
    mode = 0;
  } else if (mode > 4) {
    mode = 4;
  }
}
