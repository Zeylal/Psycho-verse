
void drawIntro (PGraphics front) {
//texte BIENVENUE
  front.background(0);
  front.fill(#E635F0);
  front.textSize(50);
  front.textAlign(CENTER);
  front.text("BIENVENUE", 800, 1000);

//cercle 
  front.ellipseMode(CENTER);
  front.fill(#312F31);
  front.stroke(#E635F0);
  front.strokeWeight(3);
  front.ellipse(800, 750, 200, 200);

//texte START
  front.fill(#E635F0);
  front.textSize(40);
  front.textAlign(CENTER);
  front.text("START", 800, 765);
}
