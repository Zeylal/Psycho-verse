SoundFile musicm;

boolean is_detected = false;

//size
int ranges = 200;

float pos = 0;
float speed;


void setup_Mer(){
   musicm = new SoundFile(this, "Calm.aiff");
 background(0);
 
 stroke(0, 255, 255);
  strokeWeight(4);
  frameRate(10);
}

void draw_Mer() {
  
  //updateTarget();
  background(0);
  noFill();
  stroke(0);
  strokeWeight(1);
  //motion detection / interaction avec mouvement
  target_x = constrain(target_x, 0, width);
  
   println(target_x,speed);
    speed = map(target_x, 0, width, 0.005, 0.09);
    
     pos += speed;

  for (int i = 0; i < ranges; i++) {
    float paint = map(i, 0, ranges, 0, 255);
    stroke(#2B29E3);

//wave
    beginShape();
    for (int x = -10; x < width + 11; x += 20) {
      float n = noise(x * 0.001, i * 0.01, pos);
      float y = map(n, 0, 1, 10, height);
      vertex(x, y);
    }
    endShape();
  }
  if(musicm.isPlaying() == false){
      musicm.play();
  }
  //ellipse(target_x, target_y, 100, 100);
}
