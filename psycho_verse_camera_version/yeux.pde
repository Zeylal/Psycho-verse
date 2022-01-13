SoundFile musicy;

ArrayList<Circle> circles;


void setup_yeux() {
  musicy = new SoundFile(this, "Whispers.mp3");

  stroke(0, 255, 255);
  strokeWeight(4);
  frameRate(10);

  circles = new ArrayList<Circle>();
}


void draw_yeux() {
  background(0);
  drawEyes();
}

//new circles
void drawEyes() {
  Circle newC = newCircle();

  if (newC != null) {
    circles.add(newC);
  }

//circle growing
  for (Circle c : circles) {
    if (c.growing) {
      if (c.edges()) {
        c.growing = false;
      } else {
        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d < c.r + other.r) {
              c.growing = false;
              break;
            }
          }
        }
      }
    }

    c.show();
    c.grow();
  }
  if (musicy.isPlaying() == false) {
    musicy.play();
  }
}

Circle newCircle() {
  float x = random(width);
  float y = random(height);

  boolean valid = true;

  // For every circle created
  for (Circle c : circles) {
    // distance against circle distance
    float d = dist(x, y, c.x, c.y);
    // ... if distance is smaller than circle radius
    if (d < c.r) {
      //circle not valid
      valid = false;
      break;
    }
  }
  //if valid
  if (valid) {
    return new Circle(x, y);
  } else {
    return null;
  }
}

class Circle {
  float x;
  float y;
  float r; // radius size

  boolean growing = true;

  Circle(float x_, float y_) {
    x = x_; // temp vars x_
    y = y_;
    r = 1;
  }

  boolean edges() {
    return (x + r > width || x - r < 0 || y + r > height || y - r < 0 );
  }

  void grow() {
    if (growing) {
      r = r + 1;
    }
  }

  void show() {  //ext

    fill(255);
    ellipse(x, y, r*2, r*2);


    //**** pupil distance / motion detection
    noStroke();


    println(target_x);
    float pupilX = map(target_x, 0, width, -1, 1) * r/2;
    float pupilY = map(target_y, 0, height, -1, 1) * r/2;


    fill(#000000);
    ellipse(x+pupilX, y+pupilY, r*0.8, r*0.8);
  }
}
