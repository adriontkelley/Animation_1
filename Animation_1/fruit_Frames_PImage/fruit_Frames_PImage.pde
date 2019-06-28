  ///modified by Adrion T. Kelley 2018


int drawMode = 0;
int drawSpeed = 6000; 
color bgcolor = color(255);
color pgcolor = color(0);

int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;





PImage img;


void setup() {
  size(568, 320);
  background(bgcolor); 
  colorMode(HSB, 360, 100, 100); 
  rectMode(CENTER);
  frameRate(10);
  
  
  for (int i = 1; i < numFrames; i++) {
        imageName = "Art_" + nf(i, 4) + ".png";
        images[i] = loadImage(imageName);

          println(imageName);
        //delay(1000);
       }

  
  
  
  img = new PImage(568,320);




  
}

void draw() {
  
  
  count++;
       if(count == images.length) count = 1;
    img.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, img.width, img.height);
  
  
  
  switch (drawMode) {
  case 0:
  for (int i=0; i<drawSpeed; i++) {

    int x = (int) random(width);
    int y = (int) random(height);
    
    boolean insideText = (img.get(x, y) == pgcolor);
 
    if (insideText) {      
      pushMatrix();
      translate(x, y);
        float er = random(5,9);
        color ec = color(random(70, 130), 90, 95);
        stroke(0, 170);
        fill(ec);
        ellipse(0, 0, er, er);
       popMatrix();
    } else{
      pushMatrix();
      translate(x, y);
      float er = random(5, 7);
      color ec = color(random(40, 45), 30, 60);
      stroke(0, 170);
      fill(ec);
      ellipse(0, 0, er, er); 
      popMatrix();
    }    
  }
  break;
  case 1:
  for (int i=0; i<drawSpeed; i++) {

    int x = (int) random(width);
    int y = (int) random(height);
    
    boolean insideText2 = (img.get(x, y) == pgcolor);
 
    if (insideText2) {      
      pushMatrix();
      translate(x, y);
        float td = random(5, 7);
        float tr = random(TWO_PI);
        color tc = color(random(180, 200), random(0,13), 100);
        stroke(0,170);
        fill(tc);
        rotate(tr);
        triangle(0, -td, -td, td, td, td);
       popMatrix();
    } else{
      pushMatrix();
      translate(x, y);
      float td = random(4, 6);
      float tr = random(TWO_PI);
      color tc = color(random(170, 210), random(50,100), 100);
      stroke(0,170);
      fill(tc);
      rotate(tr);
      triangle(0, -td, -td, td, td, td);
      popMatrix();
    }    
  }
  break;
  
  
}

//saveFrame("output/Art_####.png");
}
void mousePressed() {
  background(bgcolor); 
  drawMode = ++drawMode%2; 
}