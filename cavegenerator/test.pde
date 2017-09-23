void setup()
{
  size(512, 512, P2D);
  background(255);
  
//  drawRandomNoise(256, width, height, 7);
  
  int scaleFactor = 4;
  int imageWidth = width;
  int imageHeight = height;
  int iterations = 5;
  int fillProbability = 40;
  int tunnelSeeds = 100;
  int tunnelTurnProbability = 10;
  int maxTunnelLength = 20;
  
  CaveGenerator cg = new CaveGenerator();
  
  cg.drawCave(scaleFactor, imageWidth, imageHeight, iterations, fillProbability, tunnelSeeds, tunnelTurnProbability, maxTunnelLength);
}

void draw()
{
  
}



void keyPressed()
{
  if (key == 'r' || key == 'R')
  {
    redrawScene();
  }
}

void redrawScene()
{
  int scaleFactor = 4;
  int imageWidth = width;
  int imageHeight = height;
  int iterations = 5;
  int fillProbability = 40;
  int tunnelSeeds = 100;
  int tunnelTurnProbability = 10;
  int maxTunnelLength = 100;
    
  CaveGenerator cg = new CaveGenerator();
  
  cg.drawCave(scaleFactor, imageWidth, imageHeight, iterations, fillProbability, tunnelSeeds, tunnelTurnProbability, maxTunnelLength);
}