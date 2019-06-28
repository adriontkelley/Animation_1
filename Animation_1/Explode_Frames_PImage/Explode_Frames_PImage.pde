/**
 * Explode 
 * by Daniel Shiffman. 
 * 
 * Mouse horizontal location controls breaking apart of image and 
 * Maps pixels from a 2D image into 3D space. Pixel brightness controls 
 * translation along z axis. 
 */
 
 ///modified by Adrion T. Kelley 2018
 
 int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;

PImage img;       // The source image
int cellsize = 2; // Dimensions of each cell in the grid
int columns, rows;   // Number of columns and rows in our system

void setup() {
  size(1000, 600, P3D); 
  
  
  frameRate(6);
  
  //img = loadImage(name + "." + type);
  for (int i = 1; i < numFrames; i++) {
        imageName = "Art_" + nf(i, 4) + ".png";
        images[i] = loadImage(imageName);

          println(imageName);
        //delay(1000);
       }
  
  
 
  
  img = new PImage(568,320);
  
  columns = img.width / cellsize;  // Calculate # of columns
  rows = img.height / cellsize;  // Calculate # of rows
}

void draw() {
  background(0);
  
  count++;
       if(count == images.length) count = 1;
    img.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, img.width, img.height);
  
  // Begin loop for columns
  for ( int i = 0; i < columns; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2;  // x position
      int y = j*cellsize + cellsize/2;  // y position
      int loc = x + y*img.width;  // Pixel array location
      color c = img.pixels[loc];  // Grab the color
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (mouseX / float(width)) * brightness(img.pixels[loc]) - 20.0;
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x + 200, y + 100, z);
      fill(c, 204);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();
    }
  }
  
  //saveFrame("output/Art_####.png");
}