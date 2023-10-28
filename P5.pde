import peasy.*;
PeasyCam camera;

final int _MAP_SIZE         = 700;
final float _MAP_CELL_SIZE  = 10f;

boolean _viewmode = false;
boolean _clear    = false;

HeightMap map;
PImage image;
PImage fondo;

FloatList dx;
FloatList dz;
FloatList amplitude;
FloatList wavelength;
FloatList speed;

public void settings()
{
  System.setProperty("jogl.disable.openglcore", "true");
  size (1000, 990, P3D);
}

void setup()
{
  image = loadImage("water.jpg");
  fondo = loadImage("sky.jpg");
  
  camera = new PeasyCam(this, 100);
  camera.setDistance(3000);
  camera.rotateX(0.5);
  
  map = new HeightMap(_MAP_SIZE, _MAP_CELL_SIZE);
  //println(image.width + " : " + image.height);
}

void draw()
{
  //background(0, 160, 255);
  background(fondo);
  //lights();
  
  map.update();
  if(_viewmode)
    map.presentWired();
  else
    map.present();
    
  //presentAxis();
  drawInteractiveInfo();
  
  if(_clear) 
  {
    dx.clear();
    dz.clear();
    amplitude.clear();
    wavelength.clear();
    speed.clear();
  }
}

void drawInteractiveInfo()
{
  float textSize = 60;
  float offsetX  = -300;
  float offsetZ  = 0;
  float offsetY  = -1400;
  
  int i = 0;
  
  noStroke();
  textSize(textSize);
  fill(0xff000000);
  
  text("1: rought sea", offsetX, offsetY + textSize * (++i), offsetZ);
  text("2: calm sea", offsetX, offsetY + textSize * (++i), offsetZ);
}

void roughtSea()
{
  dx = new FloatList();
  dx.append(1+random(1f));
  dx.append(0.0);
  dx.append(-1.5f);
  dx.append(-1.5f);
  dx.append(1.5f);
  
  dz = new FloatList();
  dz.append(1.5f);
  dz.append(0.5f);
  dz.append(1.5f);
  dz.append(1.5f);
  dz.append(-1.5f);
  
  amplitude = new FloatList();
  amplitude.append(20.0f);
  amplitude.append(10.0f);
  amplitude.append(45.0f);
  amplitude.append(85.0f);
  amplitude.append(85.0f);
  
  wavelength = new FloatList();
  wavelength.append(amplitude.get(0) * (30));
  wavelength.append(amplitude.get(0) * (40));
  wavelength.append(amplitude.get(0) * (70));
  wavelength.append(amplitude.get(0) * (100));
  wavelength.append(amplitude.get(0) * (100));
  
  speed = new FloatList();
  speed.append(wavelength.get(0)/(2.0));
  speed.append(wavelength.get(0)/(3.0));
  speed.append(wavelength.get(0)/(3.0));
  speed.append(wavelength.get(0)/(4.0));
  speed.append(wavelength.get(0)/(40.0));
}

void calmSea()
{
  dx = new FloatList();
  dx.append(1+random(1f));
  dx.append(-1.5f);
  dx.append(1.5f);
  
  dz = new FloatList();
  dz.append(-1.5f);
  dz.append(1.0f);
  dz.append(1.5f);

  amplitude = new FloatList();
  amplitude.append(15.0f);
  amplitude.append(20.0f);
  amplitude.append(35.0f);
 
  wavelength = new FloatList();
  wavelength.append(amplitude.get(0) * (30));
  wavelength.append(amplitude.get(0) * (40));
  wavelength.append(amplitude.get(0) * (100));

  speed = new FloatList();
  speed.append(wavelength.get(0)/(40));
  speed.append(wavelength.get(0)/(3.5));
  speed.append(wavelength.get(0)/(3.0));
}

void keyPressed()
{
  if (key == '1')
  {  
    map.waves.clear();
    map.waveArray = new Wave[0];
    _clear = false;
    
    roughtSea();
    
    for (int i = 0; i < 5; i++)
      map.addWave(new WaveGerstner(amplitude.get(i), new PVector(dx.get(i), 0, dz.get(i)), wavelength.get(i), speed.get(i)));
  }
  
  if (key == '2')
  {
    map.waves.clear();
    map.waveArray = new Wave[0];
    _clear = true;
    
    calmSea();
    
    for (int i = 0; i < 3; i++){
      map.addWave(new WaveGerstner(amplitude.get(i), new PVector(dx.get(i), 0, dz.get(i)), wavelength.get(i), speed.get(i)));
    }
  }
}

void presentAxis()
{
  float axisSize = _MAP_SIZE * 2f;
  
  stroke(0xffff0000);
  line(0, 0, 0, axisSize, 0, 0);
  
  stroke(0xff00ff00);
  line(0, 0, 0, 0, -axisSize, 0);
  
  stroke(0xff0000ff);
  line(0, 0, 0, 0, 0, axisSize);
}
