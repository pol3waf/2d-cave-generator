void setup()
{
  size(512, 512);
  background(255);
  
  Noise noise = new Noise();
  
//  noise.drawRandomNoise(256, width, height, 5);
  
  String primitiveType = "circle";
  
  int scaleFactor = 4;
  int imageWidth = width;
  int imageHeight = height;
  int iterations = 5;
  int fillProbability = 40;
  int tunnelSeeds = 100;
  int tunnelTurnProbability = 10;
  int maxTunnelLength = 20;
  
  Cave cave = new Cave();
  
  cave.drawCave(primitiveType, scaleFactor, imageWidth, imageHeight, iterations, fillProbability, tunnelSeeds, tunnelTurnProbability, maxTunnelLength);
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
  String primitiveType = "circle";
  
  int scaleFactor = 4;
  int imageWidth = width;
  int imageHeight = height;
  int iterations = 5;
  int fillProbability = 40;
  int tunnelSeeds = 100;
  int tunnelTurnProbability = 10;
  int maxTunnelLength = 100;
    
  Cave cave = new Cave();
  
  cave.drawCave(primitiveType, scaleFactor, imageWidth, imageHeight, iterations, fillProbability, tunnelSeeds, tunnelTurnProbability, maxTunnelLength);
}