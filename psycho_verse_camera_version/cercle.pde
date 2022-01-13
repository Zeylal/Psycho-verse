
//animation cercle
float vib = 0;
SoundFile music;


void setup_cercle() {
  // musique cercle
  music = new SoundFile(this, "jdqf.aiff"); //changer le musique ici
}


void draw_cercle() {
  
  pushStyle();
  background(0);
  strokeWeight(20);
  blendMode(ADD);
  //stroke(#0805FC);
  stroke(0, 0, 255);
  noisy(width/2, height/2, 150, vib, 2);
  //filter( BLUR, 1.3 );


  stroke(255, 0, 0);
  noisy(width/2, height/2, 150, vib, 1.4);
  //filter( BLUR, 1.3 );

  stroke(0, 255, 0);
  noisy(width/2, height/2, 150, vib, 0.8);
  //filter( BLUR, 1.3);

  //noisy(width/2, height/2, 150, vib, 0.5);
  //filter( BLUR, 1.3);


  if (vib > 0.1) {
    vib = vib *0.90;
    
    if (music.isPlaying() == false) {
      music.play();
    }
  } else {
    music.stop();
  }
  
  
  if (dist(target_x, target_y, width/2, height/2) < 200) {
    vib=50;
  }
  
  blendMode(0);
  popStyle();
}


//interaction 
void noisy(float pos_x, float pos_y, float r, float amp, float scale) {
  int n = 20;
  noFill();
  beginShape();
  for (int i=0; i<n+2; i++) {
    float angle = i * TWO_PI/(n-1);
    float loc_r = r + amp * map(noise(scale * sin(angle/2), scale* cos(angle/2), millis()/500.0), 0, 1, -1, 1);
    float x = pos_x + loc_r * cos(angle);
    float y = pos_y + loc_r * sin(angle);
    curveVertex(x, y);
  }
  endShape(CLOSE);
}
