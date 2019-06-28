// ContourMap2 by Cedric Kiefer
// http://www.onformative.com/lab/creating-contour-maps/

// Note
// if you encounter a "memory error" try to modify the "levels" variable

///modified by Adrion T. Kelley 2018


import blobDetection.*;
import peasy.*;
PeasyCam cam;


int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;


PImage img;

float levels = 35;                    // number of contours
float factor = 1;                     // scale factor
float elevation = 50;                 // total height of the 3d model

float colorStart =  0;               // Starting dregee of color range in HSB Mode (0-360)
float colorRange =  160;             // color range / can also be negative

// Array of BlobDetection Instances
BlobDetection[] theBlobDetection = new BlobDetection[int(levels)];

void setup() {
  size(1000,800,P3D);  
  
  
   smooth();
    frameRate(1);
    
  for (int i = 1; i < numFrames; i++) {
        imageName = "Art_" + nf(i, 4) + ".png";
        images[i] = loadImage(imageName);

          println(imageName);
        //delay(1000);
       }

  
  
  
  img = new PImage(568,320);
  
  
  
  cam = new PeasyCam(this,500);
  colorMode(HSB,360,100,100);	

 
}

void draw() { 
  background(0);
  
  
  count++;
       if(count == images.length) count = 1;
    img.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, img.width, img.height);
  
  
  
   //Computing Blobs with different thresholds 
  for (int i=0 ; i<levels ; i++) {
    theBlobDetection[i] = new BlobDetection(img.width, img.height);
    theBlobDetection[i].setThreshold(i/levels);
    theBlobDetection[i].computeBlobs(img.pixels);
  }
  
  
  translate(-img.width*factor/2,-img.height*factor/2);

  for (int i=0 ; i<levels ; i++) {
    translate(0,0,elevation/levels);	
    drawContours(i);
  }
  
  //saveFrame("output/Art_####.png");
}


void drawContours(int i) {
  Blob b;
  EdgeVertex eA,eB;
  for (int n=0 ; n<theBlobDetection[i].getBlobNb() ; n++) {
    b=theBlobDetection[i].getBlob(n);
    if (b!=null) {
      stroke((i/levels*colorRange)+colorStart,100,100);
      for (int m=0;m<b.getEdgeNb();m++) {
        eA = b.getEdgeVertexA(m);
        eB = b.getEdgeVertexB(m);
        if (eA !=null && eB !=null)
          line(
          eA.x*img.width*factor, eA.y*img.height*factor, 
          eB.x*img.width*factor, eB.y*img.height*factor 
            );
      }
    }
  }
}