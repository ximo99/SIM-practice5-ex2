// Wave
abstract class Wave
{
  
  protected PVector tmp;
  
  protected float A, C, W, Q, phi;
  protected PVector D; // Direction or epicenter of the wave
  
  public Wave(float _a,PVector _srcDir, float _L, float _C)
  {
    tmp = new PVector();
    C = _C;
    A = _a;
    D = new PVector().add(_srcDir);
    W = PI * 2f / _L;
    Q = PI * _C * 2f * _a /_L;
    phi = C * W;
  }
  
  abstract PVector getVariation(float x, float y, float z, float time);
}
