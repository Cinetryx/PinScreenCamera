/**
* An indivdual pin. This handles rendering itself and not much else.
**/
class Pin {

  private final static int HEIGHT = 10;
  private final static int SIDE_COUNT = 8; 
  private int x;
  private int y;
  private int size;

  public Pin(int x, int y, int size) {
    this.x=x;
    this.y=y;
    this.size=size;
  }

  public void render() {
    //set the color to grayish
    fill(180);
    pushMatrix();
    translate(x, y, 0);
    //rotate the cylinder so it faces the correct way
    rotateX(PI/2);
    //divide the size in half to get the radius of the cylinder
    drawCylinder(size*.5, size*.5, HEIGHT, SIDE_COUNT);
    popMatrix();
  }

  //The below was taken from processing.org/examples/vertices.html, since all of the cylinder drawing libraries
  //are not compatible with processing 3 quite yet.
  void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
    float angle = 0;
    float angleIncrement = TWO_PI / sides;
    beginShape(QUAD_STRIP);
    for (int i = 0; i < sides + 1; ++i) {
      vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
      vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
      angle += angleIncrement;
    }
    endShape();

    // If it is not a cone, draw the circular top cap
    if (topRadius != 0) {
      angle = 0;
      beginShape(TRIANGLE_FAN);

      // Center point
      vertex(0, 0, 0);
      for (int i = 0; i < sides + 1; i++) {
        vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
        angle += angleIncrement;
      }
      endShape();
    }

    // If it is not a cone, draw the circular bottom cap
    if (bottomRadius != 0) {
      angle = 0;
      beginShape(TRIANGLE_FAN);

      // Center point
      vertex(0, tall, 0);
      for (int i = 0; i < sides + 1; i++) {
        vertex(bottomRadius * cos(angle), tall, bottomRadius * sin(angle));
        angle += angleIncrement;
      }
      endShape();
    }
  }
}