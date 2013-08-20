class SmallColor
{
  final int r;
  final int g;
  final int b;

  SmallColor(int pr, int pg, int pb)
  {
    r = pr; 
    g = pg; 
    b = pb;
  }
  int[] GetColor()
  {
  //  return color(r, g, b);
    int[] cane = {r,g,b};
    return cane;

  }

  int hashCode()
  {
    return (r * GRANULARITY + g) * GRANULARITY + b;
  }
  boolean equals(Object o)
  {
    SmallColor sc = (SmallColor) o;
    return r == sc.r && g == sc.g && b == sc.b;
  }
}

int[] img_to_color(PImage img) 
{
  HashMap colors = new HashMap(GRANULARITY * GRANULARITY * GRANULARITY);

  img.resize(int(img.width*0.3), int(img.height*0.3));


  for (int i = 0; i < img.pixels.length; i++) 
  {
    SmallColor sc = new SmallColor(
    (int) red(img.pixels[i]), 
    (int) green(img.pixels[i]), 
    (int) blue(img.pixels[i]));
    Integer frequency = (Integer) colors.get(sc);
    if (frequency == null)
    {
      // Not in map yet
      Integer value = Integer.valueOf(1);
      colors.put(sc, value);
    }
    else
    {
      Integer value = Integer.valueOf(1 + frequency);
      colors.put(sc, value);
    }
  }
  
    int colorNb = colors.size();
  println(colorNb + " colors ranges found");

  ArrayList listOfColors = new ArrayList(colors.entrySet());
  Collections.sort(listOfColors, new Comparator()
  {
    public int compare(Object o1, Object o2)
    {
      Map.Entry entry1 = (Map.Entry) o1;
      Map.Entry entry2 = (Map.Entry) o2;
      int val1 = (Integer) entry1.getValue();
      int val2 = (Integer) entry2.getValue();
      if (val1 == val2)
        return 0;
      if (val1 < val2)
        return 1;
      return -1;
    }
  
});


final int diam = 20;
  noStroke();
  fill(GRANULARITY);
  rect(width - 2 * diam, 0, 2 * diam, height);
  int max = 10;
  //
  
   
    for (int i = 0; i < 10; i++)
  {
     Map.Entry me1 = (Map.Entry) listOfColors.get(i);
    SmallColor top1 = (SmallColor) me1.getKey();

    int[]avoid={16,16,16};
    int[]avoid2={0,0,0};
    if(!Arrays.equals(top1.GetColor(),avoid)&&
    top1.GetColor()[0]!=top1.GetColor()[1]&&top1.GetColor()[1]!=top1.GetColor()[2])
    {
      return top1.GetColor();
    }
    
  }
  
 Map.Entry me1 = (Map.Entry) listOfColors.get(1);
    SmallColor top1 = (SmallColor) me1.getKey();
    return top1.GetColor();
    //
/*  for (int i = 0; i < max; i++)
  {
    Map.Entry me = (Map.Entry) listOfColors.get(i);
    SmallColor top = (SmallColor) me.getKey();
    return top.GetColor();
    //println((Integer) me.getValue() + " " + hex(top.GetColor()));
    fill(top.GetColor()[0],top.GetColor()[0],top.GetColor()[0]);
    ellipse(width - diam, diam + i * diam * 2, diam, diam);
    //background(top.GetColor());
  }
  */
  
}

