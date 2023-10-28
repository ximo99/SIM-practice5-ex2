class HeightMap
{
  private final int mapSize;
  private final float cellSize;
  
  private float initPos[][][];
  private float pos[][][];
  private float tex[][][];
  
  protected ArrayList<Wave> waves;
  private Wave waveArray[];
  
  public HeightMap(int mapSize, float cellSize)
  {
    this.mapSize = mapSize;
    this.cellSize = cellSize;
    initGridPositions();
    initTextValues();
    
    waves = new ArrayList<Wave>();
    waveArray = new Wave[0];
  }
  
  private void initGridPositions()
  {
    float startPos = -mapSize*cellSize/2f;
    pos = new float[mapSize][mapSize][3];
    initPos = new float[mapSize][mapSize][3];
    
    for(int i = 0; i < mapSize; i++)
    {
      for(int j = 0; j < mapSize; j++)
      {
        pos[i][j][0] = startPos + j * cellSize;  // coordenada X
        pos[i][j][1] = 0;                        // coordenada Y
        pos[i][j][2] = startPos + i * cellSize;  // coordenada Z
        
        initPos[i][j][0] = pos[i][j][0];
        initPos[i][j][1] = pos[i][j][1];
        initPos[i][j][2] = pos[i][j][2];
      }
    }
  }
  
  private void initTextValues()
  {
    tex = new float[mapSize][mapSize][2];
    float mapSizeCasted = (float)mapSize;
    int i, j;
    for(i = 0; i < mapSize; i++)
    {
      for(j = 0; j < mapSize; j++)
      {
        tex[i][j][0] = j / mapSizeCasted * image.width;
        tex[i][j][1] = i / mapSizeCasted * image.height;
      }
    }
  }
  
  
  public void update()
  {
    //Pass arraylist to array to iterate quicker
    waveArray = waves.toArray(waveArray);
    
    //Declarations
    int i, j, k, len = waveArray.length;
    PVector variation;
    float time = millis()/1000f;
    
    //Iterate over arrays
    for(i = 0; i < mapSize; i++)
    {
      for(j = 0; j < mapSize; j++)
      {
        //Reset positions
        pos[i][j][0] = initPos[i][j][0];
        pos[i][j][1] = initPos[i][j][1];
        pos[i][j][2] = initPos[i][j][2];
        
        //Iterate through waves
        for(k = 0; k < len; k++)
        {
          variation = waveArray[k].getVariation(initPos[i][j][0],initPos[i][j][1],initPos[i][j][2],time);
          pos[i][j][0] += variation.x;
          pos[i][j][1] += variation.y;
          pos[i][j][2] += variation.z;
        }
      }
    }
  }
  
  public void present()
  {
    noStroke();
    fill(0xffffffff);
    beginShape(TRIANGLES);
    texture(image);
    
    for(int i = 0; i < mapSize - 1; i++)
    {
      for(int j = 0; j < mapSize - 1; j++)
      {
        vertex(pos[i][j][0], pos[i][j][1], pos[i][j][2], tex[i][j][0],tex[i][j][1]);
        vertex(pos[i+1][j][0], pos[i+1][j][1], pos[i+1][j][2], tex[i+1][j][0],tex[i+1][j][1]);
        vertex(pos[i+1][j+1][0], pos[i+1][j+1][1], pos[i+1][j+1][2], tex[i+1][j+1][0],tex[i+1][j+1][1]);
        
        vertex(pos[i][j][0], pos[i][j][1], pos[i][j][2], tex[i][j][0],tex[i][j][1]);
        vertex(pos[i+1][j+1][0], pos[i+1][j+1][1], pos[i+1][j+1][2],tex[i+1][j+1][0],tex[i+1][j+1][1]);
        vertex(pos[i][j+1][0], pos[i][j+1][1], pos[i][j+1][2], tex[i][j+1][0],tex[i][j+1][1]);
      }
    }
    endShape();
  }
  
  public void presentWired()
  {
    stroke(0xff000000);
    noFill();
    beginShape(TRIANGLES);
    
    for(int i = 0; i < mapSize - 1; i++)
    {
      for(int j = 0; j < mapSize - 1; j++)
      {
        vertex(pos[i][j][0], pos[i][j][1], pos[i][j][2], tex[i][j][0],tex[i][j][1]);
        vertex(pos[i+1][j][0], pos[i+1][j][1], pos[i+1][j][2], tex[i+1][j][0],tex[i+1][j][1]);
        vertex(pos[i+1][j+1][0], pos[i+1][j+1][1], pos[i+1][j+1][2], tex[i+1][j+1][0],tex[i+1][j+1][1]);
        
        vertex(pos[i][j][0], pos[i][j][1], pos[i][j][2], tex[i][j][0],tex[i][j][1]);
        vertex(pos[i+1][j+1][0], pos[i+1][j+1][1], pos[i+1][j+1][2], tex[i+1][j+1][0],tex[i+1][j+1][1]);
        vertex(pos[i][j+1][0], pos[i][j+1][1], pos[i][j+1][2], tex[i][j+1][0],tex[i][j+1][1]);
      }
    }
    endShape();
  }
  
  public void addWave(Wave wave)
  {
    waves.add(wave);
  }
}
