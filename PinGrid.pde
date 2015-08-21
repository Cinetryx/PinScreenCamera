/**
 *  The whole gird of pins. This handles building the intial list of pins, as well
 *  as figuring out where to put them based on the camera image. Since most cameras don't
 *  have depth sensors quite yet, this just uses the brightness of each pixel to determine
 *  how far forward to move each pin. It isn't perfect, but it makes for a cool effect.
 **/
class PinGrid {
  //The amount to divide the brightness value by to get a displacement that looks good
  private static final int DISPLACEMENT_SCALE_FACTOR = 20;
  private Pin[][] pins;
  private int gridWidth;
  private int gridHeight;
  private Capture cam;

  PImage img;

  public PinGrid(int gridWidth, int gridHeight, int gridSpacing, int pinSize, Capture cam) {
    this.gridWidth=gridWidth;
    this.gridHeight=gridHeight;
    this.cam = cam;

    pins = buildGrid(gridWidth, gridHeight, gridSpacing, pinSize);
  }

  /**
   *  Builds up the grid of pins. 
   **/
  private Pin[][] buildGrid(int w, int h, int spacing, int size) {
    Pin[][] pins = new Pin[w][h];
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        pins[i][j] = new Pin(i *size +i*spacing, j*size+j*spacing, size);
      }
    }
    return pins;
  }


  public void render() {
    //Only render if a camera is available 
    if (cam.available() == true) {
      PImage frame = getImageFromCamera();
      //loop through all of the pins, displace them according to the brightness of 
      //the pixel found in the same place as the pin, and then render the pin
      for (int i = 0; i < gridWidth; i++) {
        for (int j = 0; j < gridHeight; j++) {
          pushMatrix();
          displacePin(frame, i, j);
          pins[i][j].render();
          popMatrix();
        }
      }
    }
  }

  //Grabs the next image from the camera and converts it to a PImage for easy access of pixels
  private PImage getImageFromCamera() {
    cam.read();
    PImage i = cam.get();
    return i;
  }

  //Based on the brightness of the pixel of the coordinates passed in, 
  //display the same pin
  private void displacePin(PImage image, int x, int y) {
    color c = image.get(x, y);
    float b = brightness(c);
    float zTranslate =b/DISPLACEMENT_SCALE_FACTOR; 
    translate(0, 0, zTranslate);
  }
}