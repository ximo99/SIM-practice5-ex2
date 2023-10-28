// Wave Gerstner
class WaveGerstner extends Wave
{
  public WaveGerstner(float _a,PVector _srcDir, float _L, float _C)
  {
    super(_a, _srcDir, _L, _C);
    D.normalize();
  }
  
  public PVector getVariation(float x, float y, float z, float time)
  {
    tmp.x = 0.8f * A * D.x * sin(W * (D.x * x + D.z * z) + time * phi);
    tmp.z = 0.8f * A * D.z * sin(W * (D.x * x + D.z * z) + time * phi);
    tmp.y = A * cos(W * (D.x * x + D.z * z) + time * phi);
    
    return tmp;
  }
}
