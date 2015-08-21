/**
 *  Uses your webcam to move a grid of virtual pins, much like one of those Pin Art toys that 
 *  you played with as a child. Or last weekend. Either way still fun.
 * 
 */

import processing.video.*;

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;


private final static int WIDTH = 64;
private final static int HIEGHT = 48;
private final static int SPACING = 0;
private final static int PIN_SIZE = 1;
private final static int CAMERA_DISTANCE = 350;

private PinArt pinArt;
//determines if we should be saving frames, so that an animation can be created
private boolean saveFrames = false;

void setup() {
  size(640, 480, P3D);
  //Set the camera to capture the same number of pixels as we have pins. This way we don't
  //need to combine the values of the pixels ourselves when they are used later to determine 
  //how far to move the pins
  Capture cam = new Capture(this, WIDTH, HIEGHT);
  cam.start();
  pinArt = new PinArt(WIDTH, HIEGHT, SPACING, PIN_SIZE, cam);
}

void draw() {
  //no outlines
  noStroke();
  //black background
  background(0); 
  //use lighting
  lights();
  //move the camera back far enough to see everything
  pushMatrix();
  translate(width/2, height/2, CAMERA_DISTANCE);
  pinArt.render();
  popMatrix();
  if(saveFrames){
    saveFrame();
  }
}

void keyPressed() {
  //every time a key is pressed, start/stop recording
  if(!saveFrames){
    println("Starting save frames");
  } else{
    println("Stoping save frames");
  }
  saveFrames = !saveFrames;
}