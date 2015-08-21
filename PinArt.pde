/**
* The whole thing. This will eventually have a background.
**/
class PinArt {

  private PinGrid pinGrid;
  
  private int translateX;
  private int translateY;

  public PinArt(int gridWidth, int gridHeight, int gridSpacing, int pinSize,Capture cam) {
    pinGrid = new PinGrid(gridWidth, gridHeight, gridSpacing, pinSize,cam);
    //Determines how far the whole grid needs to be displaced so that it is centered when rendered
    translateX = (gridWidth *pinSize +gridSpacing) /2;
    translateY = (gridHeight *pinSize +gridSpacing) /2;
  }

  public void render() {
    pushMatrix();
    translate(-translateX,-translateY,0);
    pinGrid.render();
    popMatrix();
  }
}