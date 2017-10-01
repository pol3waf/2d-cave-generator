public class Noise
{
  
  public Noise()
  {
    
  }
  
  void drawRandomNoise(
      int scaleFactor, 
      int totalWidth, 
      int totalHeight, 
      int iterations
      )
{
  noStroke();
  
  float alphaColor = 255 / iterations;
    
  while (iterations > 0)
  {
    float gridSizeX = totalWidth / scaleFactor;
    float gridSizeY = totalHeight / scaleFactor;
    
    for (int i=0; i<gridSizeX; i++)
    {
      for (int j=0; j<gridSizeY; j++)
      {
        float fillColor = random(255);
        fill(fillColor, alphaColor);
        rect(i*scaleFactor, j*scaleFactor, (i+1)*scaleFactor, (j+1)*scaleFactor);
      }
    }
    scaleFactor = scaleFactor / 2; 
    iterations--;
  }
  
}
  
}