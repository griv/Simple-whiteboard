// simple drawing app for use in the ROOM project
// steve berrick <steve@berrick.net>
// july 2014

int buttonSize = 60;

RectButton[] buttons = new RectButton[12];
color lineColour;
int lineWeight = 4;
PVector ppPoint, pPoint, cPoint;

void setup() {

//  size(displayWidth, displayHeight);
  size(1280, 800);
  if (frame != null) {
    frame.setResizable(true);
  }
  colorMode(RGB);
  smooth();
  background(0);
  frameRate(60);
  noCursor();

  // setup background
  noFill();
  stroke(0);
  strokeWeight(lineWeight);

  lineColour = color(123);

  // buttons
  colorMode(HSB);
  for (int i=0; i<12; i++) {
    RectButton newButton = new RectButton(width - buttonSize, buttonSize * i, buttonSize, color(20 * i, 255, 255)); 
    buttons[i] = newButton;
    buttons[i].display();
  }
  
  ppPoint = new PVector(0,0);
  
}
void draw() {
  
  // clear background
  if (keyPressed && key ==' ') {
    clearDrawing();
  }
  
}

void drawButtons() {
  for (int i=0; i<12; i++) {
    buttons[i].display();
  }  
}

void mousePressed() {
  ppPoint = new PVector(mouseX, mouseY); 
  pPoint = new PVector(mouseX, mouseY);
  cPoint = new PVector(mouseX, mouseY);
}

void mouseReleased() {
  
  for (int i=0; i<12; i++) {
    buttons[i].update();
    if (buttons[i].over()) {
      lineColour = buttons[i].basecolor;
    }
  }
  
}

void mouseDragged() {
  
  pPoint = new PVector(pmouseX, pmouseY);
  cPoint = new PVector(mouseX, mouseY);

  // draw line
  if (mousePressed && (mouseButton == LEFT)) {
    stroke(lineColour);
    noFill();
    beginShape();
    PVector midPoint1 = midPoint(ppPoint, pPoint);
    PVector midPoint2 = midPoint(pPoint, cPoint);
    vertex(midPoint1.x, midPoint1.y);
    quadraticVertex(pmouseX, pmouseY, midPoint2.x, midPoint2.y);
    endShape();
  }

  ppPoint = new PVector(pmouseX, pmouseY);
  
} 
 
void clearDrawing() {
  background(0);
  drawButtons();
}

void saveDrawing() {


}
 
PVector midPoint(PVector p1, PVector p2) {
   return new PVector((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
} 

 
// CLASS Button
class Button {

  int x, y;
  int size;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean locked;
  boolean over = false;
  boolean pressed = false;   

  void update() {
    if(over()) {
      currentcolor = highlightcolor;
    } else {
      currentcolor = basecolor;
    }
  }

  boolean pressed() {
    if(over) {
      locked = true;
      return true;
    } else {
      locked = false;
      return false;
    }    
  }

  boolean over() { 
    return true; 
  }

  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }

  boolean overCircle(int x, int y, int diameter) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
      return true;
    } else {
      return false;
    }
  }

}

// CLASS rectbutton
class RectButton extends Button {

  RectButton(int ix, int iy, int isize, color icolor) {
    x = ix;
    y = iy;
    size = isize;
    basecolor = icolor;
    highlightcolor = icolor;
    currentcolor = basecolor;
  }

  boolean over() {
    if( overRect(x, y, size, size) ) {
      over = true;
      return true;
    } else {
      over = false;
      return false;
    }
  }

  void display() {
    stroke(0);
    strokeWeight(1);
    fill(currentcolor);
    rect(x, y, size, size);
    strokeWeight(lineWeight);
  }

}
