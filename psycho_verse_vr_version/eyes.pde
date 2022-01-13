ArrayList<Circle> circles;

void setup_eyes() {
  circles = new ArrayList<Circle>();

  background(0);
  stroke(0, 255, 255);
  strokeWeight(4);
  //frameRate(10);
  //music3.play();
}

void drawEyes(PGraphics front) {
  front.background(0);

  Circle newC = newCircle();

  if (newC != null) {
    circles.add(newC);
  }

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

    c.show(front);
    c.grow();
  }
}


Circle newCircle() {
  float x = random(1400);
  float y = random(1400);

  boolean valid = true;

  // Pour chaque cercle créé
  for (Circle c : circles) {
    // ... check this distance against circle distance
    float d = dist(x, y, c.x, c.y);
    // ... if distance is smaller than circle radius
    if (d - 20 < c.r) {
      // ... circle not valid
      valid = false;
      break;
    }
  }
  // ... if valid
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
    r = 10;
  }

  boolean edges() {
    return (x + r > 1400 || x - r < 0 || y + r > 1400 || y - r < 0 );
  }

  void grow() {
    if (growing) {
      r = r + 1;
    }
  }

  void show(PGraphics front) {

//blanc yeux
    front.fill(235);
    front.stroke(0);
    front.strokeWeight(5);
    front.ellipse(x, y, r*2, r*2);

//pupilles
    front.noStroke();
    float pupilX = 0;    //ne change pas en VR
    float pupilY = target_y * r/2; 

    front.fill(#000000);
    front.ellipse(x+pupilX, y+pupilY, r*0.8, r*0.8);
  }
}

public void accelerationEvent(float x, float y, float z) {
  //println("acceleration: " + x + ", " + y + ", " + z);
  //target_x = y * 20;
  target_y = map(z, 6.5, -6.5, -1, 1); //mouvement vertical pupille, opposé à l'inclinaison du casque

 //redraw();  //non utilisé en VR
}
