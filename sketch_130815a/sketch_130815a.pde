import java.util.*;
import java.awt.image.BufferedImage;
import java.awt.*;
final int GRANULARITY = 16;
float lastTime;
void setup()
{

  size(500, 500);
  colorMode(RGB, GRANULARITY);
  PImage img = getScreen();
  int[]colors=img_to_color(img);
  background(colors[0], colors[1], colors[2]);
} 
void draw() {
  println(int(frameRate));
  if ( millis() - lastTime >= 5000) {
    lastTime = millis();

    println("ciao");
    colorMode(RGB, GRANULARITY);
    PImage img = getScreen();
    int[]colors=img_to_color(img);
    background(colors[0], colors[1], colors[2]);
  }
}

PImage getScreen() {
  GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
  GraphicsDevice[] gs = ge.getScreenDevices();
  DisplayMode mode = gs[0].getDisplayMode();
  Rectangle bounds = new Rectangle(0, 0, mode.getWidth(), mode.getHeight());
  BufferedImage desktop = new BufferedImage(mode.getWidth(), mode.getHeight(), BufferedImage.TYPE_INT_RGB);

  try {
    desktop = new Robot(gs[0]).createScreenCapture(bounds);
  }
  catch(AWTException e) {
    System.err.println("Screen capture failed.");
  }

  return (new PImage(desktop));
}

