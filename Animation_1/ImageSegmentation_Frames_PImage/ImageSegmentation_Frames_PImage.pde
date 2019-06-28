// Segments the image into superpixels.  These can be used a pre-processing step in
// recognition or as an intelligent image filter.  When you click on the image it will
// switch between a view of the randomly colorized segments and the input image


///modified by Adrion T. Kelley 2018

import boofcv.processing.*;
import boofcv.struct.image.*;
import boofcv.factory.segmentation.*;

int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;



PImage input,visualized;

void setup() {
  size(568, 320,P3D);

  frameRate(1);
  
  for (int i = 1; i < numFrames; i++) {
        imageName = "Art_" + nf(i, 4) + ".png";
        images[i] = loadImage(imageName);

          println(imageName);
        //delay(1000);
       }
  
  

 // img which will be sent to detection (a smaller copy of the cam frame);
  input = new PImage(568,320);

  //surface.setSize(input.width, input.height);
}

void draw() {
  background(0);
  
  
  
  
  
  

    count++;
       if(count == images.length) count = 1;
    input.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, input.width, input.height);
   

  // Convert the image into a simplified BoofCV data type
  SimpleColor bcolor = Boof.colorMS(input,ImageDataType.F32);

  // Declare the image segmentation algorithm
  SimpleImageSegmentation segmentator = Boof.segmentSlic(new ConfigSlic(400),bcolor.getImageType());
//  SimpleImageSegmentation segmentator = Boof.segmentFH04(null,bcolor.getImageType());
//  SimpleImageSegmentation segmentator = Boof.segmentMeanShift(null,bcolor.getImageType());
//  SimpleImageSegmentation segmentator = Boof.segmentWatershed(null,bcolor.getImageType());

  // Segment the image
  segmentator.segment(bcolor);

  // visualize the results
  visualized = segmentator.getOutput().visualize();
  
  if( mousePressed ) {
    image(input, 0, 0);
  } else {
    image(visualized, 0, 0);
  }
  
  //saveFrame("output/Art_####.png");
}