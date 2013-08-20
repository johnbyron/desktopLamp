import java.util.*;
import processing.serial.*;
import cc.arduino.*;
import java.awt.image.BufferedImage;
import java.awt.*;
final int GRANULARITY = 12;
float lastTime;
Arduino arduino;
int R = 9;
int G = 10;
int B = 11;
void setup()
{
arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(R, Arduino.OUTPUT);
    arduino.pinMode(G, Arduino.OUTPUT);

  arduino.pinMode(B, Arduino.OUTPUT);

  size(500, 500);
  colorMode(RGB, GRANULARITY);
  PImage img = getScreen();
  int[]colors=img_to_color(img);
  background(colors[0], colors[1], colors[2]);
} 
void draw() {
  //println(int(frameRate));
  if ( millis() - lastTime >= 500) {
    lastTime = millis();

    println("ciao");
    colorMode(RGB, GRANULARITY);
    PImage img = getScreen();
    int[]colors=img_to_color(img);
    background(colors[0], colors[1], colors[2]);
    println(colors[0]+" "+ colors[1]+" "+colors[2]);
    int r = int(map(colors[0],0,GRANULARITY,0,255));
        int g = int(map(colors[1],0,GRANULARITY,0,255));
            int b = int(map(colors[2],0,GRANULARITY,0,255));
    arduino.analogWrite(R, int(r));
        arduino.analogWrite(G, int(g));

    arduino.analogWrite(B, int(b));

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

