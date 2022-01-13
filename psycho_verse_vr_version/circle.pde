
void setup_circle() {
  background(0);
  //music4.play();
}

void drawCircle (PGraphics front) {  //attribué comme texture front
  front.background(0);
  front.strokeWeight(25);
  //front.blendMode(ADD);  //non utilisé en VR
  //front.stroke(#0805FC);


  front.stroke(0, 0, 255); // bleu 
  noisy(front, front.width/2, front.height/2, 150, vib, 2);
  //front.filter( BLUR, 1.3 );  //non utilisé en VR
  //music4.play();


  //front.stroke(#FEFF39);
  front.stroke(0, 255, 0); // vert
  noisy(front, front.width/2, front.height/2, 150, vib, 0.8);
  //front.filter( BLUR, 1.3);  //non utilisé en VR


  front.stroke(240, 230); // blanc
  noisy(front, front.width/2, front.height/2, 150, vib, 0.5);
  //front.filter( BLUR, 1.3);  //non utilisé en VR


  //front.stroke(#FC0509);
  front.stroke(255, 0, 0); // rouge
  noisy(front, front.width/2, front.height/2, 150, vib, 1.4);
  //front.filter( BLUR, 1.3 );  //non utilisé en VR
}

/*  
if (debug) {  
 ellipse(target_x, target_y, 50, 20);
 }
 
 //interaction camera non utilisée en VR
 
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
 fill(0);
 rect(0, 0, width, height);
 drawTarget(x, y);
 target_x = width-x;
 target_y = y;
 }
 
 target_x = width-x;
 target_y = y;
 }
 }*/


void noisy(PGraphics front, float pos_x, float pos_y, float r, float amp, float scale) {
  int n = 20;
  front.noFill();
  front.beginShape();
  for (int i=0; i<n+2; i++) {
    float angle = i * TWO_PI/(n-1);
    float loc_r = r + amp * map(noise(scale * sin(angle/2), scale* cos(angle/2), millis()/500.0), 0, 1, -1, 1);
    float x = pos_x + loc_r * cos(angle);
    float y = pos_y + loc_r * sin(angle);
    front.curveVertex(x, y);
  }
  front.endShape(CLOSE);
}

/*if (mousePressed)
 {
 vib = 50;
 }*/
