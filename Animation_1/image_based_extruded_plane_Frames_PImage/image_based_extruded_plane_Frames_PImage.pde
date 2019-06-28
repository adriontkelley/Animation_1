///modified by Adrion T. Kelley 2018



int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;


int count2  = 0;
int numFrames2 = 11;  // The number of frames in the animation
int currentFrame2 = 0;
PImage[] images2 = new PImage[numFrames2];
String imageName2;


PImage heightMap; 
PImage colorMap;
float planeWidth;
float planeHeight;
PVector[][]vecs;

void setup() {
  size(1600, 1000, P3D);
  
  frameRate(1);
  
  for (int i = 0; i < numFrames; i++) {
        imageName = "Art2_" + nf(i, 4) + ".png";
        images[i] = loadImage(imageName);

          println(imageName + "\t");
        //delay(1000);
       }

  
  for (int i = 0; i < numFrames2; i++) {
        imageName2 = "Art_" + nf(i, 4) + ".png";
        images2[i] = loadImage(imageName2);

          println("\t" + imageName2);
        //delay(1000);
       }
  
  
  

  noStroke();
  fill(255);
  
  heightMap = new PImage(568,320);
  colorMap = new PImage(320,568);
  
  
  //heightMap = loadImage("1.png");
  //colorMap = loadImage("2.png");
  
  
  planeWidth = heightMap.width;
  planeHeight = heightMap.height;

  vecs = new PVector[int(planeHeight)][int(planeWidth)];
  
  
  
  

  
}

void draw() {
  background(0);
  
   
  
  
  translate(width/2, height/2, 200);
  rotateX(map(mouseX, 0, width, -PI, PI));
  //rotateY(frameCount*.3*PI/180);
  //rotateZ(mouseX);
 
  ambientLight(85, 85, 85);
  emissive(20, 0, 0);
  lightSpecular(255, 255, 255);
  pointLight(255, 255, 255, 100, -100, 400);
  specular(255, 255, 255);
  shininess(100);
  
   
 
  
  count++;
       if(count == images.length) count = 1;
    heightMap.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, heightMap.width, heightMap.height);
       
  
  
  
  heightMap.loadPixels();
  for (int i=0; i<planeHeight; i++) {
    for (int j=0; j<planeWidth; j++) {
      vecs[i][j] = new PVector(-planeWidth/2+j, -brightness(heightMap.pixels[i * int(planeWidth) + j])*.25, -planeHeight/2+i);
    }
  }
  
  
 


  textureMode(IMAGE);
  beginShape(QUADS);
  
  
   count2++;
       if(count2 == images2.length) count2 = 1;
    colorMap.copy(images2[count2], 0, 0, images2[count2].width, images2[count2].height, 
        0, 0, colorMap.width, colorMap.height);
   
   
  
  
  texture(colorMap);
 
  
  for (int i=0; i<planeHeight-1; i++) {
    for (int j=0; j<planeWidth-1; j++) {
      
      vertex(vecs[i][j].x, vecs[i][j].y, vecs[i][j].z, i, j);
      vertex(vecs[i+1][j].x, vecs[i+1][j].y, vecs[i+1][j].z, i+1, j);
      vertex(vecs[i+1][j+1].x, vecs[i+1][j+1].y, vecs[i+1][j+1].z, i+1, j+1);
      vertex(vecs[i][j+1].x, vecs[i][j+1].y, vecs[i][j+1].z, i, j+1);
    }
  }
  endShape();
 
  //saveFrame("output/Art_####.png");
  
}