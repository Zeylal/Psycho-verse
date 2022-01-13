int ranges = 100;
float pos = 0;
float speed;

void setup_sea() {
  stroke(0, 255, 255);
  //strokeWeight(10);
  frameRate(20);
  //music2.play();
}

void drawSea (PGraphics front) {

  front.noFill();
  front.stroke(0);
  front.strokeWeight(1);

  speed = map(mouseY, 0, front.height, 0.01, 0.0);
  pos += speed;

  for (int i = 0; i < ranges; i+= 5) {  //nombre de vagues : de 0 (i) à 100 (ranges), de 5 en 5 (i+=) -> ici 20
    //float paint = map(i, 0, ranges, 0, 255);  //non utilisé en VR
    front.stroke(#2B29E3);
    front.beginShape();
    for (int x = -10; x < front.width + 11; x += 10) {
      float n = noise(x * 0.001, i * 0.01, pos);
      float y = map(n, 0, 1, 10, front.height);
      front.vertex(x, y);
    }
    front.endShape();
  }
}
